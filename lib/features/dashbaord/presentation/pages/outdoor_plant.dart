import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/plant_section.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/plant_section_card.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/cart_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/cart_view_model.dart';

class OutdoorPlantScreen extends ConsumerWidget {
  const OutdoorPlantScreen({super.key});

  Widget buildFilterChip(
    BuildContext context,
    String label, {
    bool selected = false,
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
          color: selected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(isTablet ? 25 : 10),
          border: Border.all(color: Colors.green),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: isTablet ? 20 : 14,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.green,
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
              id: 'plant-$name-$imagePath',
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
            SizedBox(height: isTablet ? 100 : 80),

            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
                      'Outdoor Plants 🌿',
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

            SizedBox(height: isTablet ? 60 : 30),

            TextField(
              decoration: InputDecoration(
                hintText: 'Search for a specific plant...',
                prefixIcon: Icon(Icons.search, size: isTablet ? 35 : 24),
                hintStyle: TextStyle(fontSize: isTablet ? 20 : 14),
                filled: true,
                fillColor: Color.fromARGB(255, 242, 251, 233),
                contentPadding: EdgeInsets.symmetric(
                  vertical: isTablet ? 19 : 12,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(isTablet ? 40 : 20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: isTablet ? 45 : 25),

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
                  buildFilterChip(
                    context,
                    'Outdoor Plants',
                    selected: true,
                    onTap: () {},
                    isTablet: isTablet,
                  ),
                ],
              ),
            ),

            SizedBox(height: isTablet ? 45 : 26),

            Expanded(
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: isTablet ? 3 : 2,
                mainAxisSpacing: isTablet ? 20 : 15,
                crossAxisSpacing: isTablet ? 20 : 15,
                childAspectRatio: isTablet ? 0.5 : 0.65,
                children: [
                  PlantCard(
                    imagePath: 'assets/images/rose.png',
                    name: 'Rose Plant',
                    description:
                        'A woody perennial flowering plant of the genus Rosa.',
                    price: 500,
                    rating: 5,
                    onAdd: () => addToCart(
                      name: 'Rose Plant',
                      imagePath: 'assets/images/rose.png',
                      price: 500,
                    ),
                  ),
                  PlantCard(
                    imagePath: 'assets/images/marigoldplant.png',
                    name: 'Marigold Plant',
                    description:
                        'A hardy flowering plant that blooms all summer.',
                    price: 300,
                    rating: 4,
                    onAdd: () => addToCart(
                      name: 'Marigold Plant',
                      imagePath: 'assets/images/marigoldplant.png',
                      price: 300,
                    ),
                  ),
                  PlantCard(
                    imagePath: 'assets/images/sunflowerplant.png',
                    name: 'Sunflower Plant',
                    description:
                        'Tall, bright flowers that thrive in full sunlight.',
                    price: 450,
                    rating: 5,
                    onAdd: () => addToCart(
                      name: 'Sunflower Plant',
                      imagePath: 'assets/images/sunflowerplant.png',
                      price: 450,
                    ),
                  ),
                  PlantCard(
                    imagePath: 'assets/images/hibiscusplant.png',
                    name: 'Hibiscus Plant',
                    description:
                        'Large, colorful blooms that grow well outdoors.',
                    price: 600,
                    rating: 4,
                    onAdd: () => addToCart(
                      name: 'Hibiscus Plant',
                      imagePath: 'assets/images/hibiscusplant.png',
                      price: 600,
                    ),
                  ),
                  PlantCard(
                    imagePath: 'assets/images/jasminplant.png',
                    name: 'Jasmine Plant',
                    description:
                        'Fragrant flowers perfect for gardens and balconies.',
                    price: 550,
                    rating: 5,
                    onAdd: () => addToCart(
                      name: 'Jasmine Plant',
                      imagePath: 'assets/images/jasminplant.png',
                      price: 550,
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
