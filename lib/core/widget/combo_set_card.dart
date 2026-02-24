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
      child: Container(
        margin: EdgeInsets.only(bottom: isTablet ? 18 : 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF4FBF0), Color(0xFFE3F1DC)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF244935).withValues(alpha: 0.14),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: const Color(0xFFB8D7B9), width: 1.1),
        ),
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 14 : 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  imagePath,
                  width: isTablet ? 200 : 120,
                  height: isTablet ? 200 : 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: isTablet ? 16 : 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Plant + Pot Combo',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: isTablet ? 14 : 11,
                          color: const Color(0xFF1B5E20),
                        ),
                      ),
                    ),
                    SizedBox(height: isTablet ? 10 : 8),
                    Text(
                      name,
                      maxLines: isTablet ? 3 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0E2B18),
                        fontSize: isTablet ? 22 : 15,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: isTablet ? 10 : 8),
                    Row(
                      children: [
                        Text(
                          'NRP $price',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: isTablet ? 20 : 15,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                index < rating ? Icons.star : Icons.star_border,
                                color: const Color(0xFF578F2C),
                                size: isTablet ? 20 : 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isTablet ? 14 : 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E20),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 14 : 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: onAdd,
                        icon: const Icon(Icons.add_shopping_cart_rounded),
                        label: Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: isTablet ? 17 : 13,
                            fontWeight: FontWeight.w700,
                          ),
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
