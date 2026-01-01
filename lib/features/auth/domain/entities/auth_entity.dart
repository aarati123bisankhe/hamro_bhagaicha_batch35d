import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable{
  final String? authId;
  final String fullname;
  final String email;
  final String password;
  final String address;
  final String phoneNumber;

  const AuthEntity({
    this.authId,
    required this.fullname, 
    required this.email, 
    required this.password,
     required this.address, 
     required this.phoneNumber,
    
  });

  @override
  List<Object?> get props => [
    fullname,
    email,
    password,
    address,
    phoneNumber, 
  ];
}