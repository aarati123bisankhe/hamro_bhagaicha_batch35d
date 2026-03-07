import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/tip_card.dart';

void main() {
  testWidgets('renders title, description, and read time', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TipCard(
            imageUrl: 'assets/icons/icon.png',
            title: 'Watering Tips',
            description: 'Water plants in the morning.',
            readTime: '3 min',
            isSaved: false,
            onToggleSave: () {},
          ),
        ),
      ),
    );

    expect(find.text('Watering Tips'), findsOneWidget);
    expect(find.text('Water plants in the morning.'), findsOneWidget);
    expect(find.text('3 min'), findsOneWidget);
  });

  testWidgets('invokes save toggle callback', (tester) async {
    var toggled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TipCard(
            imageUrl: 'assets/icons/icon.png',
            title: 'Care',
            description: 'desc',
            readTime: '1 min',
            isSaved: false,
            onToggleSave: () => toggled = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.bookmark_border));
    await tester.pump();
    expect(toggled, isTrue);
  });
}
