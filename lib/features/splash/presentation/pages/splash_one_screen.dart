import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_two_screen.dart';

class SplashOneScreen extends StatelessWidget {
  const SplashOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = constraints.maxWidth >= 600;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: isTablet ? 40 : 20),

        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashTwoScreen()),
            );
          },

          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(221, 2, 1, 25),
            padding:  EdgeInsets.symmetric(
              horizontal: isTablet ? 200 : 100, 
              vertical: isTablet ? 25 : 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),

          child: Text(
            'Get Started',
            style: TextStyle(
              fontSize: isTablet ? 30 : 18,
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
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 50 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isTablet ? 120 : 80),

                Text(
                  "Welcome to",
                  style: TextStyle(
                    fontSize: isTablet ? 40 : 26,
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
                        fontSize: isTablet ? 50 : 28,
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
                    fontSize: isTablet ? 28 : 15,
                    color: Color.fromARGB(221, 3, 0, 69),
                  ),
                ),

                SizedBox(height: 85),

                Center(
                  child: Image.asset("assets/icons/icon.png", 
                  height: isTablet ? 610 : 310),
                ),
              ],
            ),
          ),
        ),
      ),
    );
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';
// import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_two_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashOneScreen extends StatefulWidget {
//   const SplashOneScreen({super.key});

//   @override
//   State<SplashOneScreen> createState() => _SplashOneScreenState();
// }

// class _SplashOneScreenState extends State<SplashOneScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkOnboarding();
//   }

//   Future<void> _checkOnboarding() async {
//     final prefs = await SharedPreferences.getInstance();
//     final onboardingDone = prefs.getBool('onboarding_done') ?? false;

//     if (onboardingDone) {
//       // 🔑 Refresh / reopen → Dashboard
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const DashboardScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         bool isTablet = constraints.maxWidth >= 600;

//         return Scaffold(
//           floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//           floatingActionButton: Padding(
//             padding: EdgeInsets.only(bottom: isTablet ? 40 : 20),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const SplashTwoScreen(),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(221, 2, 1, 25),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: isTablet ? 200 : 100,
//                   vertical: isTablet ? 25 : 16,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//               ),
//               child: Text(
//                 'Get Started',
//                 style: TextStyle(
//                   fontSize: isTablet ? 30 : 18,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//           body: Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Color(0xFFD8F3DC), Color(0xFF475E4F)],
//               ),
//             ),
//             child: SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: isTablet ? 50 : 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: isTablet ? 120 : 80),
//                     Text(
//                       "Welcome to",
//                       style: TextStyle(
//                         fontSize: isTablet ? 40 : 26,
//                         fontWeight: FontWeight.w600,
//                         color: Color.fromARGB(221, 10, 40, 19),
//                       ),
//                     ),
//                     const SizedBox(height: 13),
//                     Row(
//                       children: [
//                         Text(
//                           "Hamro Bhagaicha 🌿",
//                           style: TextStyle(
//                             fontSize: isTablet ? 50 : 28,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 13),
//                     Text(
//                       "“A digital space where plant lovers grow, share, and learn together.”",
//                       style: TextStyle(
//                         fontSize: isTablet ? 28 : 15,
//                         color: Color.fromARGB(221, 3, 0, 69),
//                       ),
//                     ),
//                     SizedBox(height: 85),
//                     Center(
//                       child: Image.asset(
//                         "assets/icons/icon.png",
//                         height: isTablet ? 610 : 310,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }



