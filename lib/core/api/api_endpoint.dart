import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static const int _defaultPort = 5050;
  static const String _apiPortOverride = String.fromEnvironment('API_PORT');

  // Full URL overrides (highest priority)
  // Example:
  // flutter run --dart-define=API_BASE_URL=http://192.168.1.70:5050/api
  // flutter run --dart-define=API_UPLOAD_BASE_URL=http://192.168.1.70:5050
  static const String apiBaseUrlOverride = String.fromEnvironment(
    'API_BASE_URL',
  );
  static const String apiUploadBaseUrlOverride = String.fromEnvironment(
    'API_UPLOAD_BASE_URL',
  );

  // Host overrides (useful for emulator vs physical device)
  // Example:
  // flutter run --dart-define=API_HOST=192.168.1.70
  // flutter run --dart-define=API_HOST_ANDROID=10.0.2.2
  // flutter run --dart-define=API_HOST_IOS=localhost
  static const String apiHost = String.fromEnvironment('API_HOST');
  static const String apiHostAndroid = String.fromEnvironment(
    'API_HOST_ANDROID',
  );
  static const String apiHostIos = String.fromEnvironment('API_HOST_IOS');

    static const String computerIpAddress = "192.168.31.74";

  // Backward compatibility for previous upload override key.
  static const String legacyUploadsBaseUrlOverride = String.fromEnvironment(
    'UPLOADS_BASE_URL',
  );

  static int get port {
    final parsed = int.tryParse(_apiPortOverride.trim());
    return parsed ?? _defaultPort;
  }

  static String get baseUrl {
    final override = _normalizeAbsoluteUrl(apiBaseUrlOverride);
    if (override != null) {
      return override;
    }
    return 'http://${_resolveHost()}:$port/api';
  }

  static String get uploadBaseUrl {
    final override =
        _normalizeAbsoluteUrl(apiUploadBaseUrlOverride) ??
        _normalizeAbsoluteUrl(legacyUploadsBaseUrlOverride);
    if (override != null) {
      return override;
    }
    return 'http://${_resolveHost()}:$port';
  }

  static String _resolveHost() {
    if (kIsWeb) return 'localhost';

    if (apiHost.trim().isNotEmpty) {
      return apiHost.trim();
    }

    if (Platform.isAndroid && apiHostAndroid.trim().isNotEmpty) {
      return apiHostAndroid.trim();
    }

    if (Platform.isIOS && apiHostIos.trim().isNotEmpty) {
      return apiHostIos.trim();
    }

    // Sensible defaults when no overrides are provided.
    // if (Platform.isAndroid) {
    //   return '10.0.2.2'; // Android emulator -> host machine
    // }

    if (Platform.isAndroid) {
  return computerIpAddress;
}
    if (Platform.isIOS) {
      return 'localhost'; // iOS simulator -> host machine
    }
    return 'localhost'; // macOS/Windows/Linux local development
  }

  static String? _normalizeAbsoluteUrl(String raw) {
    final value = raw.trim().replaceAll('"', '').replaceAll("'", '');
    if (value.isEmpty) return null;

    final repaired = value
        .replaceFirst(RegExp(r'^hwhattp://', caseSensitive: false), 'http://')
        .replaceFirst(RegExp(r'^htttp://', caseSensitive: false), 'http://')
        .replaceFirst(RegExp(r'^ttp://', caseSensitive: false), 'http://');

    final uri = Uri.tryParse(repaired);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      return null;
    }

    if (uri.scheme != 'http' && uri.scheme != 'https') {
      return null;
    }

    return repaired.endsWith('/')
        ? repaired.substring(0, repaired.length - 1)
        : repaired;
  }

  static String uploadUrl(String relativePath) {
    if (relativePath.startsWith('http')) return relativePath;

    final normalized = relativePath.replaceAll('\\\\', '/').trim();
    final cleaned = normalized.startsWith('/')
        ? normalized.substring(1)
        : normalized;

    return '$uploadBaseUrl/$cleaned';
  }

  static void debugPrintResolvedEndpoints() {
    // ignore: avoid_print
    print('ApiEndpoints.baseUrl=$baseUrl');
    // ignore: avoid_print
    print('ApiEndpoints.uploadBaseUrl=$uploadBaseUrl');
  }

  /// Profile image URL
  static String profileImageUrl(String fileName) {
    if (fileName.startsWith('http')) return fileName;
    if (fileName.contains('/') || fileName.contains('\\\\')) {
      return uploadUrl(fileName);
    }

    return uploadUrl('uploads/profile/$fileName');
  }

  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const String authLogin = '/auth/login';
  static const String authRegister = '/auth/register';
  static const String whoAmI = '/auth/whoami';
  static const String requestPasswordReset = '/auth/send-reset-password-email';
  static String resetPassword(String token) => '/auth/reset-password/$token';
  static String getCurrentUserById(String userId) => '/auth/user/$userId';

  static const String notifications = '/notifications';
  static const String markAllNotificationsRead = '/notifications/mark-all-read';
  static String markNotificationRead(String notificationId) =>
      '/notifications/$notificationId/read';

  static const String sendOrderConfirmationSms = '/sms/send-order-confirmation';
  static const String nearestNurseries = '/nurseries/nearest';

  // Replace with your real domain that hosts .well-known files.
  static const String deepLinkDomain = 'your-domain.com';
  static const String resetPasswordDeepLink =
      'https://$deepLinkDomain/reset-password';

  // Profile picture upload
  static const String updateProfileImage = '/auth/update-profile';
}
