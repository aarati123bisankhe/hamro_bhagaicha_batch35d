import 'package:flutter/material.dart';

class ComboSetCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final int price;
  final int rating;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  const ComboSetCard({
    super.key,
    required this.imagePath,
    required this.name,
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
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isTablet ? 30 : 16),
          side: BorderSide(color: Colors.green, width: isTablet ? 2 : 1),
        ),
        color: const Color(0xFFE2E8DC),
        margin: EdgeInsets.symmetric(vertical: isTablet ? 20 : 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Image on left
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: isTablet ? 250 : 150,
                  height: isTablet ? 250 : 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 41, 3, 181),
                        fontSize: isTablet ? 23 : 16,
                      ),
                    ),
                    SizedBox(height: isTablet ? 15 : 6),
                    Text(
                      'NRP $price',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 20 : 14,
                        color: const Color.fromARGB(255, 42, 119, 45),
                      ),
                    ),
                    SizedBox(height: isTablet ? 12 : 6),
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
                    SizedBox(height: isTablet ? 12 : 6),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 20 : 12,
                            vertical: isTablet ? 12 : 6,
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
            ],
          ),
        ),
      ),
    );
  }
}
