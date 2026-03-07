import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late ResetPasswordUsecase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = ResetPasswordUsecase(authRepository: mockRepository);
  });

  const params = ResetPasswordUsecaseParams(
    token: 'reset-token',
    newPassword: 'new-password',
  );

  group('ResetPasswordUsecase', () {
    test('should return true when reset succeeds', () async {
      when(
        () => mockRepository.resetPassword(
          token: params.token,
          newPassword: params.newPassword,
        ),
      ).thenAnswer((_) async => const Right(true));

      final result = await usecase(params);

      expect(result, const Right(true));
      verify(
        () => mockRepository.resetPassword(
          token: params.token,
          newPassword: params.newPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when reset fails', () async {
      const failure = ApiFailure(message: 'Invalid token');
      when(
        () => mockRepository.resetPassword(
          token: params.token,
          newPassword: params.newPassword,
        ),
      ).thenAnswer((_) async => const Left(failure));

      final result = await usecase(params);

      expect(result, const Left(failure));
      verify(
        () => mockRepository.resetPassword(
          token: params.token,
          newPassword: params.newPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
