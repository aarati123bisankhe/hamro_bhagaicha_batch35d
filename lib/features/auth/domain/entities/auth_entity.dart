import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? authId;      // nullable
  final String fullname;
  final String email;
  final String password;
  final String address;
  final String phoneNumber;
  final String? profilePicture;
  final String? token;
  // final String role;

  const AuthEntity({
    this.authId,
    required this.fullname,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber, 
    this.profilePicture, this.token,
    // this.role = 'user',
  });

  // Factory method to parse from JSON safely
  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      authId: json['_id'] as String?, // nullable
      fullname: json['fullname'] as String, 
      email: json['email'] as String, 
      password: json['password'] as String, 
      address: json['address'] as String, 
      phoneNumber: json['phoneNumber'] as String,
      profilePicture: json['profileUrl'] as String?, // ✅ FIX 
      token: json['token'] as String?, // nullable
      
    );
  }

  // Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      "fullname": fullname,
      "email": email,
      "password": password,
      "address": address,
      "phoneNumber": phoneNumber,
    };
  }

  @override
  List<Object?> get props => [
        authId,
        fullname,
        email,
        password,
        address,
        phoneNumber,
        profilePicture,
        token,
      ];
}
