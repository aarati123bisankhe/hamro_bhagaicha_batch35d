import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/tip_card.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/saved_tip_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/saved_tip_view_model.dart';

class TodayTips extends ConsumerWidget {
  const TodayTips({super.key});

  static const List<SavedTip> _tips = [
    SavedTip(
      id: 'tip-water-time',
      imageUrl: 'assets/images/tipimage1.png',
      title: 'The best time to water your plants',
      description:
          'The best time to water your plants is early in the morning or late in the evening. During these hours, temperatures are cooler and water absorbs into the soil efficiently.',
      readTime: '3 min read',
    ),
    SavedTip(
      id: 'tip-natural-pest-remedies',
      imageUrl: 'assets/images/tipimage2.png',
      title: 'Nature Pest Remedies',
      description:
          'Keep your plants safe naturally with simple remedies. Use neem oil spray to repel insects and pests. Garlic or chili water can act as a natural insect deterrent. These remedies protect plants without harmful chemicals.',
      readTime: '4 min read',
    ),
    SavedTip(
      id: 'tip-sunlight-balance',
      imageUrl: 'assets/images/tipimage4.png',
      title: 'Right Amount of Sunlight',
      description:
          'Different plants require different sunlight levels. Place sun-loving plants near windows or outdoors, while shade plants thrive in indirect light. Rotate plants regularly for even growth.',
      readTime: '4 min read',
    ),
    SavedTip(
      id: 'tip-soil-health',
      imageUrl: 'assets/images/tipimage5.png',
      title: 'Healthy Soil Matters',
      description:
          'Good soil provides nutrients and proper drainage. Mix compost or organic matter into soil to improve fertility. Healthy soil helps roots grow stronger and plants stay vibrant.',
      readTime: '5 min read',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final savedTips = ref.watch(savedTipViewModelProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: appBackgroundDecoration(context),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 28 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isTablet ? 14 : 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          'assets/icons/arrow icon.png',
                          height: isTablet ? 26 : 22,
                          width: isTablet ? 26 : 22,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Today Tips',
                      style: TextStyle(
                        fontSize: isTablet ? 34 : 24,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0A2515),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: isTablet ? 42 : 38),
                  ],
                ),
                SizedBox(height: isTablet ? 18 : 12),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isTablet ? 18 : 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white.withValues(alpha: 0.74),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.94),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF244935).withValues(alpha: 0.15),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Smart Daily Plant Tips',
                        style: TextStyle(
                          fontSize: isTablet ? 28 : 20,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0D2F1B),
                        ),
                      ),
                      SizedBox(height: isTablet ? 8 : 6),
                      Text(
                        'Practical guidance to keep your plants healthy, green, and thriving every day.',
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 13,
                          height: 1.35,
                          color: const Color(0xFF325442),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: isTablet ? 12 : 10),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1B5E20),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              'All Tips',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: isTablet ? 14 : 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: const Color(0xFF1B5E20),
                              ),
                            ),
                            child: Text(
                              '${savedTips.length} Saved',
                              style: TextStyle(
                                color: const Color(0xFF1B5E20),
                                fontWeight: FontWeight.w700,
                                fontSize: isTablet ? 14 : 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 14 : 10),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(bottom: isTablet ? 20 : 12),
                    itemCount: _tips.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final tip = _tips[index];
                      return TipCard(
                        imageUrl: tip.imageUrl,
                        title: tip.title,
                        description: tip.description,
                        readTime: tip.readTime,
                        isSaved: savedTips.any((saved) => saved.id == tip.id),
                        onToggleSave: () {
                          ref
                              .read(savedTipViewModelProvider.notifier)
                              .toggleTip(tip);
                        },
                      );
                    },
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
