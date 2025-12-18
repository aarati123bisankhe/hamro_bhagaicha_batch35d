import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/widget/tip_card.dart';

class TodayTips extends StatelessWidget {
  const TodayTips({super.key});

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
            colors: [
              Color(0xFFD8F3DC),
              Color(0xFF475E4F),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 90),

            // Header with arrow
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/icons/arrow icon.png",
                    height: 28,
                    width: 28,
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Hamro Bhagaicha 🌿',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Subtitle
            const Text(
              "Today Tips",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(221, 128, 56, 1),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                "All Tips",
                style: TextStyle(color: Colors.white),
              ),
            ),
           

            const SizedBox(height: 35),

            // Tips List
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  TipCard(
                    imageUrl: 'assets/images/tipimage1.png',
                    title: 'The best time to water your plants',
                    description:
                        'The best time to water your plants is early in the morning or late in the evening. During these hours, temperatures are cooler and water absorbs into the soil efficiently. ',
                    readTime: '3 min read',
                  ),
                  SizedBox(height: 16),
                  TipCard(
                    imageUrl: 'assets/images/tipimage2.png',
                    title: 'Nature Pest Remedies',
                    description:
                        'Keep your plants safe naturally with simple remedies. Use neem oil spray to repel insects and pests. Garlic or chili water can act as a natural insect deterrent. These remedies protect plants without harmful chemicals.',
                    readTime: '4 min read',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
