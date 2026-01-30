class AuthEntity {
  final String? authId;      // nullable
  final String fullname;
  final String email;
  final String password;
  final String address;
  final String phoneNumber;
  final String? profilePicture;
  // final String role;

  const AuthEntity({
    this.authId,
    required this.fullname,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber, 
    this.profilePicture,
    // this.role = 'user',
  });

  AuthEntity copyWith({
    String? authId,
    String? fullname,
    String? email,
    String? password,
    String? address,
    String? phoneNumber,
    String? profilePicture,
    // String? role,
  }) {
    return AuthEntity(
      authId: authId ?? this.authId,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      // role: role ?? this.role,
    );
  }
}
