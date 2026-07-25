import 'package:flutter/material.dart';
import 'package:gym_track/app/theme/theme_mode_provider.dart';
import 'package:gym_track/core/constants/app_constants.dart';
import 'package:gym_track/core/widgets/responsive_layout.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// App settings placeholder with working theme controls.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ResponsiveContent(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            Text(
              'Appearance',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('System'),
                  icon: Icon(Icons.brightness_auto_rounded),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode_rounded),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode_rounded),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (selection) {
                ref.read(themeModeProvider.notifier).setThemeMode(selection.first);
              },
            ),
            const SizedBox(height: 32),
            Text(
              'About',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.info_outline_rounded, color: colorScheme.primary),
              title: const Text(AppConstants.appName),
              subtitle: const Text('Version ${AppConstants.appVersion}'),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.architecture_rounded,
                color: colorScheme.primary,
              ),
              title: const Text('Architecture'),
              subtitle: const Text(
                'Clean Architecture · Feature-first · Riverpod DI',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
