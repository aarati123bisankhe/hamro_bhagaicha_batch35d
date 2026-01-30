import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/update_profile_image_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

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
      //arrange
      when(() => mockRepository.updateProfileImage(testFile))
          .thenAnswer((_) async => const Right(uploadedUrl));

      //act
      final result = await usecase(testFile);

      //assert
      expect(result, const Right(uploadedUrl));
      verify(() => mockRepository.updateProfileImage(testFile)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when image upload fails', () async {
      //arrange
      const failure = ApiFailure(message: 'Upload failed');
      when(() => mockRepository.updateProfileImage(testFile))
          .thenAnswer((_) async => const Left(failure));

      //act
      final result = await usecase(testFile);

      //assert
      expect(result, const Left(failure));
      verify(() => mockRepository.updateProfileImage(testFile)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
