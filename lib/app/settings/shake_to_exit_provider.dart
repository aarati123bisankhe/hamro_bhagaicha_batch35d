import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/user_session_service.dart';

final shakeToExitEnabledProvider = NotifierProvider<ShakeToExitNotifier, bool>(
  ShakeToExitNotifier.new,
);

class ShakeToExitNotifier extends Notifier<bool> {
  static const String _shakeToExitKey = 'dashboard_shake_to_exit_enabled';

  @override
  bool build() {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getBool(_shakeToExitKey) ?? true;
  }

  Future<void> setEnabled(bool enabled) async {
    state = enabled;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_shakeToExitKey, enabled);
  }
}
