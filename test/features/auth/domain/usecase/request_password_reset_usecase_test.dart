import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/repositories/auth_repository.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/request_password_reset_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late RequestPasswordResetUsecase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = RequestPasswordResetUsecase(authRepository: mockRepository);
  });

  const params = RequestPasswordResetUsecaseParams(
    email: 'test@example.com',
    platform: 'mobile',
  );

  group('RequestPasswordResetUsecase', () {
    test('should return true when reset request succeeds', () async {
      when(
        () => mockRepository.requestPasswordReset(
          email: params.email,
          platform: params.platform,
          resetUrl: params.resetUrl,
        ),
      ).thenAnswer((_) async => const Right(true));

      final result = await usecase(params);

      expect(result, const Right(true));
      verify(
        () => mockRepository.requestPasswordReset(
          email: params.email,
          platform: params.platform,
          resetUrl: params.resetUrl,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when reset request fails', () async {
      const failure = ApiFailure(message: 'Email not found');
      when(
        () => mockRepository.requestPasswordReset(
          email: params.email,
          platform: params.platform,
          resetUrl: params.resetUrl,
        ),
      ).thenAnswer((_) async => const Left(failure));

      final result = await usecase(params);

      expect(result, const Left(failure));
      verify(
        () => mockRepository.requestPasswordReset(
          email: params.email,
          platform: params.platform,
          resetUrl: params.resetUrl,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
