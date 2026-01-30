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

final updateProfileImageUsecaseProvider =
    Provider<UpdateProfileImageUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider); 
  return UpdateProfileImageUseCase(repository);
});

class UpdateProfileImageUseCase {
  final IAuthRepository repository; 

  UpdateProfileImageUseCase(this.repository);

  Future<Either<Failure, String>> call(File image) {
    return repository.updateProfileImage(image);
  }
}

