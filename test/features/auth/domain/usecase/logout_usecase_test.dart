import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/logout_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late LogoutUsecase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = LogoutUsecase(authRepository: mockRepository);
  });

  group('LogoutUsecase', () {
    test('should return true when logout is successful', () async {
      //arrange
      when(() => mockRepository.logout())
          .thenAnswer((_) async => Right(true));

      //act
      final result = await usecase();

      //assert
      expect(result, Right(true));
      verify(() => mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when logout fails', () async {
      // Arrange
      final failure = ApiFailure(message: 'Logout failed');
      when(() => mockRepository.logout())
          .thenAnswer((_) async => Left(failure));

      //act
      final result = await usecase();

      //asset
      expect(result, Left(failure));
      verify(() => mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
