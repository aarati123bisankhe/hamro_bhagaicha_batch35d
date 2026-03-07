import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/security/biometric_auth_service.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/token_service.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/get_current_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/login_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/logout_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/request_password_reset_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/register_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/reset_password_with_code_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/update_profile_image_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockRegisterUsecase extends Mock implements RegisterUsecase {}

class MockLogoutUsecase extends Mock implements LogoutUsecase {}

class MockGetCurrentUserUsecase extends Mock implements GetCurrentUserUsecase {}

class MockUpdateProfileImageUsecase extends Mock
    implements UpdateProfileImageUseCase {}

class MockRequestPasswordResetUsecase extends Mock
    implements RequestPasswordResetUsecase {}

class MockResetPasswordUsecase extends Mock implements ResetPasswordUsecase {}

class MockResetPasswordWithCodeUsecase extends Mock
    implements ResetPasswordWithCodeUsecase {}

class MockTokenService extends Mock implements TokenService {}

class MockBiometricAuthService extends Mock implements BiometricAuthService {}

void main() {
  late ProviderContainer container;
  late MockLoginUsecase mockLoginUsecase;
  late MockRegisterUsecase mockRegisterUsecase;
  late MockLogoutUsecase mockLogoutUsecase;
  late MockGetCurrentUserUsecase mockGetCurrentUserUsecase;
  late MockUpdateProfileImageUsecase mockUpdateProfileImageUsecase;
  late MockRequestPasswordResetUsecase mockRequestPasswordResetUsecase;
  late MockResetPasswordUsecase mockResetPasswordUsecase;
  late MockResetPasswordWithCodeUsecase mockResetPasswordWithCodeUsecase;
  late MockTokenService mockTokenService;
  late MockBiometricAuthService mockBiometricAuthService;

  final testUser = AuthEntity(
    fullname: 'Test User',
    email: 'test@test.com',
    password: '123456',
    address: 'Kathmandu',
    phoneNumber: '9800000000',
  );

  setUpAll(() {
    registerFallbackValue(
      LoginUsecaseParams(email: 'fallback@test.com', password: 'fallback'),
    );
    registerFallbackValue(
      RegisterUsecaseParams(
        fullName: 'fallback',
        email: 'fallback@test.com',
        password: 'fallback',
        address: 'fallback',
        phoneNumber: '0000000000',
      ),
    );
    registerFallbackValue(GetCurrentUsecaseParams(userId: 'fallback'));
    registerFallbackValue(
      const RequestPasswordResetUsecaseParams(
        email: 'fallback@test.com',
        platform: 'mobile',
      ),
    );
    registerFallbackValue(
      const ResetPasswordUsecaseParams(token: 'token', newPassword: 'password'),
    );
    registerFallbackValue(
      const ResetPasswordWithCodeUsecaseParams(
        email: 'fallback@test.com',
        code: '123456',
        newPassword: 'password',
      ),
    );
    registerFallbackValue(File('fallback.png'));
  });

  setUp(() {
    mockLoginUsecase = MockLoginUsecase();
    mockRegisterUsecase = MockRegisterUsecase();
    mockLogoutUsecase = MockLogoutUsecase();
    mockGetCurrentUserUsecase = MockGetCurrentUserUsecase();
    mockUpdateProfileImageUsecase = MockUpdateProfileImageUsecase();
    mockRequestPasswordResetUsecase = MockRequestPasswordResetUsecase();
    mockResetPasswordUsecase = MockResetPasswordUsecase();
    mockResetPasswordWithCodeUsecase = MockResetPasswordWithCodeUsecase();
    mockTokenService = MockTokenService();
    mockBiometricAuthService = MockBiometricAuthService();

    when(() => mockTokenService.getToken()).thenAnswer((_) async => null);
    when(() => mockTokenService.saveToken(any())).thenAnswer((_) async {});
    when(
      () => mockBiometricAuthService.isBiometricSupported(),
    ).thenAnswer((_) async => false);
    when(
      () => mockBiometricAuthService.hasStoredToken(),
    ).thenAnswer((_) async => false);
    when(
      () => mockBiometricAuthService.authenticate(),
    ).thenAnswer((_) async => false);
    when(
      () => mockBiometricAuthService.authenticateWithDetails(),
    ).thenAnswer((_) async => const BiometricAuthResult(success: false));
    when(
      () => mockBiometricAuthService.getStoredToken(),
    ).thenAnswer((_) async => null);
    when(
      () => mockBiometricAuthService.getSupportIssueMessage(),
    ).thenAnswer((_) async => 'Biometric unavailable');
    when(
      () => mockBiometricAuthService.saveToken(any()),
    ).thenAnswer((_) async {});
    when(() => mockBiometricAuthService.clearToken()).thenAnswer((_) async {});

    container = ProviderContainer(
      overrides: [
        loginUsecaseProvider.overrideWithValue(mockLoginUsecase),
        registerUsecaseProvider.overrideWithValue(mockRegisterUsecase),
        logoutUsecaseProvider.overrideWithValue(mockLogoutUsecase),
        getCurrentUserUsecaseProvider.overrideWithValue(
          mockGetCurrentUserUsecase,
        ),
        updateProfileImageUsecaseProvider.overrideWithValue(
          mockUpdateProfileImageUsecase,
        ),
        requestPasswordResetUsecaseProvider.overrideWithValue(
          mockRequestPasswordResetUsecase,
        ),
        resetPasswordUsecaseProvider.overrideWithValue(
          mockResetPasswordUsecase,
        ),
        resetPasswordWithCodeUsecaseProvider.overrideWithValue(
          mockResetPasswordWithCodeUsecase,
        ),
        tokenServiceProvider.overrideWithValue(mockTokenService),
        biometricAuthServiceProvider.overrideWithValue(
          mockBiometricAuthService,
        ),
      ],
    );
  });

  tearDown(() => container.dispose());

  //login
  group('AuthViewModel - Login', () {
    test('login success → authenticated', () async {
      when(
        () => mockLoginUsecase(any()),
      ).thenAnswer((_) async => Right(testUser));

      final notifier = container.read(authViewModelProvider.notifier);

      await notifier.login(email: 'test@test.com', password: '123456');

      final state = container.read(authViewModelProvider);

      expect(state.status, AuthStatus.authenticated);
      expect(state.authEntity, testUser);
    });

    test('login failure → error', () async {
      when(() => mockLoginUsecase(any())).thenAnswer(
        (_) async => Left(ApiFailure(message: 'Invalid credentials')),
      );

      final notifier = container.read(authViewModelProvider.notifier);

      await notifier.login(email: 'wrong@test.com', password: 'wrong');

      final state = container.read(authViewModelProvider);

      expect(state.status, AuthStatus.error);
      expect(state.errorMessage, 'Invalid credentials');
    });
  });

  //register
  group('AuthViewModel - Register', () {
    test('register success → registered', () async {
      when(
        () => mockRegisterUsecase(any()),
      ).thenAnswer((_) async => Right(testUser));

      final notifier = container.read(authViewModelProvider.notifier);

      await notifier.register(
        fullName: 'Test User',
        email: 'test@test.com',
        password: '123456',
        address: 'Kathmandu',
        phoneNumber: '9800000000',
      );

      final state = container.read(authViewModelProvider);

      expect(state.status, AuthStatus.registered);
      expect(state.authEntity, testUser);
    });

    test('register failure → error', () async {
      when(
        () => mockRegisterUsecase(any()),
      ).thenAnswer((_) async => Left(ApiFailure(message: 'Register failed')));

      final notifier = container.read(authViewModelProvider.notifier);

      await notifier.register(
        fullName: 'Test',
        email: 'test@test.com',
        password: '123456',
        address: 'KTm',
        phoneNumber: '98',
      );

      final state = container.read(authViewModelProvider);

      expect(state.status, AuthStatus.error);
      expect(state.errorMessage, 'Register failed');
    });
  });

  //get current user
  group('AuthViewModel - Get Current User', () {
    test('get current user success', () async {
      when(
        () => mockGetCurrentUserUsecase(any()),
      ).thenAnswer((_) async => Right(testUser));

      final notifier = container.read(authViewModelProvider.notifier);

      await notifier.getCurrentUser(userId: '1');

      final state = container.read(authViewModelProvider);

      expect(state.status, AuthStatus.currentUserLoaded);
      expect(state.authEntity, testUser);
    });
  });

  //update profile
  group('AuthViewModel - Update Profile Image', () {
    test('update profile image success', () async {
      when(
        () => mockUpdateProfileImageUsecase(any()),
      ).thenAnswer((_) async => const Right('profile.png'));

      final notifier = container.read(authViewModelProvider.notifier);

      await notifier.updateProfileImage(File('test.png'));

      final state = container.read(authViewModelProvider);

      expect(state.status, AuthStatus.loaded);
      expect(state.uploadProfilePhotoName, 'profile.png');
    });
  });

  group('AuthViewModel - Logout', () {
    test('logout success -> unauthenticated', () async {
      when(
        () => mockLogoutUsecase(),
      ).thenAnswer((_) async => const Right(true));

      final notifier = container.read(authViewModelProvider.notifier);
      await notifier.logout();

      final state = container.read(authViewModelProvider);
      expect(state.status, AuthStatus.unauthenticated);
      expect(state.authEntity, isNull);
    });
  });
}
