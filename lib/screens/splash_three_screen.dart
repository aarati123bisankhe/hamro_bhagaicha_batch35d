import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/login_screen.dart';

class SplashThreeScreen extends StatelessWidget {
  const SplashThreeScreen({super.key});

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
            colors: [Color(0xFFD8F3DC), Color(0xFF475E4F)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),

                Row(
                  children: [
                    Text(
                      "Find Nearby Nurseries",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                Text(
                  "“Locate the nearest plant nurseries instantly!”",
                  style: TextStyle(
                    fontSize: 19,
                    color: Color.fromARGB(221, 3, 0, 69),
                  ),
                ),

                SizedBox(height: 60),

                Center(
                  child: Image.asset("assets/images/map.png", height: 340),
                ),
                SizedBox(height: 90),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 20,
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
}
