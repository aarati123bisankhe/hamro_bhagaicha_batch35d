// import 'package:flutter/material.dart';
// import 'package:hamro_bhagaicha_batch35d/app/app.dart';

// void main() {
//   runApp(const MyApp());
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hamro_bhagaicha_batch35d/app/app.dart';


// void main() {
  
//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/app/app.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/hive/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  await container.read(hiveServiceProvider).init();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

