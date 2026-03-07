import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_outline_button.dart';

void main() {
  testWidgets('renders outlined button with label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyOutlinedButton(onPressed: () {}, text: 'Sign in'),
        ),
      ),
    );

    expect(find.text('Sign in'), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
  });

  testWidgets('invokes callback on tap', (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyOutlinedButton(onPressed: () => pressed = true, text: 'Go'),
        ),
      ),
    );

    await tester.tap(find.text('Go'));
    await tester.pump();
    expect(pressed, isTrue);
  });
}
