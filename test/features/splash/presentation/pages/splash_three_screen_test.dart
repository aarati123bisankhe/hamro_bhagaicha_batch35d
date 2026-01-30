import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_three_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/login_screen.dart';

void main() {
  testWidgets('SplashThreeScreen renders correctly', (WidgetTester tester) async {
    // ignore: deprecated_member_use
    tester.binding.window.physicalSizeTestValue = const Size(1200, 2400);
    // ignore: deprecated_member_use
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      const ProviderScope( 
        child: MaterialApp(home: SplashThreeScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Find Nearby Nurseries'), findsOneWidget);
    expect(find.text('“Locate the nearest plant nurseries instantly!”'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    expect(find.byType(Image), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);

    // ignore: deprecated_member_use
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  });
}
