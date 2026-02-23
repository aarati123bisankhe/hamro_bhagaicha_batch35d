import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/plant_section.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/cart_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/cart_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/pot_section_card.dart';

class PotSectionScreen extends ConsumerWidget {
  const PotSectionScreen({super.key});

  Widget buildFilterChip(
    BuildContext context,
    String label, {
    required VoidCallback onTap,
    bool isTablet = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 25 : 15,
          vertical: isTablet ? 11 : 6,
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(isTablet ? 25 : 10),
          border: Border.all(color: Colors.green),
        ),
        child: Text(
          'Filter',
          style: TextStyle(
            fontSize: isTablet ? 20 : 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

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
              id: 'pot-$name-$imagePath',
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD8F3DC), Color(0xFF475E4F)],
          ),
        ),
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

            SizedBox(height: isTablet ? 60 : 40),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildFilterChip(
                    context,
                    'Filter',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const PlantScreen()),
                      );
                    },
                    isTablet: isTablet,
                  ),
                ],
              ),
            ),

            SizedBox(height: isTablet ? 50 : 30),

            Expanded(
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: isTablet ? 2 : 2,
                mainAxisSpacing: isTablet ? 20 : 15,
                crossAxisSpacing: isTablet ? 20 : 15,
                childAspectRatio: isTablet ? 0.8 : 0.65,
                children: [
                  PotSectionCard(
                    imagePath: 'assets/images/pot1.png',
                    name: '9 Inch Wall Hanging Half Round Planter/Flower',
                    price: 250,
                    rating: 4,
                    onAdd: () => addToCart(
                      name: '9 Inch Wall Hanging Half Round Planter/Flower',
                      imagePath: 'assets/images/pot1.png',
                      price: 250,
                    ),
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot2.jpeg',
                    name: '5 pics Beautiful 5 Inch Table Decor Flower pot',
                    price: 300,
                    rating: 4,
                    onAdd: () => addToCart(
                      name: '5 pics Beautiful 5 Inch Table Decor Flower pot',
                      imagePath: 'assets/images/pot2.jpeg',
                      price: 300,
                    ),
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot3.png',
                    name: 'Small White Bonsai Bowl Planter',
                    price: 1000,
                    rating: 2,
                    onAdd: () => addToCart(
                      name: 'Small White Bonsai Bowl Planter',
                      imagePath: 'assets/images/pot3.png',
                      price: 1000,
                    ),
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot4.png',
                    name: 'Cute Ceramic Succulent Pot (4 Inch)',
                    price: 2400,
                    rating: 5,
                    onAdd: () => addToCart(
                      name: 'Cute Ceramic Succulent Pot (4 Inch)',
                      imagePath: 'assets/images/pot4.png',
                      price: 2400,
                    ),
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot5.png',
                    name: '8 Inch White Cylindrical Ceramic Pot For Indoor ',
                    price: 1200,
                    rating: 4,
                    onAdd: () => addToCart(
                      name: '8 Inch White Cylindrical Ceramic Pot For Indoor ',
                      imagePath: 'assets/images/pot5.png',
                      price: 1200,
                    ),
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot6.png',
                    name: 'Cute Ceramic Succulent Planter For Indoor',
                    price: 1500,
                    rating: 3,
                    onAdd: () => addToCart(
                      name: 'Cute Ceramic Succulent Planter For Indoor',
                      imagePath: 'assets/images/pot6.png',
                      price: 1500,
                    ),
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot7.png',
                    name: 'Reusable 104 Holes Seedling Tray (Set of 3)',
                    price: 2000,
                    rating: 5,
                    onAdd: () => addToCart(
                      name: 'Reusable 104 Holes Seedling Tray (Set of 3)',
                      imagePath: 'assets/images/pot7.png',
                      price: 2000,
                    ),
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot8.png',
                    name: '5Pcs 6 Inch Multicolor Hooked Hanging Flower Pot',
                    price: 900,
                    rating: 3,
                    onAdd: () => addToCart(
                      name: '5Pcs 6 Inch Multicolor Hooked Hanging Flower Pot',
                      imagePath: 'assets/images/pot8.png',
                      price: 900,
                    ),
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot9.png',
                    name: '10 Pcs 6 Inch Soft Flexible Nursery Planter',
                    price: 500,
                    rating: 4,
                    onAdd: () => addToCart(
                      name: '10 Pcs 6 Inch Soft Flexible Nursery Planter',
                      imagePath: 'assets/images/pot9.png',
                      price: 500,
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
