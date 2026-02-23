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
          color: const Color(0xFFE2E8DC),
          borderRadius: BorderRadius.circular(isTablet ? 20 : 15),
        ),
        padding: EdgeInsets.all(isTablet ? 16 : 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            SizedBox(height: isTablet ? 15 : 8),

            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isTablet ? 23 : 14,
              ),
            ),

            Text(
              description,
              maxLines: isTablet ? 3 : 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isTablet ? 16 : 12,
                color: Color.fromARGB(255, 94, 93, 93),
              ),
            ),

            SizedBox(height: isTablet ? 10 : 5),

            Text(
              'NRP $price',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isTablet ? 19 : 14,
                color: Color.fromARGB(255, 42, 119, 45),
              ),
            ),

            const SizedBox(height: 5),

            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: const Color.fromARGB(255, 60, 137, 62),
                  size: isTablet ? 20 : 15,
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 20 : 12,
                    vertical: isTablet ? 12 : 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: onAdd,
                child: Text(
                  '+ Add',
                  style: TextStyle(fontSize: isTablet ? 18 : 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
