import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/dashboard_screen.dart';

import 'package:hamro_bhagaicha_batch35d/screens/indoor_plant_screen.dart';
import 'package:hamro_bhagaicha_batch35d/screens/outdoor_plant.dart';
import 'package:hamro_bhagaicha_batch35d/widget/plant_section_card.dart';

class PlantScreen extends StatelessWidget {
  const PlantScreen({super.key});

  Widget buildFilterChip(
    BuildContext context,
    String label, {
    bool selected = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.green,
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
            const SizedBox(height: 80),

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

            const SizedBox(height: 30),

            TextField(
              decoration: InputDecoration(
                hintText: 'Search for a specific plant...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Color.fromARGB(255, 242, 251, 233),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildFilterChip(
                    context,
                    'Filter',
                    selected: true,
                    onTap: () {
                    },
                  ),
                  buildFilterChip(
                    context,
                    'Indoor Plants',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const IndoorPlantScreen(),
                        ),
                      );
                    },
                  ),
                  buildFilterChip(
                    context,
                    'Outdoot Plant',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OutdoorPlantScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            Expanded(
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.65,
                children: const [
                  PlantCard(
                    imagePath: 'assets/images/moneyplant.png',
                    name: 'Money Plant',
                    description: 'Easy to care for',
                    price: 400,
                    rating: 4,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/snakeplant.png',
                    name: 'Snake Plant',
                    description:
                        'Evergreen perennial typically grown as a houseplant',
                    price: 350,
                    rating: 3,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/rose.png',
                    name: 'Rose Plant',
                    description:
                        'Filling the garden with colour, fragrance, and beauty',
                    price: 300,
                    rating: 4,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/pathosplant.png',
                    name: 'Pothos Plant',
                    description: 'Genus of Plants',
                    price: 500,
                    rating: 4,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/spiderplant.png',
                    name: 'Spider Plant',
                    description: 'Easy to care',
                    price: 350,
                    rating: 4,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/rubberplant.png',
                    name: 'Rubber Plant',
                    description:
                        'easy-to-care-for plant lives for at least five years',
                    price: 300,
                    rating: 3,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/catpam.png',
                    name: 'Cat Palm',
                    description:
                        'Cat palms grow best in bright, indirect light.',
                    price: 500,
                    rating: 5,
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
