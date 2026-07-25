import 'package:flutter/material.dart';
import 'package:gym_track/app/router/app_router.dart';
import 'package:gym_track/app/theme/app_theme.dart';
import 'package:gym_track/app/theme/theme_mode_provider.dart';
import 'package:gym_track/core/constants/app_constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Root MaterialApp wired to Riverpod, GoRouter, and Material 3 themes.
class GymTrackApp extends ConsumerWidget {
  const GymTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
