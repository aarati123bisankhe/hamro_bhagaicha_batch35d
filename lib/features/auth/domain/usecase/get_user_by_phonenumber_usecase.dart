import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/usecases/app.usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/repositories/auth_repository.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

class GetUserByPhonenumberUsecaseParams extends Equatable {
  final String phoneNumber;

  const GetUserByPhonenumberUsecaseParams({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

final getUserByPhonenumberUsecaseProvider =
    Provider<GetUserByPhonenumberUsecase>((ref) {
      final authRepository = ref.read(authRepositoryProvider);
      return GetUserByPhonenumberUsecase(authRepository: authRepository);
    });

class GetUserByPhonenumberUsecase
    implements
        UsecaseWithParams<AuthEntity, GetUserByPhonenumberUsecaseParams> {
  final IAuthRepository _authRepository;

  GetUserByPhonenumberUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, AuthEntity>> call(
    GetUserByPhonenumberUsecaseParams params,
  ) {
    return _authRepository.getUserByPhoneNumber(params.phoneNumber);
  }
}
