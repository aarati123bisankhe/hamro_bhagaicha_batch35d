import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/plant_section.dart';
import 'package:hamro_bhagaicha_batch35d/widget/plant_section_card.dart';

class IndoorPlantScreen extends StatelessWidget {
  const IndoorPlantScreen({super.key});

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
                      'Indoor Plants 🌱',
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
                hintText: 'Search indoor plants...',
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
                    'Indoor Plants',
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
                    imagePath: 'assets/images/tradescantta plant.png',
                    name: 'Tradescantta Plant',
                    description: 'An easy-to-grow, trailing plant that is great for beginners',
                    price: 800,
                    rating: 4,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/snakeplant.png',
                    name: 'Snake Plant',
                    description: 'Low light & air purifier',
                    price: 350,
                    rating: 3,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/ruberplant.png',
                    name: 'Rubber Plant',
                    description: 'Fertilize every two weeks when actively growing from spring through fall',
                    price: 670,
                    rating: 5,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/castironplant.png',
                    name: 'Cast iron Plant',
                    description: 'A good choice for dimly lit rooms and rooms with northern exposure.',
                    price: 670,
                    rating: 5,
                  ),
                  PlantCard(
                    imagePath: 'assets/images/peacelilyplant.png',
                    name: 'Peace Lily Plant',
                    description: 'Pure white spathes surrounding creamy white flower spikes bloom',
                    price: 670,
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
