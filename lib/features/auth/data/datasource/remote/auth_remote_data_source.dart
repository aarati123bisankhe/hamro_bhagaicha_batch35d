import 'package:hamro_bhagaicha_batch35d/features/auth/data/datasource/auth_datasource.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_api_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';

class AuthRemoteDataSource implements IAuthRemoteDatasource{
  @override
  Future<AuthApiModel?> login(String phoneNumber, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<AuthApiModel> register(AuthApiModel model) {
    // TODO: implement register
    throw UnimplementedError();
  }

}

abstract interface class IAuthLocalDatasource{
  Future<AuthHiveModel> register(AuthHiveModel model);
  Future<AuthHiveModel?> login(String phoneNumber,String password);
  Future<bool> isPhoneNumberExists(String phoneNumber);
  Future<AuthHiveModel?> getUserByPhoneNumber(String phoneNumber);
}