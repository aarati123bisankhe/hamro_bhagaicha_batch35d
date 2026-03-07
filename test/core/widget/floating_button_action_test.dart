import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/floating_button_action.dart';

void main() {
  testWidgets('renders elevated button with text', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyFloatingButton(onPressed: () {}, text: 'Continue'),
        ),
      ),
    );

    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('triggers onPressed callback', (tester) async {
    var called = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyFloatingButton(onPressed: () => called = true, text: 'Save'),
        ),
      ),
    );

    await tester.tap(find.text('Save'));
    await tester.pump();
    expect(called, isTrue);
  });
}
