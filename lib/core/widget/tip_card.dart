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

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
      ),
      color: const Color(0xFFE2E8DC),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 16 : 8),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imageUrl,
                    width: isTablet ? 250 : 150,
                    height: isTablet ? 250 : 150,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: isTablet ? 12 : 8,
                  right: isTablet ? 12 : 8,
                  child: GestureDetector(
                    onTap: onToggleSave,
                    child: Container(
                      padding: EdgeInsets.all(isTablet ? 10 : 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.green,
                        size: isTablet ? 30 : 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(width: isTablet ? 22 : 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isTablet ? 26 : 16,
                      color: const Color.fromARGB(255, 32, 66, 93),
                    ),
                  ),
                  SizedBox(height: isTablet ? 15 : 6),
                  Text(
                    description,
                    maxLines: isTablet ? 8 : 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isTablet ? 24 : 14,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: isTablet ? 12 : 8),
                  Text(
                    readTime,
                    style: TextStyle(
                      fontSize: isTablet ? 20 : 12,
                      color: const Color.fromARGB(255, 138, 136, 136),
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
