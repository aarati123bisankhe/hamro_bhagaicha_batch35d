import 'package:flutter/material.dart';

class TipCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String readTime;

  const TipCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.readTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFE2E8DC),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageUrl,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16,
                        color: Color.fromARGB(255, 32, 66, 93)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    readTime,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 138, 136, 136),
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
