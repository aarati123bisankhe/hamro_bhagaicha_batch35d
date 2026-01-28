import 'dart:io';
import 'package:hamro_bhagaicha_batch35d/features/auth/data/repositories/auth_repository.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';

class UpdateProfileImageUseCase {
  final AuthRepository repository;

  UpdateProfileImageUseCase(this.repository);

  Future<AuthEntity> call(File imageFile) {
    return repository.updateProfileImage(imageFile);
  }
}
