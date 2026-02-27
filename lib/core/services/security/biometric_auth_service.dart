import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

final biometricAuthServiceProvider = Provider<BiometricAuthService>((ref) {
  return BiometricAuthService(
    localAuth: LocalAuthentication(),
    secureStorage: const FlutterSecureStorage(),
  );
});

class BiometricAuthResult {
  final bool success;
  final String? message;

  const BiometricAuthResult({required this.success, this.message});
}

class BiometricAuthService {
  static const String _biometricTokenKey = 'biometric_login_token';

  final LocalAuthentication _localAuth;
  final FlutterSecureStorage _secureStorage;

  BiometricAuthService({
    required LocalAuthentication localAuth,
    required FlutterSecureStorage secureStorage,
  }) : _localAuth = localAuth,
       _secureStorage = secureStorage;

  Future<bool> isBiometricSupported() async {
    final issue = await getSupportIssueMessage();
    return issue == null;
  }

  Future<String?> getSupportIssueMessage() async {
    try {
      final isSupported = await _localAuth.isDeviceSupported();
      if (!isSupported) {
        return 'Biometric hardware is not supported on this device';
      }

      final canCheck = await _localAuth.canCheckBiometrics;
      if (!canCheck) {
        return 'No Face Lock enrolled or screen lock is not configured';
      }

      final available = await _localAuth.getAvailableBiometrics();
      if (available.isEmpty) {
        return 'No biometric type available. Add Face Lock in phone settings';
      }

      return null;
    } on PlatformException catch (e) {
      return _mapLocalAuthError(e);
    } catch (_) {
      return 'Biometric check failed on this device';
    }
  }

  Future<bool> hasStoredToken() async {
    final token = await _secureStorage.read(key: _biometricTokenKey);
    return token != null && token.isNotEmpty;
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _biometricTokenKey, value: token);
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: _biometricTokenKey);
  }

  Future<bool> authenticate() async {
    final result = await authenticateWithDetails();
    return result.success;
  }

  Future<BiometricAuthResult> authenticateWithDetails() async {
    try {
      final isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Verify Face Lock to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      if (!isAuthenticated) {
        return const BiometricAuthResult(
          success: false,
          message: 'Face Lock authentication was cancelled',
        );
      }

      return const BiometricAuthResult(success: true);
    } on PlatformException catch (e) {
      return BiometricAuthResult(
        success: false,
        message: _mapLocalAuthError(e),
      );
    } catch (_) {
      return const BiometricAuthResult(
        success: false,
        message: 'Could not verify Face Lock on this device',
      );
    }
  }

  Future<String?> getStoredToken() async {
    return _secureStorage.read(key: _biometricTokenKey);
  }

  String _mapLocalAuthError(PlatformException e) {
    final code = e.code.toLowerCase();

    if (code.contains('notenrolled')) {
      return 'No Face Lock enrolled. Please add Face Lock in phone settings';
    }
    if (code.contains('passcodenotset') || code.contains('notavailable')) {
      return 'Screen lock is not set. Please set PIN/Pattern/Password first';
    }
    if (code.contains('temporarylockout') ||
        code.contains('biometriclockout')) {
      return 'Too many attempts. Try again after unlocking your phone';
    }
    if (code.contains('permanentlockout')) {
      return 'Biometrics locked. Unlock phone with PIN and try again';
    }
    if (code.contains('usercancel')) {
      return 'Face Lock prompt was cancelled';
    }

    return e.message ?? 'Face Lock authentication failed';
  }
}
