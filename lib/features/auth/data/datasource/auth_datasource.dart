import 'package:hamro_bhagaicha_batch35d/features/auth/data/model/auth_hive_model.dart';

abstract interface class IAuthDatasource{
  Future<bool> register(AuthHiveModel model);
  Future<AuthHiveModel?> login(String email, String password);
  Future<AuthHiveModel?> getCurrentUser();
}