import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/usecases/app.usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/repositories/auth_repository.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUsecaseParams extends Equatable {
  final String token;
  final String newPassword;

  const ResetPasswordUsecaseParams({
    required this.token,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [token, newPassword];
}

final resetPasswordUsecaseProvider = Provider<ResetPasswordUsecase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return ResetPasswordUsecase(authRepository: authRepository);
});

class ResetPasswordUsecase
    implements UsecaseWithParams<bool, ResetPasswordUsecaseParams> {
  final IAuthRepository _authRepository;

  ResetPasswordUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> call(ResetPasswordUsecaseParams params) async {
    return _authRepository.resetPassword(
      token: params.token,
      newPassword: params.newPassword,
    );
  }
}
