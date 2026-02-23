import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

BoxDecoration appBackgroundDecoration(BuildContext context) {
  if (isDarkMode(context)) {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF1F2937), Color(0xFF111827)],
      ),
    );
  }

  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFD8F3DC), Color(0xFF475E4F)],
    ),
  );
}
