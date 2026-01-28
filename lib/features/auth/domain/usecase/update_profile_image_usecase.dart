// import 'dart:io';
// import 'package:dartz/dartz.dart';
// import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/data/repositories/auth_repository.dart';
// import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';

// //provider
// final updateProfileImageUseCaseProvider = UpdateProfileImageUseCaseProvider();

// class UpdateProfileImageUseCaseProvider {
//   UpdateProfileImageUseCase call(AuthRepository repository) {
//     return UpdateProfileImageUseCase(repository);
//   }
// }

// class UpdateProfileImageUseCase {
//   final AuthRepository repository;

//   UpdateProfileImageUseCase(this.repository);

//   Future<Either<Failure, AuthEntity>> call(File imageFile) {
//     return repository.updateProfileImage(imageFile);
//   }
// }

import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/repositories/auth_repository.dart';
import '../repositories/auth_repository.dart';
import '../../domain/entities/auth_entity.dart';

// ✅ Proper Riverpod provider
final updateProfileImageUsecaseProvider =
    Provider<UpdateProfileImageUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider); // inject your repo
  return UpdateProfileImageUseCase(repository);
});

class UpdateProfileImageUseCase {
  final IAuthRepository repository; // Use the interface, not concrete class

  UpdateProfileImageUseCase(this.repository);

  Future<Either<Failure, AuthEntity>> call(File imageFile) {
    return repository.updateProfileImage(imageFile);
  }
}

