import 'package:flutter/material.dart';

ThemeData getApplicationTheme({bool isTablet = false}) {
  return ThemeData(
    // fontFamily: 'OpenSans Regular',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color.fromARGB(255, 219, 225, 212),
      selectedItemColor: Colors.black,
      unselectedItemColor: const Color.fromARGB(255, 10, 59, 20),
      selectedLabelStyle: TextStyle(
        fontFamily: "OpenSans Bold",
        fontSize: isTablet ? 20 : 14,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: isTablet ? 20 : 14,
      ),
      selectedIconTheme: IconThemeData(size: isTablet ? 65 : 35),
      unselectedIconTheme: IconThemeData(size: isTablet ? 60 : 30),
    ),
  );
}

ThemeData getDarkApplicationTheme({bool isTablet = false}) {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF121212),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1B1B1B),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.green.shade200,
      selectedLabelStyle: TextStyle(
        fontFamily: "OpenSans Bold",
        fontSize: isTablet ? 20 : 14,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: isTablet ? 20 : 14,
      ),
      selectedIconTheme: IconThemeData(size: isTablet ? 65 : 35),
      unselectedIconTheme: IconThemeData(size: isTablet ? 60 : 30),
    ),
  );
}
