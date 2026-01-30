import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/login_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late LoginUsecase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = LoginUsecase(authRepository: mockRepository);
  });

  final tEmail = 'test@example.com';
  final tPassword = 'password123';

  final tParams = LoginUsecaseParams(
    email: tEmail,
    password: tPassword,
  );

  final tAuthEntity = AuthEntity(
    fullname: 'Test User',
    email: tEmail,
    password: tPassword,
    address: 'Test Address',
    phoneNumber: '1234567890',
  );

  setUpAll(() {
    registerFallbackValue(
      AuthEntity(
        fullname: 'fallback',
        email: 'fallback@example.com',
        password: 'fallback',
        address: 'fallback address',
        phoneNumber: '0000000000',
      ),
    );
  });

  group('LoginUsecase', () {
    test('should return AuthEntity when login is successful', () async {
      //arrange
      when(() => mockRepository.login(tEmail, tPassword))
          .thenAnswer((_) async => Right(tAuthEntity));

      //act
      final result = await usecase(tParams);

      //assert
      expect(result, Right(tAuthEntity));
      verify(() => mockRepository.login(tEmail, tPassword)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when login fails', () async {
      //arrange
      final failure = ApiFailure(message: 'Invalid credentials');
      when(() => mockRepository.login(tEmail, tPassword))
          .thenAnswer((_) async => Left(failure));

      //act
      final result = await usecase(tParams);

      //assert
      expect(result, Left(failure));
      verify(() => mockRepository.login(tEmail, tPassword)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
