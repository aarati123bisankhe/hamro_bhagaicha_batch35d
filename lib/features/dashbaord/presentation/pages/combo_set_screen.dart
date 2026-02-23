import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/cart_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/cart_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/combo_set_card.dart';

class ComboSetScreen extends ConsumerWidget {
  const ComboSetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    void addToCart({
      required String name,
      required String imagePath,
      required int price,
    }) {
      ref
          .read(cartViewModelProvider.notifier)
          .addItem(
            CartItem(
              id: 'combo-$name-$imagePath',
              imagePath: imagePath,
              name: name,
              price: price,
            ),
          );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(initialIndex: 3),
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: appBackgroundDecoration(context),
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: isTablet ? 100 : 90),

            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DashboardScreen(),
                      ),
                    );
                  },
                  child: Image.asset(
                    "assets/icons/arrow icon.png",
                    height: isTablet ? 40 : 28,
                    width: isTablet ? 40 : 28,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Hamro Bhagaicha 🌿',
                      style: TextStyle(
                        fontSize: isTablet ? 34 : 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: isTablet ? 80 : 40),

            Text(
              "Start Your Garden Today! Hand-picked Plants & Perfect Plots",

              style: TextStyle(
                fontSize: isTablet ? 27 : 18,
                color: Color.fromARGB(221, 128, 56, 1),
              ),
            ),

            SizedBox(height: isTablet ? 10 : 10),
            Text(
              "(or आजै आफ्नो बगैंचा सुरु गर्नुहोस्!)🌱",

              style: TextStyle(
                fontSize: isTablet ? 27 : 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(221, 9, 46, 16),
              ),
            ),

            SizedBox(height: isTablet ? 60 : 35),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ComboSetCard(
                    imagePath: 'assets/images/combo1.png',
                    name:
                        'Kraft Seeds 10 Inch Pack of 6 Flower Pots for Garden with Bottom Plate & Drainage Hole,Plastic Pot for Plants,',
                    price: 1000,
                    rating: 4,
                    onAdd: () => addToCart(
                      name:
                          'Kraft Seeds 10 Inch Pack of 6 Flower Pots for Garden with Bottom Plate & Drainage Hole,Plastic Pot for Plants,',
                      imagePath: 'assets/images/combo1.png',
                      price: 1000,
                    ),
                  ),
                  ComboSetCard(
                    imagePath: 'assets/images/combo2.png',
                    name:
                        'Set of 4 Indoor Plants: Spider Plant, Peace Lily, Snake Plant, & Money Plant',
                    price: 2500,
                    rating: 5,
                    onAdd: () => addToCart(
                      name:
                          'Set of 4 Indoor Plants: Spider Plant, Peace Lily, Snake Plant, & Money Plant',
                      imagePath: 'assets/images/combo2.png',
                      price: 2500,
                    ),
                  ),
                  ComboSetCard(
                    imagePath: 'assets/images/combo3.png',
                    name:
                        'Set of 6 live Adenium Obesum (Desert Rose) plants, ready for transplanting into your preferred containers, delivered with 4 pots',
                    price: 3500,
                    rating: 4,
                    onAdd: () => addToCart(
                      name:
                          'Set of 6 live Adenium Obesum (Desert Rose) plants, ready for transplanting into your preferred containers, delivered with 4 pots',
                      imagePath: 'assets/images/combo3.png',
                      price: 3500,
                    ),
                  ),
                  ComboSetCard(
                    imagePath: 'assets/images/combo4.png',
                    name:
                        'Spider Plant, Snake Plant & Money Plant Combo – Set of 3 ',
                    price: 1500,
                    rating: 3,
                    onAdd: () => addToCart(
                      name:
                          'Spider Plant, Snake Plant & Money Plant Combo – Set of 3 ',
                      imagePath: 'assets/images/combo4.png',
                      price: 1500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
