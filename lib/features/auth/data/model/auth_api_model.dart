import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';

class AuthApiModel {
  final String? id;
  final String fullname;
  final String email;
  final String address;
  final String phoneNumber;
  final String? password;
  final String? profileUrl;
  final String? token; // <- add this

  AuthApiModel({
    this.id,
    required this.fullname,
    required this.email,
    required this.address,
    required this.phoneNumber,
    this.password, 
    this.profileUrl, this.token,
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
  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
  return AuthApiModel(
    id: json['_id']?.toString(),
    fullname: json['fullname'] ?? '',
    email: json['email'] ?? '',
    address: json['address'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
     profileUrl: json['profileUrl'] ?? null, 
     token: json['token'], // <- read token from backend
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
      profilePicture: profileUrl, 
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
      profileUrl: entity.profilePicture, 
    );
  }

  // toEntityList
  static List<AuthEntity> toEntityList(List<AuthApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
