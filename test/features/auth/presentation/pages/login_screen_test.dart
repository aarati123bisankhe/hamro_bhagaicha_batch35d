import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/get_current_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/login_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/logout_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/register_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/update_profile_image_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/login_screen.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_field.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/floating_button_action.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockRegisterUsecase extends Mock implements RegisterUsecase {}

class MockLogoutUsecase extends Mock implements LogoutUsecase {}

class MockGetCurrentUserUsecase extends Mock implements GetCurrentUserUsecase {}

class MockUpdateProfileImageUsecase extends Mock implements UpdateProfileImageUseCase {}

void main() {
  late ProviderContainer container;
  late MockLoginUsecase mockLoginUsecase;
  late MockRegisterUsecase mockRegisterUsecase;
  late MockLogoutUsecase mockLogoutUsecase;
  late MockGetCurrentUserUsecase mockGetCurrentUserUsecase;
  late MockUpdateProfileImageUsecase mockUpdateProfileImageUsecase;

  final testUser = AuthEntity(
    fullname: 'Test User',
    email: 'test@test.com',
    password: '123456',
    address: 'Kathmandu',
    phoneNumber: '9800000000',
  );

  setUpAll(() {
    registerFallbackValue(LoginUsecaseParams(email: 'fallback@test.com', password: 'fallback'));
    registerFallbackValue(RegisterUsecaseParams(
      fullName: 'fallback',
      email: 'fallback@test.com',
      password: 'fallback',
      address: 'fallback',
      phoneNumber: '0000000000',
    ));
    registerFallbackValue(GetCurrentUsecaseParams(userId: 'fallback'));
    registerFallbackValue(File('fallback.png'));
  });

  setUp(() {
    mockLoginUsecase = MockLoginUsecase();
    mockRegisterUsecase = MockRegisterUsecase();
    mockLogoutUsecase = MockLogoutUsecase();
    mockGetCurrentUserUsecase = MockGetCurrentUserUsecase();
    mockUpdateProfileImageUsecase = MockUpdateProfileImageUsecase();

    container = ProviderContainer(
      overrides: [
        loginUsecaseProvider.overrideWithValue(mockLoginUsecase),
        registerUsecaseProvider.overrideWithValue(mockRegisterUsecase),
        logoutUsecaseProvider.overrideWithValue(mockLogoutUsecase),
        getCurrentUserUsecaseProvider.overrideWithValue(mockGetCurrentUserUsecase),
        updateProfileImageUsecaseProvider.overrideWithValue(mockUpdateProfileImageUsecase),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('LoginScreen Widget Test', () {
    testWidgets('enter email/password and tap login - success', (WidgetTester tester) async {
      when(() => mockLoginUsecase(any())).thenAnswer((_) async => Right(testUser));

      await tester.pumpWidget(
        UncontrolledProviderScope(   
          container: container,
          child: const MaterialApp(home: LoginScreen()),
        ),
      );

      final emailField = find.byType(MyTextField).at(0);
      final passwordField = find.byType(MyTextField).at(1);

      await tester.enterText(emailField, 'test@test.com');
      await tester.enterText(passwordField, '123456');

      await tester.pumpAndSettle(); 

      final loginButton = find.byType(MyFloatingButton);

      await tester.ensureVisible(loginButton);

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      final authState = container.read(authViewModelProvider);
      expect(authState.status, AuthStatus.authenticated);
      expect(authState.authEntity, testUser);
    });

    testWidgets('enter email/password and tap login - failure shows error', (WidgetTester tester) async {
      when(() => mockLoginUsecase(any()))
          .thenAnswer((_) async => Left(ApiFailure(message: 'Invalid credentials')));

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: LoginScreen()),
        ),
      );

      final emailField = find.byType(MyTextField).at(0);
      final passwordField = find.byType(MyTextField).at(1);

      await tester.enterText(emailField, 'wrong@test.com');
      await tester.enterText(passwordField, 'wrong');

      await tester.pumpAndSettle();

      final loginButton = find.byType(MyFloatingButton);
      await tester.ensureVisible(loginButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      final authState = container.read(authViewModelProvider);
      expect(authState.status, AuthStatus.error);
      expect(authState.errorMessage, 'Invalid credentials');
    });
  });
}
