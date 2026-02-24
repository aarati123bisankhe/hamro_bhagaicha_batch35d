import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/features/splash/presentation/pages/splash_three_screen.dart';

class SplashTwoScreen extends StatelessWidget {
  const SplashTwoScreen({super.key});

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
                  top: isTablet ? -110 : -70,
                  right: isTablet ? -80 : -60,
                  child: _blurOrb(
                    size: isTablet ? 280 : 190,
                    color: const Color(0x8895D5B2),
                  ),
                ),
                Positioned(
                  bottom: isTablet ? 90 : 70,
                  left: isTablet ? -70 : -45,
                  child: _blurOrb(
                    size: isTablet ? 220 : 150,
                    color: const Color(0x66B7EFCB),
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
                                'Step 2 of 3',
                                style: TextStyle(
                                  fontSize: isTablet ? 18 : 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F2A1E),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isTablet ? 36 : 24),
                        Text(
                          'Scan With Confidence',
                          style: TextStyle(
                            fontSize: isTablet ? 52 : 34,
                            fontWeight: FontWeight.w800,
                            height: 1.02,
                            color: const Color(0xFF0B2015),
                          ),
                        ),
                        SizedBox(height: isTablet ? 12 : 8),
                        Text(
                          'Instantly identify plants and get care insights in one tap.',
                          style: TextStyle(
                            fontSize: isTablet ? 22 : 15,
                            height: 1.35,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1B2F24),
                          ),
                        ),
                        SizedBox(height: isTablet ? 32 : 20),
                        Container(
                          padding: EdgeInsets.all(isTablet ? 16 : 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.7),
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
                              Center(
                                child: Image.asset(
                                  'assets/icons/icon_scan.png',
                                  height: isTablet ? 460 : 260,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: isTablet ? 16 : 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.tips_and_updates_outlined,
                                    color: Color(0xFF114232),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Tip: capture leaves in natural light for better accuracy.',
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
                            _dot(active: true),
                            const SizedBox(width: 6),
                            _dot(active: false),
                            const Spacer(),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SplashThreeScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0C2D1E),
                                foregroundColor: Colors.white,
                                elevation: 2,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 34 : 24,
                                  vertical: isTablet ? 17 : 13,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              icon: const Icon(Icons.arrow_forward_rounded),
                              label: Text(
                                'Next',
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
