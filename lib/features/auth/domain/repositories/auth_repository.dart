import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, AuthEntity>> register(AuthEntity entity);
  Future<Either<Failure, AuthEntity>> login(String email, String password);
  Future<Either<Failure, AuthEntity>> getCurrentUserById(String userId);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, String>> updateProfileImage(File image);
  Future<Either<Failure, bool>> requestPasswordReset({
    required String email,
    required String platform,
    String? resetUrl,
  });
  Future<Either<Failure, bool>> resetPassword({
    required String token,
    required String newPassword,
  });
  Future<Either<Failure, bool>> resetPasswordWithCode({
    required String email,
    required String code,
    required String newPassword,
  });
}
