import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String description;
  final int price;
  final int rating;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  const PlantCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    this.onTap,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
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
        padding: EdgeInsets.all(isTablet ? 14 : 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'Plant',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: isTablet ? 13 : 10,
                  color: const Color(0xFF1B5E20),
                ),
              ),
            ),
            SizedBox(height: isTablet ? 10 : 8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: isTablet ? 10 : 8),
            Text(
              name,
              maxLines: isTablet ? 2 : 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: isTablet ? 18 : 13,
                color: const Color(0xFF0E2B18),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isTablet ? 14 : 11,
                color: const Color(0xFF486457),
              ),
            ),
            SizedBox(height: isTablet ? 8 : 6),
            Row(
              children: [
                Text(
                  'NRP $price',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: isTablet ? 17 : 13,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
                const Spacer(),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: const Color(0xFF578F2C),
                      size: isTablet ? 17 : 13,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isTablet ? 10 : 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E20),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: isTablet ? 12 : 9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: onAdd,
                icon: const Icon(Icons.add_shopping_cart_rounded, size: 18),
                label: Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: isTablet ? 14 : 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
