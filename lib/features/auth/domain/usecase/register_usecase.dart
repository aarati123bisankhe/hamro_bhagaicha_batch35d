import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/usecases/app.usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/repositories/auth_repository.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecaseParams extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String address;
  final String phoneNumber;

  const RegisterUsecaseParams({
    required this.fullName,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
        address,
        phoneNumber,
      ];
}

//provider
final registerUsecaseProvider = Provider<RegisterUsecase>((ref){
  final authRepository = ref.read(authRepositoryProvider);
  return RegisterUsecase(authRepository: authRepository);
});

// Usecase class
class RegisterUsecase implements UsecaseWithParams<bool, RegisterUsecaseParams> {
    final IAuthRepository _authRepository;

    RegisterUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> call(RegisterUsecaseParams params) async {
    final entity = AuthEntity(
      // authId: '', // can be empty; Hive will generate
      fullname: params.fullName,
      email: params.email,
      password: params.password,
      address: params.address,
      phoneNumber: params.phoneNumber,
    );

    return _authRepository.register(entity);
  }
}
