import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/pot_section_card.dart';

void main() {
  Widget buildHost(Widget child) {
    return MaterialApp(
      home: Scaffold(body: SizedBox(height: 320, child: child)),
    );
  }

  testWidgets('renders pot card details', (tester) async {
    await tester.pumpWidget(
      buildHost(
        PotSectionCard(
          imagePath: 'assets/icons/icon.png',
          name: 'Ceramic Pot',
          price: 800,
          rating: 5,
          onAdd: () {},
        ),
      ),
    );

    expect(find.text('Ceramic Pot'), findsOneWidget);
    expect(find.text('NRP 800'), findsOneWidget);
    expect(find.text('Add to Cart'), findsOneWidget);
  });

  testWidgets('fires wishlist toggle callback', (tester) async {
    var toggled = false;
    await tester.pumpWidget(
      buildHost(
        PotSectionCard(
          imagePath: 'assets/icons/icon.png',
          name: 'Wood Pot',
          price: 350,
          rating: 3,
          onToggleWishlist: () => toggled = true,
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    expect(toggled, isTrue);
  });
}
