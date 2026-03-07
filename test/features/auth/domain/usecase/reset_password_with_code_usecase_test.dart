import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/reset_password_with_code_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late ResetPasswordWithCodeUsecase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = ResetPasswordWithCodeUsecase(authRepository: mockRepository);
  });

  const params = ResetPasswordWithCodeUsecaseParams(
    email: 'test@example.com',
    code: '123456',
    newPassword: 'new-password',
  );

  group('ResetPasswordWithCodeUsecase', () {
    test('should return true when code reset succeeds', () async {
      when(
        () => mockRepository.resetPasswordWithCode(
          email: params.email,
          code: params.code,
          newPassword: params.newPassword,
        ),
      ).thenAnswer((_) async => const Right(true));

      final result = await usecase(params);

      expect(result, const Right(true));
      verify(
        () => mockRepository.resetPasswordWithCode(
          email: params.email,
          code: params.code,
          newPassword: params.newPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when code reset fails', () async {
      const failure = ApiFailure(message: 'Invalid code');
      when(
        () => mockRepository.resetPasswordWithCode(
          email: params.email,
          code: params.code,
          newPassword: params.newPassword,
        ),
      ).thenAnswer((_) async => const Left(failure));

      final result = await usecase(params);

      expect(result, const Left(failure));
      verify(
        () => mockRepository.resetPasswordWithCode(
          email: params.email,
          code: params.code,
          newPassword: params.newPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
