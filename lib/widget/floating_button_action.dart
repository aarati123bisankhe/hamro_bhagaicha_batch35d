import 'package:flutter/material.dart';

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = const Color(0xFF050925),
    this.borderRadius = 8, // Optional border radius
  });

  final VoidCallback onPressed;
  final String text;
  final Color color;
  final double borderRadius; // Optional parameter

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding:  EdgeInsets.symmetric(
            horizontal: isTablet ? 40 : 20, 
            vertical: isTablet ? 20 : 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isTablet ? borderRadius + 4 :borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, 
          fontSize: isTablet ? 24 : 20),
        ),
      ),
    );
  }
}
