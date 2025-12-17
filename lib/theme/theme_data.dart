import 'package:flutter/material.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
    // fontFamily: 'OpenSans Regular',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color.fromARGB(255, 236, 252, 233),
      selectedItemColor: Colors.black,
      unselectedItemColor: const Color.fromARGB(255, 10, 59, 20),
      selectedLabelStyle: TextStyle(fontFamily: "OpenSans Bold"),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      selectedIconTheme: IconThemeData(size: 30)
    ),

  );
}