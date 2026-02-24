import 'package:flutter/material.dart';

class TipCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String readTime;
  final bool isSaved;
  final VoidCallback onToggleSave;

  const TipCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.readTime,
    required this.isSaved,
    required this.onToggleSave,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF4FBF0), Color(0xFFE3F1DC)],
        ),
        border: Border.all(color: const Color(0xFFB8D7B9), width: 1.1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF244935).withValues(alpha: 0.14),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 14 : 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imageUrl,
                    width: isTablet ? 165 : 110,
                    height: isTablet ? 165 : 110,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: isTablet ? 8 : 6,
                  right: isTablet ? 8 : 6,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: onToggleSave,
                      child: Container(
                        padding: EdgeInsets.all(isTablet ? 8 : 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: const Color(0xFF1B5E20),
                          size: isTablet ? 22 : 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: isTablet ? 16 : 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'Garden Tip',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: isTablet ? 12 : 10,
                        color: const Color(0xFF1B5E20),
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 8 : 6),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: isTablet ? 20 : 14,
                      color: const Color(0xFF0D2F1B),
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: isTablet ? 8 : 6),
                  Text(
                    description,
                    maxLines: isTablet ? 4 : 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isTablet ? 14 : 11,
                      color: const Color(0xFF3D5C4C),
                      height: 1.35,
                    ),
                  ),
                  SizedBox(height: isTablet ? 10 : 8),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: isTablet ? 16 : 13,
                        color: const Color(0xFF5A7A68),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        readTime,
                        style: TextStyle(
                          fontSize: isTablet ? 12 : 10,
                          color: const Color(0xFF5A7A68),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
