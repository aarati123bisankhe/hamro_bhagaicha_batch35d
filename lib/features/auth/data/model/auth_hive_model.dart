import 'package:hamro_bhagaicha_batch35d/core/config/hive_table_constant.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';


part 'auth_hive_model.g.dart';


@HiveType(typeId: HiveTableConstant.authTypeId)
class AuthHiveModel extends HiveObject{


  @HiveField(0)
  final String authId;  
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final String phoneNumber;

  AuthHiveModel({
    String? authId,
    required this.fullName,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber,
  }) : authId = authId ?? Uuid().v4();

  factory AuthHiveModel.fromEntity(AuthEntity entity){
    return AuthHiveModel(
       authId: entity.authId,
      fullName: entity.fullname,
       email: entity.email,
        password: entity.password,
         address: entity.address,
          phoneNumber: entity.phoneNumber,
          );
}
  
  AuthEntity toEntity(){
    return AuthEntity(
      authId: authId,
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

  static fromApiModel(apiModel) {}

}


//dart run build_runner build --delete-conflicting-outputs
