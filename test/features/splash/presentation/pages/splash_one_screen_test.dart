import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_one_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_two_screen.dart';

void main() {
  testWidgets('SplashOneScreen renders correctly', (WidgetTester tester) async {
    // ignore: deprecated_member_use
    tester.binding.window.physicalSizeTestValue = const Size(1200, 2400);
    // ignore: deprecated_member_use
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(const MaterialApp(
      home: SplashOneScreen(),
    ));

    expect(find.text('Welcome to'), findsOneWidget);
    expect(find.text('Hamro Bhagaicha 🌿'), findsOneWidget);
    expect(find.text('“A digital space where plant lovers grow, share, and learn together.”'), findsOneWidget);

    expect(find.text('Get Started'), findsOneWidget);

    expect(find.byType(Image), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.byType(SplashTwoScreen), findsOneWidget);

    // ignore: deprecated_member_use
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  });
}
