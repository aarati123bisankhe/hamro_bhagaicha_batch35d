import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/get_current_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/login_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/logout_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/register_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/request_password_reset_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/update_profile_image_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider = NotifierProvider<AuthViewModel, AuthState>(
  AuthViewModel.new,
);

class AuthViewModel extends Notifier<AuthState> {
  late final RegisterUsecase _registerUseCase;
  late final LoginUsecase _loginUsecase;
  late final LogoutUsecase _logoutUsecase;
  late final GetCurrentUserUsecase _getCurrentUserUsecase;
  late final UpdateProfileImageUseCase _updateProfileImageUseCase;
  late final RequestPasswordResetUsecase _requestPasswordResetUsecase;
  late final ResetPasswordUsecase _resetPasswordUsecase;

  @override
  AuthState build() {
    _registerUseCase = ref.read(registerUsecaseProvider);
    _loginUsecase = ref.read(loginUsecaseProvider);
    _logoutUsecase = ref.read(logoutUsecaseProvider);
    _getCurrentUserUsecase = ref.read(getCurrentUserUsecaseProvider);
    _updateProfileImageUseCase = ref.read(updateProfileImageUsecaseProvider);
    _requestPasswordResetUsecase = ref.read(
      requestPasswordResetUsecaseProvider,
    );
    _resetPasswordUsecase = ref.read(resetPasswordUsecaseProvider);

    return const AuthState(status: AuthStatus.checking);
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String address,
    required String phoneNumber,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _registerUseCase(
      RegisterUsecaseParams(
        fullName: fullName,
        email: email,
        password: password,
        address: address,
        phoneNumber: phoneNumber,
      ),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        );
      },
      (user) {
        state = AuthState(status: AuthStatus.registered, authEntity: user);
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _loginUsecase(
      LoginUsecaseParams(email: email, password: password),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        );
      },
      (user) {
        state = AuthState(status: AuthStatus.authenticated, authEntity: user);
      },
    );
  }

  Future<void> getCurrentUser({required String userId}) async {
    state = state.copyWith(status: AuthStatus.loading);
    final getCurrentUsecaseParams = GetCurrentUsecaseParams(userId: userId);
    final result = await _getCurrentUserUsecase(getCurrentUsecaseParams);

    result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        );
      },
      (user) {
        state = AuthState(
          status: AuthStatus.currentUserLoaded,
          authEntity: user,
        );
      },
    );
  }

  Future<void> logout() async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _logoutUsecase.call();

    result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        );
      },
      (isLoggedOut) {
        if (isLoggedOut) {
          state = state.copyWith(
            status: AuthStatus.unauthenticated,
            authEntity: null,
          );
        } else {
          state = state.copyWith(
            status: AuthStatus.error,
            errorMessage: 'Logout failed',
          );
        }
      },
    );
  }

  Future<void> updateProfileImage(File image) async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _updateProfileImageUseCase(image);

    result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        );
      },
      (imageName) {
        state = state.copyWith(
          status: AuthStatus.loaded,
          authEntity: state.authEntity?.copyWith(profilePicture: imageName),
          uploadProfilePhotoName: imageName,
        );
      },
    );
  }

  Future<void> requestPasswordReset({
    required String email,
    required String platform,
    String? resetUrl,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _requestPasswordResetUsecase(
      RequestPasswordResetUsecaseParams(
        email: email,
        platform: platform,
        resetUrl: resetUrl,
      ),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        );
      },
      (_) {
        state = state.copyWith(
          status: AuthStatus.passwordResetEmailSent,
          errorMessage: null,
        );
      },
    );
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _resetPasswordUsecase(
      ResetPasswordUsecaseParams(token: token, newPassword: newPassword),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        );
      },
      (_) {
        state = state.copyWith(
          status: AuthStatus.passwordResetSuccess,
          errorMessage: null,
        );
      },
    );
  }
}
