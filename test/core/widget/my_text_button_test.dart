import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_button.dart';

void main() {
  testWidgets('renders text label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyTextButton(onPressed: () {}, text: 'Forgot Password'),
        ),
      ),
    );

    expect(find.text('Forgot Password'), findsOneWidget);
  });

  testWidgets('calls onPressed when tapped', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyTextButton(onPressed: () => tapped = true, text: 'Tap'),
        ),
      ),
    );

    await tester.tap(find.text('Tap'));
    await tester.pump();
    expect(tapped, isTrue);
  });
}
