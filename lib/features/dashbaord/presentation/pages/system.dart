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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.palette_outlined,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Appearance',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Choose Light, Dark, or Auto based on your device.',
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(height: 14),
                    SegmentedButton<ThemeMode>(
                      showSelectedIcon: false,
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          const Size.fromHeight(44),
                        ),
                      ),
                      segments: const [
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.light,
                          icon: Icon(Icons.light_mode_outlined),
                          label: Text('Light'),
                        ),
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.dark,
                          icon: Icon(Icons.dark_mode_outlined),
                          label: Text('Dark'),
                        ),
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.system,
                          icon: Icon(Icons.brightness_auto_outlined),
                          label: Text('Auto'),
                        ),
                      ],
                      selected: {themeMode},
                      onSelectionChanged: (selection) {
                        ref
                            .read(appThemeModeProvider.notifier)
                            .setThemeMode(selection.first);
                      },
                    ),
                  ],
                ),
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
    final isDark = isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.82),
        border: Border.all(
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.06),
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }
}
