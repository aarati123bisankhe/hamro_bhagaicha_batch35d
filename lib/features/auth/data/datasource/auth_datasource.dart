import 'dart:io';

import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_api_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';

abstract interface class IAuthLocalDatasource {
  Future<AuthHiveModel?> register(AuthHiveModel user);
  Future<AuthHiveModel?> login(String email, String password);
  Future<AuthHiveModel?> getCurrentUser();
  Future<bool> logout();
  Future<AuthHiveModel?> getUserById(String authId);
  Future<AuthHiveModel?> getUserByEmail(String email);
  Future<bool> updateUser(AuthHiveModel user);
  Future<bool> deleteUser(String authId);
}

abstract interface class IAuthRemoteDatasource {
  Future<AuthApiModel> register(AuthApiModel model);
  Future<AuthApiModel?> login(String email, String password);
  Future<AuthApiModel?> getCurrentUserById(String userId);
  Future<String> updateProfileImage(File imageFile);
  Future<void> requestPasswordReset({
    required String email,
    required String platform,
    String? resetUrl,
  });
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });
}
