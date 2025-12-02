import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/screens/changed_password_screen.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangedPasswordScreen(),
    );
  }
}
