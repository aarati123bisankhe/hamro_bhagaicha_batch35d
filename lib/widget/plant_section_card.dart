import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String description;
  final int price;
  final int rating;
  final VoidCallback? onTap; 
  const PlantCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(8),
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

            const SizedBox(height: 8),
            
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 115, 115, 115),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'NRP $price',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
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
                  size: 15,
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                },
                child: const Text('+ Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

