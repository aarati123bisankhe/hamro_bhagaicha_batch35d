import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/dashboard_screen.dart';
import 'package:hamro_bhagaicha_batch35d/widget/combo_set_card.dart';

class ComboSetScreen extends StatelessWidget {
  const ComboSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600; 
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
        padding:  EdgeInsets.symmetric(horizontal: isTablet ? 32 :  16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: isTablet ? 100 :  90),

            
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
                    height: isTablet ? 40 :  28,
                    width: isTablet ? 40 :  28,
                  ),
                ),
                 Expanded(
                  child: Center(
                    child: Text(
                      'Hamro Bhagaicha 🌿',
                      style: TextStyle(
                        fontSize:  isTablet ? 34 :26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),

             SizedBox(height: isTablet ? 80 : 40),

            // Subtitle
             Text(
              "Start Your Garden Today! Hand-picked Plants & Perfect Plots",
             
              style: TextStyle(
                fontSize: isTablet ? 27 : 18,
                color: Color.fromARGB(221, 128, 56, 1),
              ),
            ),

          SizedBox(height: isTablet ? 10 :  10),
             Text(
              "(or आजै आफ्नो बगैंचा सुरु गर्नुहोस्!)🌱",
             
              style: TextStyle(
                fontSize: isTablet ? 27 :  18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(221, 9, 46, 16),
              ),
            ),

             SizedBox(height: isTablet ? 60 :  35),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  ComboSetCard(
                    imagePath: 'assets/images/combo1.png',
                    name: 'Kraft Seeds 10 Inch Pack of 6 Flower Pots for Garden with Bottom Plate & Drainage Hole,Plastic Pot for Plants,',
                    price: 1000,
                    rating: 4,
                  ),
                  ComboSetCard(
                    imagePath: 'assets/images/combo2.png',
                    name: 'Set of 4 Indoor Plants: Spider Plant, Peace Lily, Snake Plant, & Money Plant',
                    price: 2500,
                    rating: 5,
                  ),
                  ComboSetCard(
                    imagePath: 'assets/images/combo3.png',
                    name: 'Set of 6 live Adenium Obesum (Desert Rose) plants, ready for transplanting into your preferred containers, delivered with 4 pots',
                    price: 3500,
                    rating: 4,
                  ),
                  ComboSetCard(
                    imagePath: 'assets/images/combo4.png',
                    name: 'Spider Plant, Snake Plant & Money Plant Combo – Set of 3 ',
                    price: 1500,
                    rating: 3,
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
