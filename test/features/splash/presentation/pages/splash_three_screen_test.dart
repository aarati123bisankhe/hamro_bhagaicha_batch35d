import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_three_screen.dart';

void main() {
  Future<void> pumpSplashThree(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(home: SplashThreeScreen()));
  }

  testWidgets('renders key content for step three', (
    WidgetTester tester,
  ) async {
    await pumpSplashThree(tester);

    expect(find.text('Step 3 of 3'), findsOneWidget);
    expect(find.text('Find Nearby\nNurseries'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('shows location hint icon', (WidgetTester tester) async {
    await pumpSplashThree(tester);

    expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);
  });
}
