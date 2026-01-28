import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, bool>> register(AuthEntity entity);
  Future<Either<Failure, AuthEntity>> login(String email, String password);
  // Future<Either<Failure, AuthEntity>> getUserByPhoneNumber(String phoneNumber);
  Future<Either<Failure, AuthEntity>> getCurrentUser();
  Future<Either<Failure, bool>> logout();
  Future<AuthEntity> updateProfileImage(File imageFile);
  // Future<Either<Failure, bool>> isPhoneNumberExists(String phoneNumber);
}