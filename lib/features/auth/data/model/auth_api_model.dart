import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';

class AuthApiModel {
  final String? authId;
  final String fullname;
  final String email;
  final String password;
  final String address;
  final String phoneNumber;

  AuthApiModel({
    this.authId,
    required this.fullname,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber
  });


  //tojson

  Map<String, dynamic> tojson() {
    return {
      'authId': authId,
      'fullname': fullname,
      'email': email,
      'password': password,
      'address': address,
      'phoneNumber': phoneNumber
    };
  }

   //fromjson
   factory AuthApiModel.fromjson(Map<String, dynamic> json) {
     return AuthApiModel(
       authId: json['authId'],
       fullname: json['fullname'],
       email: json['email'],
       password: json['password'],
       address: json['address'],
       phoneNumber: json['phoneNumber']
     );
   }

   //toEntity
   AuthEntity toEntity() {
     return AuthEntity(
       authId: authId,
       fullname: fullname,
       email: email,
       password: password,
       address: address,
       phoneNumber: phoneNumber
     );
   }

   //fromEntity
factory AuthApiModel.fromEntity(AuthEntity entity) {
  return AuthApiModel(
    authId: entity.authId,
    fullname: entity.fullname,
    email: entity.email,
    password: entity.password,
    address: entity.address,
    phoneNumber: entity.phoneNumber,
  );
}
}