import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/login_screen.dart';

class SplashThreeScreen extends StatelessWidget {
  const SplashThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isTablet = constraints.maxWidth >= 600;

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
            child: Stack(
              children: [
                Positioned(
                  top: isTablet ? -100 : -70,
                  left: isTablet ? -60 : -45,
                  child: _blurOrb(
                    size: isTablet ? 240 : 170,
                    color: const Color(0x7795D5B2),
                  ),
                ),
                Positioned(
                  bottom: isTablet ? 80 : 65,
                  right: isTablet ? -70 : -50,
                  child: _blurOrb(
                    size: isTablet ? 260 : 180,
                    color: const Color(0x6692E6C2),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 44 : 20,
                      vertical: isTablet ? 24 : 14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isTablet ? 16 : 12,
                                vertical: isTablet ? 10 : 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.72),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.85),
                                ),
                              ),
                              child: Text(
                                'Step 3 of 3',
                                style: TextStyle(
                                  fontSize: isTablet ? 18 : 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F2A1E),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isTablet ? 34 : 22),
                        Text(
                          'Find Nearby\nNurseries',
                          style: TextStyle(
                            fontSize: isTablet ? 52 : 34,
                            height: 1.02,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0B2015),
                          ),
                        ),
                        SizedBox(height: isTablet ? 12 : 8),
                        Text(
                          'Discover trusted plant shops around you and start building your perfect garden.',
                          style: TextStyle(
                            fontSize: isTablet ? 21 : 15,
                            height: 1.35,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1B2F24),
                          ),
                        ),
                        SizedBox(height: isTablet ? 28 : 18),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(isTablet ? 16 : 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.72),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.92),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF244935,
                                ).withValues(alpha: 0.2),
                                blurRadius: 22,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/map.png',
                                height: isTablet ? 360 : 220,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: isTablet ? 14 : 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xFF114232),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Turn on location to see nearby nurseries and offers.',
                                      style: TextStyle(
                                        fontSize: isTablet ? 16 : 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF184A34),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            _dot(active: false),
                            const SizedBox(width: 6),
                            _dot(active: false),
                            const SizedBox(width: 6),
                            _dot(active: true),
                            const Spacer(),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0C2D1E),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 30 : 22,
                                  vertical: isTablet ? 16 : 13,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              icon: const Icon(Icons.login_rounded),
                              label: Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: isTablet ? 22 : 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _blurOrb({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  static Widget _dot({required bool active}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: active ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF0C2D1E) : const Color(0xFF9FB8A9),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
