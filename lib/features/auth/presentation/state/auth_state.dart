import 'package:equatable/equatable.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';

enum AuthStatus {
  initial,
  currentUserLoaded,
  loading,
  authenticated,
  unauthenticated,
  registered,
  error,
  loaded,
  checking,
  passwordResetEmailSent,
  passwordResetSuccess,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthEntity? authEntity;
  final String? errorMessage;
  final String? uploadProfilePhotoName;

  const AuthState({
    this.status = AuthStatus.initial,
    this.authEntity,
    this.errorMessage,
    this.uploadProfilePhotoName,
  });

  const AuthState.initial(this.uploadProfilePhotoName)
    : status = AuthStatus.initial,
      authEntity = null,
      errorMessage = null;

  AuthState copyWith({
    AuthStatus? status,
    AuthEntity? authEntity,
    bool clearAuthEntity = false,
    String? errorMessage,
    String? uploadProfilePhotoName,
    String? uploadCoverPhotoName,
  }) {
    return AuthState(
      status: status ?? this.status,
      authEntity: clearAuthEntity ? null : authEntity ?? this.authEntity,
      errorMessage: errorMessage,
      uploadProfilePhotoName:
          uploadProfilePhotoName ?? this.uploadProfilePhotoName,
    );
  }

  @override
  List<Object?> get props => [
    status,
    authEntity,
    errorMessage,
    uploadProfilePhotoName,
  ];

  @override
  String toString() =>
      'AuthState(status: $status, authEntity: $authEntity, errorMessage: $errorMessage)';
}
