// import 'package:flutter/material.dart';
// import 'package:hamro_bhagaicha_batch35d/app/app.dart';

// void main() {
//   runApp(const MyApp());
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/app/app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
