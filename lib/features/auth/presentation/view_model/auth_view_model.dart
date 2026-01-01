import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/login_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/register_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';

//provider
final authviewModelProvider =
  NotifierProvider<AuthViewModel, AuthState>(() => AuthViewModel());

class AuthViewModel extends Notifier<AuthState>{
  late final RegisterUsecase _registerUsecase;
  late final LoginUsecase _loginUsecase;


  @override
  AuthState build() {
    _registerUsecase = ref.read(registerUsecaseProvider);
    _loginUsecase = ref.read(loginUsecaseProvider);
    return AuthState();
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String address,
    required String phoneNumber,
  })async {
    state = state.copywith(status: AuthStatus.loading);
    final params = RegisterUsecaseParams(
      fullName: fullName,
      email: email,
      password: password,
      address: address,
      phoneNumber: phoneNumber
    );
    final result = await _registerUsecase.call(params);

    result.fold(
      (failure) {
        state = state.copywith(
          status: AuthStatus.error,
          errorMessage: failure.message
        );
      },
      (isRegistered) {
        if(isRegistered){
          state = state.copywith(status: AuthStatus.registered);
        } else {
          state = state.copywith(
            status: AuthStatus.error,
            errorMessage: 'Registration failed',
          );
        }
      },
    );
  }

  //login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copywith(status: AuthStatus.loading);
    final params = LoginUsecaseParams(
      email: email,
       password: password);
       final result = await _loginUsecase(params);

       result.fold(
        (failure) {
          state = state.copywith(
            status:  AuthStatus.error,
            errorMessage: failure.message
          );
        },
        (authEntity){
          state = state.copywith(
            status: AuthStatus.authenticated,
            authEntity: authEntity,
          );
        }
       );
  }
}