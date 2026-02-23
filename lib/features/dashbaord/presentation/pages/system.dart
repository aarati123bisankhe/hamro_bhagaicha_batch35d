import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/app/theme/theme_mode_provider.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';

class SystemPage extends ConsumerStatefulWidget {
  const SystemPage({super.key});

  @override
  ConsumerState<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends ConsumerState<SystemPage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(appThemeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('System Settings'),
        backgroundColor: isDarkMode(context)
            ? const Color(0xFF1F2937)
            : const Color(0xFFD8F3DC),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: appBackgroundDecoration(context),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _settingCard(
              child: SwitchListTile(
                value: isDark,
                title: const Text('Dark Mode'),
                subtitle: const Text('Turn app theme dark/light'),
                secondary: const Icon(Icons.dark_mode_outlined),
                onChanged: (value) {
                  ref.read(appThemeModeProvider.notifier).setDarkMode(value);
                },
              ),
            ),
            const SizedBox(height: 12),
            _settingCard(
              child: SwitchListTile(
                value: _notificationsEnabled,
                title: const Text('Notifications'),
                subtitle: const Text('Receive updates and reminders'),
                secondary: const Icon(Icons.notifications_active_outlined),
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            _settingCard(
              child: ListTile(
                leading: const Icon(Icons.language_outlined),
                title: const Text('Language'),
                subtitle: const Text('English'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Language options can be added'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            _settingCard(
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About App'),
                subtitle: const Text('Hamro Bhagaicha v1.0.0'),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Hamro Bhagaicha',
                    applicationVersion: '1.0.0',
                    applicationLegalese: 'Made for gardening community users',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }
}
