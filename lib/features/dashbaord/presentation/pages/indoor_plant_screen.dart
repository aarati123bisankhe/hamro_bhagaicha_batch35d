import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/plant_section.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/plant_section_card.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/cart_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/cart_view_model.dart';

class IndoorPlantScreen extends ConsumerWidget {
  const IndoorPlantScreen({super.key});

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
        margin: EdgeInsets.only(right: 8),
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
                      'Indoor Plants 🌱',
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
                    'Indoor Plants',
                    selected: true,
                    onTap: () {},
                    isTablet: isTablet,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            Expanded(
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: isTablet ? 3 : 2,
                mainAxisSpacing: isTablet ? 20 : 15,
                crossAxisSpacing: isTablet ? 20 : 15,
                childAspectRatio: isTablet ? 0.8 : 0.65,
                children: [
                  PlantCard(
                    imagePath: 'assets/images/tradescantta plant.png',
                    name: 'Tradescantta Plant',
                    description:
                        'An easy-to-grow, trailing plant that is great for beginners',
                    price: 800,
                    rating: 4,
                    onAdd: () => addToCart(
                      name: 'Tradescantta Plant',
                      imagePath: 'assets/images/tradescantta plant.png',
                      price: 800,
                    ),
                  ),
                  PlantCard(
                    imagePath: 'assets/images/snakeplant.png',
                    name: 'Snake Plant',
                    description: 'Low light & air purifier',
                    price: 350,
                    rating: 3,
                    onAdd: () => addToCart(
                      name: 'Snake Plant',
                      imagePath: 'assets/images/snakeplant.png',
                      price: 350,
                    ),
                  ),
                  PlantCard(
                    imagePath: 'assets/images/ruberplant.png',
                    name: 'Rubber Plant',
                    description:
                        'Fertilize every two weeks when actively growing from spring through fall',
                    price: 670,
                    rating: 5,
                    onAdd: () => addToCart(
                      name: 'Rubber Plant',
                      imagePath: 'assets/images/ruberplant.png',
                      price: 670,
                    ),
                  ),
                  PlantCard(
                    imagePath: 'assets/images/castironplant.png',
                    name: 'Cast iron Plant',
                    description:
                        'A good choice for dimly lit rooms and rooms with northern exposure.',
                    price: 670,
                    rating: 5,
                    onAdd: () => addToCart(
                      name: 'Cast iron Plant',
                      imagePath: 'assets/images/castironplant.png',
                      price: 670,
                    ),
                  ),
                  PlantCard(
                    imagePath: 'assets/images/peacelilyplant.png',
                    name: 'Peace Lily Plant',
                    description:
                        'Pure white spathes surrounding creamy white flower spikes bloom',
                    price: 670,
                    rating: 5,
                    onAdd: () => addToCart(
                      name: 'Peace Lily Plant',
                      imagePath: 'assets/images/peacelilyplant.png',
                      price: 670,
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
