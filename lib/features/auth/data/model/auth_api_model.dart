import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';

class AuthApiModel {
  final String? id;
  final String fullname;
  final String email;
  final String address;
  final String phoneNumber;
  final String? password;

  AuthApiModel({
    this.id,
    required this.fullname,
    required this.email,
    required this.address,
    required this.phoneNumber,
    this.password,
  });

  // toJSON
  Map<String, dynamic> toJson() {
    return {
      "fullname": fullname,
      "email": email,
      "address": address,
      "phoneNumber": phoneNumber,
      "password": password,
    };
  }

  // fromJSON
  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    return AuthApiModel(
      id: json['_id'] as String?,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  // toEntity
  AuthEntity toEntity() {
    return AuthEntity(
      authId: id,
      fullname: fullname,
      email: email,
      password: password ?? '',
      address: address,
      phoneNumber: phoneNumber,
    );
  }

  // fromEntity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      id: entity.authId,
      fullname: entity.fullname,
      email: entity.email,
      address: entity.address,
      phoneNumber: entity.phoneNumber,
      password: entity.password,
    );
  }

  // toEntityList
  static List<AuthEntity> toEntityList(List<AuthApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
