import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/update_profile_image_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

// Mock repository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late UpdateProfileImageUseCase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = UpdateProfileImageUseCase(mockRepository);
  });

  final testFile = File('test/resources/test_image.png');
  const uploadedUrl = 'https://example.com/profile.png';

  group('UpdateProfileImageUseCase', () {
    test('should return URL string when image upload succeeds', () async {
      // Arrange
      when(() => mockRepository.updateProfileImage(testFile))
          .thenAnswer((_) async => const Right(uploadedUrl));

      // Act
      final result = await usecase(testFile);

      // Assert
      expect(result, const Right(uploadedUrl));
      verify(() => mockRepository.updateProfileImage(testFile)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when image upload fails', () async {
      // Arrange
      const failure = ApiFailure(message: 'Upload failed');
      when(() => mockRepository.updateProfileImage(testFile))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await usecase(testFile);

      // Assert
      expect(result, const Left(failure));
      verify(() => mockRepository.updateProfileImage(testFile)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
