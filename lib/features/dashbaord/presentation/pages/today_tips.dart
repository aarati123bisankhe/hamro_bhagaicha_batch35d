import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/tip_card.dart';

class TodayTips extends StatelessWidget {
  const TodayTips({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600; 
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
        padding:  EdgeInsets.symmetric(horizontal: isTablet ? 32 :  16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: isTablet ? 100 :  90),

          
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
                        fontSize:  isTablet ? 34 : 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: isTablet ? 80 :  40),
             Text(
              "Today Tips",
              style: TextStyle(
                fontSize: isTablet ? 28 : 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(221, 128, 56, 1),
              ),
            ),
            SizedBox(height: isTablet ? 40 :  20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(isTablet ? 40 :20),
                ),
                padding:
                     EdgeInsets.symmetric(horizontal: isTablet ? 40 : 20, 
                     vertical: isTablet ? 11 :  10),
              ),
              child:  Text(
                "All Tips",
                
                style: TextStyle(color: Colors.white, fontSize: isTablet ? 21 :14),
              ),
            ),
           

            const SizedBox(height: 35),
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
