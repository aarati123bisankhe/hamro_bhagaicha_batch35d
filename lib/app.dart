import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/splash_one_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashOneScreen(),
    );
  }
}
