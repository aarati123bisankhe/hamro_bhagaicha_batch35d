import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/dashboard_screen.dart';
import 'package:hamro_bhagaicha_batch35d/screens/plant_section.dart';
import 'package:hamro_bhagaicha_batch35d/widget/pot_section_card.dart';

class PotSectionScreen extends StatelessWidget {
  const PotSectionScreen({super.key});

  // 🔹 Filter Chip
  Widget buildFilterChip(
    BuildContext context,
    String label, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green),
        ),
        child: const Text(
          'Filter',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD8F3DC),
              Color(0xFF475E4F),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 90),

            // 🔹 Header
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to home/dashboard
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DashboardScreen(),
                      ),
                    );
                  },
                  child: Image.asset(
                    "assets/icons/arrow icon.png",
                    height: 28,
                    width: 28,
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Hamro Bhagaicha 🌿',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 🔹 Only Filter Chip
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
                        MaterialPageRoute(
                          builder: (_) => const PlantScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 Grid of Pots (image, name, price, rating)
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.65,
                children: const [
                  PotSectionCard(
                    imagePath: 'assets/images/pot1.png',
                    name: '9 Inch Wall Hanging Half Round Planter/Flower',
                    
                    price: 250,
                    rating: 4,
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot2.jpeg',
                    name: '5 pics Beautiful 5 Inch Table Decor Flower pot',
                    price: 300,
                    rating: 4,
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot3.png',
                    name: 'Small White Bonsai Bowl Planter',
                    price: 1000,
                    rating: 2,
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot4.png',
                    name: 'Cute Ceramic Succulent Pot (4 Inch)',
                    price: 2400,
                    rating: 5,
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot5.png',
                    name: '8 Inch White Cylindrical Ceramic Pot For Indoor ',
                    price: 1200,
                    rating: 4,
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot6.png',
                    name: 'Cute Ceramic Succulent Planter For Indoor',
                    price: 1500,
                    rating: 3,
                  ),
                 PotSectionCard(
                    imagePath: 'assets/images/pot7.png',
                    name: 'Reusable 104 Holes Seedling Tray (Set of 3)',
                    price: 2000,
                    rating: 5,
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot8.png',
                    name: '5Pcs 6 Inch Multicolor Hooked Hanging Flower Pot',
                    price: 900,
                    rating: 3,
                  ),
                  PotSectionCard(
                    imagePath: 'assets/images/pot9.png',
                    name: '10 Pcs 6 Inch Soft Flexible Nursery Planter',
                    price: 500,
                    rating: 4,
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
