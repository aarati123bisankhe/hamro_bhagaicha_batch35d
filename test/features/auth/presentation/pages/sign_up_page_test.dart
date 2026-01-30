import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/error/failure.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_field.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/usecase/register_usecase.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/login_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/sign_up_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

// Mock RegisterUsecase
class MockRegisterUsecase extends Mock implements RegisterUsecase {}

void main() {
  late MockRegisterUsecase mockRegisterUsecase;

  final testUser = AuthEntity(
    fullname: 'Test User',
    email: 'test@test.com',
    password: '123456',
    address: 'Kathmandu',
    phoneNumber: '9800000000',
  );

  setUpAll(() {
    registerFallbackValue(RegisterUsecaseParams(
      fullName: 'fallback',
      email: 'fallback@test.com',
      password: 'fallback',
      address: 'fallback',
      phoneNumber: '0000000000',
    ));
  });

  setUp(() {
    mockRegisterUsecase = MockRegisterUsecase();
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        registerUsecaseProvider.overrideWithValue(mockRegisterUsecase),
      ],
      child: const MaterialApp(
        home: SignupPage(),
      ),
    );
  }

  testWidgets('renders all MyTextFields and Sign Up button', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    final fields = find.byType(MyTextField);
    expect(fields, findsNWidgets(5)); // Full Name, Email, Password, Address, Phone

    expect(find.text('Sign Up'), findsOneWidget);
  });

  testWidgets('register success → navigates to LoginScreen', (tester) async {
    // Mock register success
    when(() => mockRegisterUsecase(any())).thenAnswer((_) async => Right(testUser));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          registerUsecaseProvider.overrideWithValue(mockRegisterUsecase),
        ],
        child: MaterialApp(
          home: SignupPage(),
          routes: {'/login': (_) => const LoginScreen()},
        ),
      ),
    );
    await tester.pumpAndSettle();

    final fields = find.byType(MyTextField);

    // Fill form
    await tester.enterText(fields.at(0), 'Test User'); // Full Name
    await tester.enterText(fields.at(1), 'test@test.com'); // Email
    await tester.enterText(fields.at(2), '123456'); // Password
    await tester.enterText(fields.at(3), 'Kathmandu'); // Address
    await tester.enterText(fields.at(4), '9800000000'); // Phone

    // Tap Sign Up
    await tester.tap(find.text('Sign Up'));
    await tester.pump(); // first frame for async
    await tester.pumpAndSettle(); // wait for rebuild & snackbar

    // Verify registerUsecase called with correct parameters
    verify(() => mockRegisterUsecase(RegisterUsecaseParams(
      fullName: 'Test User',
      email: 'test@test.com',
      password: '123456',
      address: 'Kathmandu',
      phoneNumber: '9800000000',
    ))).called(1);

    // Verify navigation to LoginScreen
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Registration successful! Please log in.'), findsOneWidget);
  });

  testWidgets('register failure → shows error snackbar', (tester) async {
    // Mock register failure
    when(() => mockRegisterUsecase(any())).thenAnswer(
      (_) async => Left(ApiFailure(message: 'Register failed')),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    final fields = find.byType(MyTextField);

    // Fill form
    await tester.enterText(fields.at(0), 'Test User'); // Full Name
    await tester.enterText(fields.at(1), 'test@test.com'); // Email
    await tester.enterText(fields.at(2), '123456'); // Password
    await tester.enterText(fields.at(3), 'Kathmandu'); // Address
    await tester.enterText(fields.at(4), '9800000000'); // Phone

    // Tap Sign Up
    await tester.tap(find.text('Sign Up'));
    await tester.pump(); // first frame for async
    await tester.pumpAndSettle(); // wait for snackbar & rebuild

    // Verify error snackbar is shown
    expect(find.text('Register failed'), findsOneWidget);
  });
}
