import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/usecases/app.usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/repositories/auth_repository.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

class RequestPasswordResetUsecaseParams extends Equatable {
  final String email;
  final String platform;
  final String? resetUrl;

  const RequestPasswordResetUsecaseParams({
    required this.email,
    required this.platform,
    this.resetUrl,
  });

  @override
  List<Object?> get props => [email, platform, resetUrl];
}

final requestPasswordResetUsecaseProvider =
    Provider<RequestPasswordResetUsecase>((ref) {
      final authRepository = ref.read(authRepositoryProvider);
      return RequestPasswordResetUsecase(authRepository: authRepository);
    });

class RequestPasswordResetUsecase
    implements UsecaseWithParams<bool, RequestPasswordResetUsecaseParams> {
  final IAuthRepository _authRepository;

  RequestPasswordResetUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> call(
    RequestPasswordResetUsecaseParams params,
  ) async {
    return _authRepository.requestPasswordReset(
      email: params.email,
      platform: params.platform,
      resetUrl: params.resetUrl,
    );
  }
}
