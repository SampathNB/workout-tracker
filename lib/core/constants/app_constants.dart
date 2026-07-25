/// Application-wide constants for GymTrack.
abstract final class AppConstants {
  static const String appName = 'GymTrack';
  static const String appVersion = '1.0.0';

  /// Hive box names.
  static const String settingsBox = 'settings';
  static const String workoutsBox = 'workouts';
  static const String exercisesBox = 'exercises';

  /// SharedPreferences keys.
  static const String themeModeKey = 'theme_mode';
  static const String onboardingCompleteKey = 'onboarding_complete';

  /// Splash display duration before navigating to the shell.
  static const Duration splashDuration = Duration(milliseconds: 1500);
}
