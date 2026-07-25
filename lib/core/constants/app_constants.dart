/// Application-wide constants for GymTrack.
abstract final class AppConstants {
  static const String appName = 'GymTrack';
  static const String appVersion = '1.0.0';

  /// Hive box names. One box per persisted aggregate.
  static const String settingsBox = 'settings';
  static const String exercisesBox = 'exercises';
  static const String workoutSessionsBox = 'workout_sessions';
  static const String workoutPlansBox = 'workout_plans';
  static const String weightEntriesBox = 'weight_entries';
  static const String progressPhotosBox = 'progress_photos';
  static const String goalsBox = 'goals';

  /// Key of the single [AppSettings] record inside [settingsBox].
  static const String settingsKey = 'app_settings';

  /// SharedPreferences keys.
  static const String themeModeKey = 'theme_mode';
  static const String onboardingCompleteKey = 'onboarding_complete';

  /// Splash display duration before navigating to the shell.
  static const Duration splashDuration = Duration(milliseconds: 1500);
}
