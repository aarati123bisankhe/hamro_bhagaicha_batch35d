import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/deeplink/deep_link_service.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/pages/changed_password_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:hamro_bhagaicha_batch35d/app/theme/theme_mode_provider.dart';
import 'package:hamro_bhagaicha_batch35d/app/theme/theme_data.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(deepLinkServiceProvider).startListening(_handleDeepLink);
    });
  }

  void _handleDeepLink(Uri uri) {
    final token = ref.read(deepLinkServiceProvider).getResetToken(uri);
    if (token == null || token.isEmpty) {
      return;
    }

    final navigator = _navigatorKey.currentState;
    if (navigator == null) {
      return;
    }

    navigator.push(
      MaterialPageRoute(builder: (_) => ChangedPasswordScreen(token: token)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(appThemeModeProvider);
    final appliedThemeMode = themeMode == ThemeMode.system
        ? ThemeMode.light
        : themeMode;

    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "Hamro Bhagaicha",
      theme: getApplicationTheme(),
      darkTheme: getDarkApplicationTheme(),
      themeMode: appliedThemeMode,
      home: const SplashScreen(),
    );
  }
}
