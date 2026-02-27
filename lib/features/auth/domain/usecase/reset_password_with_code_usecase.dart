import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/usecases/app.usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/repositories/auth_repository.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordWithCodeUsecaseParams extends Equatable {
  final String email;
  final String code;
  final String newPassword;

  const ResetPasswordWithCodeUsecaseParams({
    required this.email,
    required this.code,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [email, code, newPassword];
}

final resetPasswordWithCodeUsecaseProvider =
    Provider<ResetPasswordWithCodeUsecase>((ref) {
      final authRepository = ref.read(authRepositoryProvider);
      return ResetPasswordWithCodeUsecase(authRepository: authRepository);
    });

class ResetPasswordWithCodeUsecase
    implements UsecaseWithParams<bool, ResetPasswordWithCodeUsecaseParams> {
  final IAuthRepository _authRepository;

  ResetPasswordWithCodeUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> call(
    ResetPasswordWithCodeUsecaseParams params,
  ) async {
    return _authRepository.resetPasswordWithCode(
      email: params.email,
      code: params.code,
      newPassword: params.newPassword,
    );
  }
}
