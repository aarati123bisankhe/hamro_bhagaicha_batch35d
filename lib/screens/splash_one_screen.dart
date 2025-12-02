import 'package:flutter/material.dart';

class SplashOneScreen extends StatelessWidget {
  const SplashOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(221, 2, 1, 25),
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: const Text(
            'Get Started',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),

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
                SizedBox(height: 90),

                Text(
                  "Welcome to",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(221, 10, 40, 19),
                  ),
                ),
                const SizedBox(height: 13),

                Row(
                  children: [
                    Text(
                      "Hamro Bhagaicha 🌿",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 13),

                Text(
                  "“A digital space where plant lovers grow, share, and learn together.”",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(221, 3, 0, 69),
                  ),
                ),

                SizedBox(height: 40),

                Center(
                  child: Image.asset("assets/icons/icon.png", height: 310),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
