import 'package:hamro_bhagaicha_batch35d/core/config/hive_table_constant.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hive/hive.dart';

part 'auth_hive_model.g.dart';


@HiveType(typeId: HiveTableConstant.authTypeId)
class AuthHiveModel extends HiveObject{

  @HiveField(0)
  final String fullName;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String address;
  @HiveField(4)
  final String phoneNumber;

  AuthHiveModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber,
  });

  factory AuthHiveModel.formEntity(AuthEntity entity){
    return AuthHiveModel(
      fullName: entity.fullname,
       email: entity.email,
        password: entity.password,
         address: entity.address,
          phoneNumber: entity.phoneNumber,
          );
}
  
  AuthEntity toEntity(){
    return AuthEntity(
      fullname: fullName, 
      email: email,
       password: password,
        address: address,
         phoneNumber: phoneNumber,
         );
  }

  static List<AuthEntity> toEntityList(List<AuthHiveModel> models){
    return models.map((model) => model.toEntity()).toList();
  }

}