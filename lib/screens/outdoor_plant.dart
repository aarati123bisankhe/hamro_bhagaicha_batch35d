import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/plant_section.dart';
import 'package:hamro_bhagaicha_batch35d/widget/plant_section_card.dart';

class OutdoorPlantScreen extends StatelessWidget {
  const OutdoorPlantScreen({super.key});

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

            // 🔹 Header
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
                      'Outdoor Plants 🌿',
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
                hintText: 'Search outdoor plants...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
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
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PlantScreen(),
                        ),
                      );
                    },
                  ),
                  buildFilterChip(
                    context,
                    'Outdoor Plants',
                    selected: true,
                    onTap: () {},
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
                    imagePath: 'assets/images/rose.png',
                    name: 'Rose Plant',
                    description:
                        'A woody perennial flowering plant of the genus Rosa.',
                    price: 500,
                    rating: 5,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/marigoldplant.png',
                    name: 'Marigold Plant',
                    description:
                        'A hardy flowering plant that blooms all summer.',
                    price: 300,
                    rating: 4,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/sunflowerplant.png',
                    name: 'Sunflower Plant',
                    description:
                        'Tall, bright flowers that thrive in full sunlight.',
                    price: 450,
                    rating: 5,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/hibiscusplant.png',
                    name: 'Hibiscus Plant',
                    description:
                        'Large, colorful blooms that grow well outdoors.',
                    price: 600,
                    rating: 4,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/jasminplant.png',
                    name: 'Jasmine Plant',
                    description:
                        'Fragrant flowers perfect for gardens and balconies.',
                    price: 550,
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

