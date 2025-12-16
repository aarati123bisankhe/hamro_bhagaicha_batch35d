import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.errorText,
    this.keyboardType,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override

  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
       style: TextStyle(
        fontSize: isTablet ? 18 : 15,
      ),
      validator: (value) {
       
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: isTablet ? 18 : 15,
        ),
        filled: true,
        fillColor: const Color(0xFFD8E4D2), // light green like screenshot
        contentPadding:  EdgeInsets.symmetric(
          vertical: isTablet ? 25 : 14,
          horizontal: isTablet ? 25: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 1, 75, 31),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
