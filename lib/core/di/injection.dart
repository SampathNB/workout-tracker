import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_track/core/constants/app_constants.dart';
import 'package:gym_track/core/storage/hive_storage.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Holds async dependencies that must be resolved before the widget tree runs.
///
/// Construct via [DependencyInjection.init] and override providers in
/// [ProviderScope] so feature modules can inject these without globals.
final class AppDependencies {
  const AppDependencies({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;
}

/// Bootstraps infrastructure (Hive, SharedPreferences) for dependency injection.
abstract final class DependencyInjection {
  static Future<AppDependencies> init() async {
    await HiveStorage.init();
    final sharedPreferences = await SharedPreferences.getInstance();
    return AppDependencies(sharedPreferences: sharedPreferences);
  }
}

/// Provides [SharedPreferences] after bootstrap override.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in ProviderScope',
  );
});

/// Provides the Hive settings box.
final settingsBoxProvider = Provider<Box<dynamic>>((ref) {
  return HiveStorage.settingsBox;
});

/// Provides the Hive workouts box.
final workoutsBoxProvider = Provider<Box<dynamic>>((ref) {
  return HiveStorage.workoutsBox;
});

/// Provides the Hive exercises box.
final exercisesBoxProvider = Provider<Box<dynamic>>((ref) {
  return HiveStorage.exercisesBox;
});

/// Convenience: typed access to a named Hive box (for future feature use).
final hiveBoxProvider = Provider.family<Box<dynamic>, String>((ref, name) {
  return Hive.box<dynamic>(name);
});

/// Re-export box name constants for DI consumers.
abstract final class DiBoxes {
  static const String settings = AppConstants.settingsBox;
  static const String workouts = AppConstants.workoutsBox;
  static const String exercises = AppConstants.exercisesBox;
}
