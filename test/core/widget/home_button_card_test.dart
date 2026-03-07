import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/home_button_card.dart';

void main() {
  testWidgets('renders icon, title, and subtitle', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomeButtonCard(
            icon: '🌿',
            title: 'Plants',
            subtitle: 'Browse plants',
          ),
        ),
      ),
    );

    expect(find.text('🌿'), findsOneWidget);
    expect(find.text('Plants'), findsOneWidget);
    expect(find.text('Browse plants'), findsOneWidget);
  });

  testWidgets('calls onTap when card is tapped', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HomeButtonCard(
            icon: '🪴',
            title: 'Pots',
            subtitle: 'Browse pots',
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(HomeButtonCard));
    await tester.pump();
    expect(tapped, isTrue);
  });
}
