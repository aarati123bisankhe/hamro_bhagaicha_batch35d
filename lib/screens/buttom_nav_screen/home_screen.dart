import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/plant_section.dart';
import 'package:hamro_bhagaicha_batch35d/screens/pot_section_screen.dart';
import 'package:hamro_bhagaicha_batch35d/widget/home_button_card.dart';
import 'package:flutter/services.dart';

class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true, // allows body to go behind notch
      backgroundColor: Colors.transparent,
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
        child: SafeArea(
          top: true, // keeps content below notch
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // App Name / Logo
                const Center(
                  child: Text(
                    'Hamro Bhagaicha 🌿',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 45),

                // Welcome Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?img=3',
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Welcome Aarati!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_outlined),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Search Field
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search nearest nursery...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Home Buttons
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      HomeButtonCard(
                        icon: '🌱',
                        title: 'Plants',
                        subtitle:
                            'Give this plant a new home – make your garden greener!',
                          onTap: () {
                           Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => PlantScreen()),
                          );
                        },
                      ),
                      
                      SizedBox(height: 12),
                      HomeButtonCard(
                        icon: '🪴',
                        title: 'Pot',
                        subtitle:
                            'Add this pot to your garden collection and style your plants beautifully',
                            onTap: () {
                           Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => PotSectionScreen()),
                          );
                        },
                      ),
                      SizedBox(height: 12),
                      HomeButtonCard(
                        icon: '🌱🪴',
                        title: 'Plant + Pot Combo',
                        subtitle:
                            'Get this plant + pot combo and brighten your garden – a perfect duo for your green space',
                      ),
                      SizedBox(height: 12),
                      HomeButtonCard(
                        icon: '💡',
                        title: "Today's Tips",
                        subtitle:
                            'Water early in the morning for the best growth!',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
