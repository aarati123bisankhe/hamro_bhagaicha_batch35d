import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_endpoint.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/combo_set_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/notification.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/plant_section.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/pot_section_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/today_tips.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/home_button_card.dart';
import 'package:flutter/services.dart';

class DashboardHomeScreen extends ConsumerStatefulWidget {
  const DashboardHomeScreen({super.key});

  @override
  ConsumerState<DashboardHomeScreen> createState() =>
      _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends ConsumerState<DashboardHomeScreen> {
  static const List<String> _tips = [
    'Fertilize plants every 2–4 weeks during spring and summer.',
    'Water only when the top inch of soil feels dry.',
  ];

  int _tipIndex = 0;
  Timer? _tipTimer;

  @override
  void initState() {
    super.initState();
    _tipTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!mounted) return;
      setState(() {
        _tipIndex = (_tipIndex + 1) % _tips.length;
      });
    });
  }

  @override
  void dispose() {
    _tipTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final authState = ref.watch(authViewModelProvider);
    final user = authState.authEntity;
    final profilePicture = user?.profilePicture;
    final hasProfileImage = profilePicture != null && profilePicture.isNotEmpty;
    final String profileImageName = hasProfileImage ? profilePicture : '';
    final displayName = user?.fullname.trim().isNotEmpty == true
        ? user!.fullname.trim()
        : 'User';

    return Scaffold(
      extendBodyBehindAppBar: true,
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
          top: true,
          bottom: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 50 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isTablet ? 45 : 50),

                Center(
                  child: Text(
                    'Hamro Bhagaicha 🌿',
                    style: TextStyle(
                      fontSize: isTablet ? 50 : 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                SizedBox(height: isTablet ? 87 : 45),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: isTablet ? 30 : 15,
                          backgroundImage: hasProfileImage
                              ? NetworkImage(
                                  ApiEndpoints.profileImageUrl(
                                    profileImageName,
                                  ),
                                )
                              : null,
                          child: !hasProfileImage
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Welcome $displayName!',
                          style: TextStyle(
                            fontSize: isTablet ? 30 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      iconSize: isTablet ? 38 : 28,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.notifications_outlined),
                    ),
                  ],
                ),

                SizedBox(height: isTablet ? 50 : 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search nearest nursery...',
                    prefixIcon: Icon(Icons.search, size: isTablet ? 35 : 20),
                    hintStyle: TextStyle(fontSize: isTablet ? 20 : 14),
                    filled: true,
                    fillColor: Color.fromARGB(255, 242, 251, 233),

                    contentPadding: EdgeInsets.symmetric(
                      vertical: isTablet ? 25 : 0,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(isTablet ? 40 : 20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 30),
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
                            MaterialPageRoute(
                              builder: (context) => PlantScreen(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: isTablet ? 24 : 20),
                      HomeButtonCard(
                        icon: '🪴',
                        title: 'Pot',
                        subtitle:
                            'Add this pot to your garden collection and style your plants beautifully',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PotSectionScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: isTablet ? 24 : 20),
                      HomeButtonCard(
                        icon: '🌱🪴',
                        title: 'Plant + Pot Combo',
                        subtitle:
                            'Get this plant + pot combo and brighten your garden – a perfect duo for your green space',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComboSetScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: isTablet ? 24 : 20),
                      HomeButtonCard(
                        icon: '💡',
                        title: "Today's Tips",
                        subtitle: _tips[_tipIndex],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TodayTips(),
                            ),
                          );
                        },
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
