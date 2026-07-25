import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_track/core/constants/app_constants.dart';
import 'package:gym_track/core/di/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persisted [ThemeMode] notifier backed by [SharedPreferences].
class ThemeModeNotifier extends Notifier<ThemeMode> {
  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  ThemeMode build() {
    final stored = _prefs.getString(AppConstants.themeModeKey);
    return _fromStorage(stored);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _prefs.setString(AppConstants.themeModeKey, mode.name);
  }

  Future<void> toggleDarkLight() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(next);
  }

  static ThemeMode _fromStorage(String? value) {
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.system,
    };
  }
}

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);
