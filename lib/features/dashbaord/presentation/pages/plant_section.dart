import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';

import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/indoor_plant_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/outdoor_plant.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/plant_section_card.dart';

class PlantScreen extends StatelessWidget {
  const PlantScreen({super.key});

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
        margin:  EdgeInsets.only(right: 8),
        padding:  EdgeInsets.symmetric(horizontal: isTablet ? 25 :  15, 
        vertical: isTablet ? 11 :6),
        decoration: BoxDecoration(
          color: selected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(isTablet ? 25 :10),
          border: Border.all(color: Colors.green),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: isTablet ? 20: 14,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.green,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600; // simple tablet check
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
        padding:  EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: isTablet ? 100 : 80),

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

             SizedBox(height: isTablet ? 60 : 30),

            TextField(
              decoration: InputDecoration(
                hintText: 'Search for a specific plant...',
                prefixIcon:  Icon(Icons.search,
                size: isTablet ? 35 : 24,),
                hintStyle: TextStyle(fontSize: isTablet ? 20 : 14),
                filled: true,
                fillColor: Color.fromARGB(255, 242, 251, 233),
                contentPadding:
                     EdgeInsets.symmetric(
                      vertical: isTablet ? 19 : 12,
                      horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(isTablet ? 40 :20),
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
                    selected: true,
                    onTap: () {},
                    isTablet: isTablet,
                    
                    
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
                    isTablet: isTablet,
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
                     isTablet: isTablet,
                  ),
                ],
              ),
            ),

             SizedBox(height: isTablet ? 45 :  26),

            Expanded(
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: isTablet ? 3 : 2,
                mainAxisSpacing: isTablet ? 20 : 15,
                crossAxisSpacing:  isTablet ? 20 :15,
                childAspectRatio: isTablet ? 0.8 : 0.65,
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
