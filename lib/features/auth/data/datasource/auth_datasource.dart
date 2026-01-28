import 'dart:io';

import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_api_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';

abstract interface class IAuthLocalDatasource {
   Future<bool> register(AuthHiveModel model);
  Future<AuthHiveModel?> login(String phoneNumber, String password);
  // Future<bool> isPhoneNumberExists(String phoneNumber);
  // Future<AuthHiveModel?> getUserByPhoneNumber(String phoneNumber);

   Future<bool> logout();

  Future<dynamic> isEmailExists(String email) async {}

  Future<dynamic> getUserByEmail(String s) async {}

  Future<dynamic> getCurrentUser() async {}

  Future<dynamic> updateProfileImage(File imageFile) async {}

  Future<void> saveCurrentUser(fromApiModel) async {}
}

abstract interface class IAuthRemoteDatasource {
  Future<AuthApiModel> register(AuthApiModel model);
  Future<AuthApiModel?> login(String phoneNumber, String password);

  Future<dynamic> updateProfileImage(File imageFile) async {}
}
