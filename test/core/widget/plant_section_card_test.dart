import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/plant_section_card.dart';

void main() {
  Widget buildHost(Widget child) {
    return MaterialApp(
      home: Scaffold(body: SizedBox(height: 320, child: child)),
    );
  }

  testWidgets('renders plant name and price', (tester) async {
    await tester.pumpWidget(
      buildHost(
        PlantCard(
          imagePath: 'assets/icons/icon.png',
          name: 'Monstera',
          description: 'Indoor plant',
          price: 500,
          rating: 4,
          onAdd: () {},
        ),
      ),
    );

    expect(find.text('Monstera'), findsOneWidget);
    expect(find.text('NRP 500'), findsOneWidget);
    expect(find.text('Add to Cart'), findsOneWidget);
  });

  testWidgets('fires add to cart callback', (tester) async {
    var added = false;
    await tester.pumpWidget(
      buildHost(
        PlantCard(
          imagePath: 'assets/icons/icon.png',
          name: 'Rose',
          description: 'Outdoor',
          price: 250,
          rating: 3,
          onAdd: () => added = true,
        ),
      ),
    );

    await tester.tap(find.text('Add to Cart'));
    await tester.pump();
    expect(added, isTrue);
  });
}
