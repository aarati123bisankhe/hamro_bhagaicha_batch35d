import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_api_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';

abstract interface class IAuthLocalDatasource {
  Future<AuthHiveModel> register(AuthHiveModel model);
  Future<AuthHiveModel?> login(String phoneNumber, String password);
  Future<bool> isPhoneNumberExists(String phoneNumber);
  Future<AuthHiveModel?> getUserByPhoneNumber(String phoneNumber);
}

abstract interface class IAuthRemoteDatasource {
  Future<AuthApiModel> register(AuthApiModel model);
  Future<AuthApiModel?> login(String phoneNumber, String password);
}
