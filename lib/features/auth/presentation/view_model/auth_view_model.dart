// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/login_usecase.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/logout_usecase.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/register_usecase.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';

// //provider
// final authviewModelProvider =
//   NotifierProvider<AuthViewModel, AuthState>(() => AuthViewModel());

// class AuthViewModel extends Notifier<AuthState>{
//   late final RegisterUsecase _registerUsecase;
//   late final LoginUsecase _loginUsecase;
//    late final LogoutUsecase _logoutUsecase;


//   @override
//   AuthState build() {
//     _registerUsecase = ref.read(registerUsecaseProvider);
//     _loginUsecase = ref.read(loginUsecaseProvider);
//        _logoutUsecase = ref.read(logoutUsecaseProvider);
//     return AuthState();
//   }

//   Future<void> register({
//     required String fullName,
//     required String email,
//     required String password,
//     required String address,
//     required String phoneNumber,
//   })async {
//     state = state.copywith(status: AuthStatus.loading, user: null);
//     final params = RegisterUsecaseParams(
//       fullName: fullName,
//       email: email,
//       password: password,
//       address: address,
//       phoneNumber: phoneNumber
//     );
//     final result = await _registerUsecase.call(params);

//     result.fold(
//       (failure) {
//         state = state.copywith(
//           status: AuthStatus.error,
//           errorMessage: failure.message, user: null
//         );
//       },
//       (isRegistered) {
//         if(isRegistered){
//           state = state.copywith(status: AuthStatus.registered, user: null);
//         } else {
//           state = state.copywith(
//             status: AuthStatus.error,
//             errorMessage: 'Registration failed', user: null,
//           );
//         }
//       },
//     );
//   }

//   //login
//   Future<void> login({
//     required String email,
//     required String password,
//   }) async {
//     state = state.copywith(status: AuthStatus.loading, user: null);
//     final params = LoginUsecaseParams(
//       email: email,
//        password: password);
//        final result = await _loginUsecase(params);

//        result.fold(
//         (failure) {
//           state = state.copywith(
//             status:  AuthStatus.error,
//             errorMessage: failure.message, user: null
//           );
//         },
//         (authEntity){
//           state = state.copywith(
//             status: AuthStatus.authenticated,
//             authEntity: authEntity, user: null,
//           );
//         }
//        );
//   }



//    //logout
//    Future<void> logout() async {
//      state = state.copywith(status: AuthStatus.loading, user: null);
//      final result = await _logoutUsecase.call();

//      result.fold(
//       (failure) {
//         state = state.copywith(
//           status: AuthStatus.error,
//           errorMessage: failure.message, user: null
//         );
//       },
//       (isLoggedOut) {
//         if(isLoggedOut){
//           state = state.copywith(status: AuthStatus.unauthenticated, user: null);
//         } else {
//           state = state.copywith(
//             status: AuthStatus.error,
//             errorMessage: 'Logout failed', user: null,
//           );
//         }
//       },
//      );
//    }
// }


import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/token_service.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/login_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/logout_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/register_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/update_profile_image_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';

// Provider
final authviewModelProvider =
    NotifierProvider<AuthViewModel, AuthState>(() => AuthViewModel());

class AuthViewModel extends Notifier<AuthState> {
  late final RegisterUsecase _registerUsecase;
  late final LoginUsecase _loginUsecase;
  late final LogoutUsecase _logoutUsecase;
  late final UpdateProfileImageUseCase _updateProfileImageUseCase;

  @override
  AuthState build() {
    _registerUsecase = ref.read(registerUsecaseProvider);
    _loginUsecase = ref.read(loginUsecaseProvider);
    _logoutUsecase = ref.read(logoutUsecaseProvider);
    _updateProfileImageUseCase = ref.read(updateProfileImageUsecaseProvider);

    return const AuthState();
  }

  // ---------------- Register ----------------
  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String address,
    required String phoneNumber,
  }) async {
    state = state.copywith(status: AuthStatus.loading, authEntity: null, user: null);

    final params = RegisterUsecaseParams(
      fullName: fullName,
      email: email,
      password: password,
      address: address,
      phoneNumber: phoneNumber,
    );

    final result = await _registerUsecase.call(params);

    result.fold(
      (failure) {
        state = state.copywith(
          status: AuthStatus.error,
          errorMessage: failure.message, user: null,
        );
      },
      (isRegistered) {
        if (isRegistered) {
          state = state.copywith(status: AuthStatus.registered, user: null);
        } else {
          state = state.copywith(
            status: AuthStatus.error,
            errorMessage: 'Registration failed', user: null,
          );
        }
      },
    );
  }

  // ---------------- Login ----------------
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copywith(status: AuthStatus.loading, authEntity: null, user: null);

    final params = LoginUsecaseParams(email: email, password: password);
    final result = await _loginUsecase(params);

    result.fold(
  (failure) {
    state = state.copywith(
      status: AuthStatus.error,
      errorMessage: failure.message,
      user: null,
    );
  },
  (authEntity) async {
    state = state.copywith(
      status: AuthStatus.authenticated,
      authEntity: authEntity,
      user: null,
    );

    // Save token to secure storage
    if (authEntity.token != null) {
      await ref.read(tokenServiceProvider).saveToken(authEntity.token!);
    }
  },
);
  }

  // ---------------- Logout ----------------
  Future<void> logout() async {
    state = state.copywith(status: AuthStatus.loading, user: null);

    final result = await _logoutUsecase.call();

    result.fold(
      (failure) {
        state = state.copywith(
          status: AuthStatus.error,
          errorMessage: failure.message, user: null,
        );
      },
      (isLoggedOut) {
        if (isLoggedOut) {
          state = state.copywith(
            status: AuthStatus.unauthenticated,
            authEntity: null, user: null,
          );
        } else {
          state = state.copywith(
            status: AuthStatus.error,
            errorMessage: 'Logout failed', user: null,
          );
        }
      },
    );
  }

  // ---------------- Update Profile Image ----------------
  // Future<void> updateProfileImage(File imageFile) async {
  //   state = state.copywith(status: AuthStatus.loading, user: null);

  //   final result = await _updateProfileImageUseCase(imageFile);

  //   result.fold(
  //     (failure) {
  //       state = state.copywith(
  //         status: AuthStatus.error,
  //         errorMessage: failure.message, user: null,
  //       );
  //     },
  //     (updatedUser) {
  //       state = state.copywith(
  //         status: AuthStatus.authenticated,
  //         authEntity: updatedUser, user: null,
  //       );
  //     },
  //   );
  // }
Future<void> updateProfileImage(File imageFile) async {
  state = state.copywith(status: AuthStatus.loading, user: null);

  final result = await _updateProfileImageUseCase(imageFile);

  result.fold(
    (failure) {
      state = state.copywith(
        status: AuthStatus.error,
        errorMessage: failure.message, user: null,
      );
    },
    (updatedUser) {
      state = state.copywith(
        status: AuthStatus.authenticated,
        authEntity: updatedUser, user: null,
      );
    },
  );
}

}

