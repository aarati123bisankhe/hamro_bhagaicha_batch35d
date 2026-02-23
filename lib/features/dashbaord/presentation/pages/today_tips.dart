import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          'The best time to water your plants is early in the morning or late in the evening. During these hours, temperatures are cooler and water absorbs into the soil efficiently. ',
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
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: isTablet ? 100 : 90),

            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/icons/arrow icon.png",
                    height: isTablet ? 40 : 28,
                    width: isTablet ? 40 : 28,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Hamro Bhagaicha 🌿',
                      style: TextStyle(
                        fontSize: isTablet ? 34 : 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: isTablet ? 80 : 40),
            Text(
              "Today Tips",
              style: TextStyle(
                fontSize: isTablet ? 28 : 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(221, 128, 56, 1),
              ),
            ),
            SizedBox(height: isTablet ? 40 : 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(isTablet ? 40 : 20),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 40 : 20,
                  vertical: isTablet ? 11 : 10,
                ),
              ),
              child: Text(
                "All Tips",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 21 : 14,
                ),
              ),
            ),

            const SizedBox(height: 35),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  for (var i = 0; i < _tips.length; i++) ...[
                    TipCard(
                      imageUrl: _tips[i].imageUrl,
                      title: _tips[i].title,
                      description: _tips[i].description,
                      readTime: _tips[i].readTime,
                      isSaved: savedTips.any((tip) => tip.id == _tips[i].id),
                      onToggleSave: () {
                        ref
                            .read(savedTipViewModelProvider.notifier)
                            .toggleTip(_tips[i]);
                      },
                    ),
                    if (i != _tips.length - 1) const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
