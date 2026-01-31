import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/register_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late RegisterUsecase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = RegisterUsecase(authRepository: mockRepository);
  });

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

  final tFullName = 'Test User';
  final tEmail = 'test@example.com';
  final tPassword = 'password123';
  final tAddress = 'Test Address';
  final tPhoneNumber = '1234567890';

  final tParams = RegisterUsecaseParams(
    fullName: tFullName,
    email: tEmail,
    password: tPassword,
    address: tAddress,
    phoneNumber: tPhoneNumber,
  );

  final tAuthEntity = AuthEntity(
    fullname: tFullName,
    email: tEmail,
    password: tPassword,
    address: tAddress,
    phoneNumber: tPhoneNumber,
  );

  group('RegisterUsecase', () {
    test('should return AuthEntity when registration is successful', () async {
      // Arrange
      when(() => mockRepository.register(any()))
          .thenAnswer((_) async => Right(tAuthEntity));

      // Act
      final result = await usecase(tParams);

      // Assert
      expect(result, Right(tAuthEntity));
      verify(() => mockRepository.register(any())).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when registration fails', () async {
      //arrange
      final failure = ApiFailure(message: 'Email already exists');
      when(() => mockRepository.register(any()))
          .thenAnswer((_) async => Left(failure));

      //act
      final result = await usecase(tParams);

      //assert
      expect(result, Left(failure));
      verify(() => mockRepository.register(any())).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should pass AuthEntity with correct values to repository', () async {
      //arrange
      AuthEntity? capturedEntity;
      when(() => mockRepository.register(any())).thenAnswer((invocation) {
        capturedEntity = invocation.positionalArguments[0] as AuthEntity;
        return Future.value(Right(tAuthEntity));
      });

      //act
      await usecase(tParams);

      //assert
      expect(capturedEntity?.fullname, tFullName);
      expect(capturedEntity?.email, tEmail);
      expect(capturedEntity?.password, tPassword);
      expect(capturedEntity?.address, tAddress);
      expect(capturedEntity?.phoneNumber, tPhoneNumber);
    });
  });
}