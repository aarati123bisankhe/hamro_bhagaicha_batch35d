import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/hive/hive_service.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/auth_datasource.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';

// Provider for AuthLocalDatasource
final authLocalDatasourceProvider = Provider<IAuthLocalDatasource>((ref) {
  final hiveService = ref.read(hiveServiceProvider);
  return AuthLocalDatasource(hiveService: hiveService);
});

class AuthLocalDatasource implements IAuthLocalDatasource {
  final HiveService _hiveService;

  AuthLocalDatasource({required HiveService hiveService})
      : _hiveService = hiveService;

  // Register user
  @override
  Future<bool> register (AuthHiveModel model) async {
    try {
      // Check if email already exists
      if (_hiveService.isEmailExists(model.email)) {
        throw Exception('Email already exists');
      }

      await _hiveService.registerUser(model);
      return true;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // Login user
  @override
  Future<AuthHiveModel?> login(String email, String password) async {
    try {
      final user = await _hiveService.loginUser(email, password);
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Get the current user (first user in Hive)
  @override
  Future<AuthHiveModel?> getCurrentUser() async {
    try {
      final users = _hiveService.getAllAuths();
      if (users.isNotEmpty) {
        return users.first;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  // Check if email exists
  @override
  Future<bool> isEmailExists(String email) async {
    try {
      final exists = _hiveService.isEmailExists(email);
      return exists;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<dynamic> getUserByEmail(String s) {
    // TODO: implement getUserByEmail
    throw UnimplementedError();
  }
  
  @override
  Future<AuthHiveModel?> getUserByPhoneNumber(String phoneNumber) {
    // TODO: implement getUserByPhoneNumber
    throw UnimplementedError();
  }
  
  @override
  Future<bool> isPhoneNumberExists(String phoneNumber) {
    // TODO: implement isPhoneNumberExists
    throw UnimplementedError();
  }
}
