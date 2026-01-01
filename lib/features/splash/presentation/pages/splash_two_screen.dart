import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_three_screen.dart';

class SplashTwoScreen extends StatelessWidget {
  const SplashTwoScreen({super.key});

  @override
     Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = constraints.maxWidth >= 600;

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
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 50 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isTablet ? 120 : 80),

                Row(
                  children: [
                    Text(
                      "Hamro Bhagaicha 🌿",
                      style: TextStyle(
                        fontSize: isTablet ? 45 : 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 13),

                Text(
                  "“Scan plants instantly and know them instantly”",
                  style: TextStyle(
                    fontSize: isTablet ? 30 : 19,
                    color: Color.fromARGB(221, 3, 0, 69),
                  ),
                ),

                SizedBox(height: isTablet ? 0 : 50),

                Center(
                  child: Image.asset("assets/icons/icon_scan.png", 
                  height: isTablet ? 800 : 400),
                ),
                SizedBox(height: isTablet ? 120 :150),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashThreeScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: isTablet ? 40 : 25,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 13, 2, 75),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
   
    );
      }
    );
  }
}
