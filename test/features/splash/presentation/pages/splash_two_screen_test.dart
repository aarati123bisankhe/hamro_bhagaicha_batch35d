import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_two_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_three_screen.dart';

void main() {
  testWidgets('SplashTwoScreen renders correctly', (WidgetTester tester) async {
    // Override screen size so no overflow occurs
    // ignore: deprecated_member_use
    tester.binding.window.physicalSizeTestValue = const Size(1200, 2400);
    // ignore: deprecated_member_use
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(const MaterialApp(
      home: SplashTwoScreen(),
    ));

    // Verify texts
    expect(find.text('Hamro Bhagaicha 🌿'), findsOneWidget);
    expect(find.text('“Scan plants instantly and know them instantly”'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    // Verify image is present
    expect(find.byType(Image), findsOneWidget);

    // Tap the "Next" button
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Verify navigation to SplashThreeScreen
    expect(find.byType(SplashThreeScreen), findsOneWidget);

    // Reset the screen size after the test
    // ignore: deprecated_member_use
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  });
}
