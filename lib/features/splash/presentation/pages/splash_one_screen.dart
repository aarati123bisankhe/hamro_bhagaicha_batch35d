import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_two_screen.dart';

class SplashOneScreen extends StatelessWidget {
  const SplashOneScreen({super.key});

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
                  top: isTablet ? -120 : -80,
                  right: isTablet ? -80 : -55,
                  child: _blurOrb(
                    size: isTablet ? 270 : 180,
                    color: const Color(0x7795D5B2),
                  ),
                ),
                Positioned(
                  bottom: isTablet ? 70 : 55,
                  left: isTablet ? -75 : -45,
                  child: _blurOrb(
                    size: isTablet ? 240 : 155,
                    color: const Color(0x668FE8BC),
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
                                'Step 1 of 3',
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
                          'Welcome to\nHamro Bhagaicha',
                          style: TextStyle(
                            fontSize: isTablet ? 52 : 34,
                            height: 1.02, 
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0B2015),
                          ),
                        ),
                        SizedBox(height: isTablet ? 12 : 8),
                        Text(
                          'A digital space where plant lovers grow, share, and learn together.',
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
                                'assets/icons/icon.png',
                                height: isTablet ? 360 : 220,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: isTablet ? 14 : 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.eco_outlined,
                                    color: Color(0xFF114232),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Track plants, discover tips, and build your home garden confidently.',
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
                            _dot(active: true),
                            const SizedBox(width: 6),
                            _dot(active: false),
                            const SizedBox(width: 6),
                            _dot(active: false),
                            const Spacer(),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SplashTwoScreen(),
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
                              icon: const Icon(Icons.arrow_forward_rounded),
                              label: Text(
                                'Start',
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
