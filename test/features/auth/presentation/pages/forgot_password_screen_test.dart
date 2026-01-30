import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/login_screen.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_field.dart';

void main() {
  testWidgets('ForgotPasswordScreen widget test', (WidgetTester tester) async {
    // Wrap in MaterialApp to support navigation
    await tester.pumpWidget(
      MaterialApp(
        home: ForgotPasswordScreen(),
      ),
    );

    // Title
    expect(find.text('Forgot Password'), findsOneWidget);

    // Instructions
    expect(find.text("Enter your email below. We'll send you"), findsOneWidget);
    expect(find.text("instructions to reset your password."), findsOneWidget);

    // Email field
    final emailField = find.byType(MyTextField);
    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, 'test@example.com');
    await tester.pump();
    expect(find.text('test@example.com'), findsOneWidget);

    // Scroll to and tap Reset Password
    final resetButton = find.text('Reset Password');
    await tester.ensureVisible(resetButton);
    await tester.tap(resetButton);
    await tester.pump();

    // Scroll to and tap Login
    final loginText = find.text('Login');
    await tester.ensureVisible(loginText);
    await tester.tap(loginText);

    // Wait for navigation animation
    await tester.pumpAndSettle();

    // Verify navigation to LoginScreen
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
