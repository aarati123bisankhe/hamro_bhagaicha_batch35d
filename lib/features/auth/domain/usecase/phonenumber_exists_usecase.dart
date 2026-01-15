import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/usecases/app.usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/repositories/auth_repository.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

class PhoneNumberExistsUsecaseParams extends Equatable {
  final String phoneNumber;

  const PhoneNumberExistsUsecaseParams({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

final phoneNumberExistsUsecaseProvider = Provider<PhoneNumberExistsUsecase>((
  ref,
) {
  final authRepository = ref.read(authRepositoryProvider);
  return PhoneNumberExistsUsecase(authRepository: authRepository);
});

class PhoneNumberExistsUsecase
    implements UsecaseWithParams<bool, PhoneNumberExistsUsecaseParams> {
  final IAuthRepository _authRepository;

  PhoneNumberExistsUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> call(PhoneNumberExistsUsecaseParams params) {
    return _authRepository.isPhoneNumberExists(params.phoneNumber);
  }
}
