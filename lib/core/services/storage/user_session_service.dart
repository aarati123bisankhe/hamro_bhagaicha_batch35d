import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider for SharedPreferences
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'SharedPreferences must be initialized in main.dart',
  );
});

// Provider for UserSessionService
final userSessionServiceProvider = Provider<UserSessionService>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return UserSessionService(prefs: prefs);
});

class UserSessionService {
  final SharedPreferences _prefs;

  UserSessionService({required SharedPreferences prefs}) : _prefs = prefs;

  // Keys for storing session data
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserId = 'user_id';
  static const String _keyUserFullName = 'user_fullname';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserAddress = 'user_address';
  static const String _keyUserPhoneNumber = 'user_phone_number';

  // Save user session data
 Future<void> saveUserSession({
  required String userId,
  required String fullname,
  required String email,
  required String address,
  required String phoneNumber,
}) async {
  await _prefs.setBool(_keyIsLoggedIn, true);
  await _prefs.setString(_keyUserId, userId);
  await _prefs.setString(_keyUserFullName, fullname);
  await _prefs.setString(_keyUserEmail, email);
  await _prefs.setString(_keyUserAddress, address);
  await _prefs.setString(_keyUserPhoneNumber, phoneNumber);
}

  // Clear user session data
  Future<void> clearUserSession() async {
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyUserId);
    await _prefs.remove(_keyUserFullName);
    await _prefs.remove(_keyUserEmail);
    await _prefs.remove(_keyUserAddress);
    await _prefs.remove(_keyUserPhoneNumber);
    
  }

  // Check login status
  
  // Check if user is logged in
  bool isLoggedIn() {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Getters
  String? getUserId() => _prefs.getString(_keyUserId);

  String? getUserFullName() => _prefs.getString(_keyUserFullName);

  String? getUserEmail() => _prefs.getString(_keyUserEmail);

  String? getUserAddress() => _prefs.getString(_keyUserAddress);

  String? getUserPhoneNumber() => _prefs.getString(_keyUserPhoneNumber);
}
