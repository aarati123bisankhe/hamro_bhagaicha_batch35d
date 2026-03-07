import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_two_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_three_screen.dart';

void main() {
  Future<void> pumpSplashTwo(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(home: SplashTwoScreen()));
  }

  testWidgets('renders key content for step two', (WidgetTester tester) async {
    await pumpSplashTwo(tester);

    expect(find.text('Step 2 of 3'), findsOneWidget);
    expect(find.text('Scan With Confidence'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.byIcon(Icons.tips_and_updates_outlined), findsOneWidget);
  });

  testWidgets('tapping Next navigates to SplashThreeScreen', (
    WidgetTester tester,
  ) async {
    await pumpSplashTwo(tester);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.byType(SplashThreeScreen), findsOneWidget);
  });
}
