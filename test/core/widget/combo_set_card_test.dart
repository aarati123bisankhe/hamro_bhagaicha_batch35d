import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/combo_set_card.dart';

void main() {
  testWidgets('renders combo set card details', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ComboSetCard(
            imagePath: 'assets/icons/icon.png',
            name: 'Starter Combo',
            price: 1200,
            rating: 4,
            onAdd: () {},
          ),
        ),
      ),
    );

    expect(find.text('Plant + Pot Combo'), findsOneWidget);
    expect(find.text('Starter Combo'), findsOneWidget);
    expect(find.text('NRP 1200'), findsOneWidget);
    expect(find.text('Add to Cart'), findsOneWidget);
  });
}
