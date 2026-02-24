import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/user_session_service.dart';

final appThemeModeProvider = NotifierProvider<AppThemeModeNotifier, ThemeMode>(
  AppThemeModeNotifier.new,
);

class AppThemeModeNotifier extends Notifier<ThemeMode> {
  static const String _themeModeKey = 'app_theme_mode';
  static const String _legacyThemeModeKey = 'app_theme_mode_dark';

  @override
  ThemeMode build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final storedMode = prefs.getString(_themeModeKey);
    if (storedMode != null) {
      return _themeModeFromStorage(storedMode);
    }

    final legacyDarkFlag = prefs.getBool(_legacyThemeModeKey);
    if (legacyDarkFlag != null) {
      return legacyDarkFlag ? ThemeMode.dark : ThemeMode.light;
    }

    return ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_themeModeKey, mode.name);
  }

  ThemeMode _themeModeFromStorage(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}
