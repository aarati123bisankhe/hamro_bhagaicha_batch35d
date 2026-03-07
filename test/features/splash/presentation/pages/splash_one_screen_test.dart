import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_one_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_two_screen.dart';

void main() {
  Future<void> pumpSplashOne(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(home: SplashOneScreen()));
  }

  testWidgets('renders key content for step one', (WidgetTester tester) async {
    await pumpSplashOne(tester);

    expect(find.text('Step 1 of 3'), findsOneWidget);
    expect(find.text('Welcome to\nHamro Bhagaicha'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
    expect(find.byIcon(Icons.eco_outlined), findsOneWidget);
  });

  testWidgets('tapping Start navigates to SplashTwoScreen', (
    WidgetTester tester,
  ) async {
    await pumpSplashOne(tester);

    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();

    expect(find.byType(SplashTwoScreen), findsOneWidget);
  });
}
