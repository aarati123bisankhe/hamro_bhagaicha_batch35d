import 'package:flutter/material.dart';

class HomeButtonCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Color subtitleColor;
  final VoidCallback? onTap;

  const HomeButtonCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.subtitleColor = Colors.black87,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(isTablet ? 29 : 10),
        decoration: BoxDecoration(
          color: const Color(0xFFE3EED9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(icon, style: TextStyle(fontSize: isTablet ? 60 : 30)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isTablet ? 31 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: isTablet ? 25 : 14,
                      color: subtitleColor,
                    ),
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
