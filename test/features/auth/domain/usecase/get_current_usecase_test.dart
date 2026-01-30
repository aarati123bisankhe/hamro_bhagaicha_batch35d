import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/get_current_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late GetCurrentUserUsecase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = GetCurrentUserUsecase(authRepository: mockRepository);
  });

  const tUserId = '1';

  const tUser = AuthEntity(
    authId: '1',
    fullname: 'Test User',
    email: 'test@example.com',
    password: 'password123',
    address: 'Test Address',
    phoneNumber: '1234567890',
    profilePicture: null,
  );

  const params = GetCurrentUsecaseParams(userId: tUserId);

  group('GetCurrentUserUsecase', () {
    test('should return AuthEntity when user exists', () async {
      when(() => mockRepository.getCurrentUserById(tUserId))
          .thenAnswer((_) async => const Right(tUser));

      final result = await usecase(params);

      expect(result, const Right(tUser));
      verify(() => mockRepository.getCurrentUserById(tUserId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ApiFailure when user not found', () async {
      const failure = ApiFailure(message: 'User not found');

      when(() => mockRepository.getCurrentUserById(tUserId))
          .thenAnswer((_) async => const Left(failure));

      final result = await usecase(params);

      expect(result, const Left(failure));
      verify(() => mockRepository.getCurrentUserById(tUserId)).called(1);
    });

    test('should return user with all fields populated', () async {
      const userWithAllFields = AuthEntity(
        authId: '1',
        fullname: 'Test User',
        email: 'test@example.com',
        password: 'password123',
        address: 'Test Address',
        phoneNumber: '1234567890',
        profilePicture: 'https://example.com/pic.jpg',
      );

      when(() => mockRepository.getCurrentUserById(tUserId))
          .thenAnswer((_) async => const Right(userWithAllFields));

      final result = await usecase(params);

      result.fold(
        (failure) => fail('Expected AuthEntity'),
        (user) {
          expect(user.authId, '1');
          expect(user.fullname, 'Test User');
          expect(user.email, 'test@example.com');
          expect(user.password, 'password123');
          expect(user.address, 'Test Address');
          expect(user.phoneNumber, '1234567890');
          expect(user.profilePicture, 'https://example.com/pic.jpg');
        },
      );
    });
  });
}
