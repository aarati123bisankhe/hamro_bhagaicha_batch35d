
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hamro_bhagaicha_batch35d/app/app.dart';
// import 'package:hamro_bhagaicha_batch35d/core/services/hive/hive_service.dart';
// import 'package:hamro_bhagaicha_batch35d/core/services/storage/user_session_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Hive
//   final hiveService = HiveService();
//   await hiveService.init();

//   // Initialize SharedPreferences
//   final prefs = await SharedPreferences.getInstance();

//   // Create ProviderContainer with overrides
//   final container = ProviderContainer(
//     overrides: [
//       hiveServiceProvider.overrideWithValue(hiveService),
//       sharedPreferencesProvider.overrideWithValue(prefs),
//     ],
//   );

//   runApp(
//     UncontrolledProviderScope(
//       container: container,
//       child: const MyApp(),
//     ),
//   );
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/app/app.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/hive/hive_service.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/user_session_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final hiveService = HiveService();
  await hiveService.init();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Create ProviderContainer with overrides
  final container = ProviderContainer(
    overrides: [
      hiveServiceProvider.overrideWithValue(hiveService),
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
