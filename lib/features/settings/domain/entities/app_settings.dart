import 'package:gym_track/features/settings/domain/entities/settings_enums.dart';

/// Single-record user preferences and profile.
///
/// Stored in the `settings` box under `AppConstants.settingsKey`.
class AppSettings {
  const AppSettings({
    this.unitSystem = UnitSystem.metric,
    this.themePreference = ThemePreference.system,
    this.accentColorHex,
    this.firstDayOfWeek = 1,
    this.restTimerSeconds = 90,
    this.autoStartRestTimer = true,
    this.restTimerSoundEnabled = true,
    this.hapticsEnabled = true,
    this.notificationsEnabled = true,
    this.keepScreenOnDuringWorkout = true,
    this.weeklyWorkoutGoal = 4,
    this.displayName,
    this.heightCm,
    this.birthDate,
    this.sex = BiologicalSex.unspecified,
    this.onboardingComplete = false,
    this.lastBackupAt,
    this.updatedAt,
  });

  final UnitSystem unitSystem;
  final ThemePreference themePreference;

  /// Optional accent override as `RRGGBB` or `AARRGGBB`.
  final String? accentColorHex;

  /// ISO weekday the calendar week starts on (1 = Monday … 7 = Sunday).
  final int firstDayOfWeek;
  final int restTimerSeconds;
  final bool autoStartRestTimer;
  final bool restTimerSoundEnabled;
  final bool hapticsEnabled;
  final bool notificationsEnabled;
  final bool keepScreenOnDuringWorkout;

  /// Target number of sessions per week.
  final int weeklyWorkoutGoal;
  final String? displayName;
  final double? heightCm;
  final DateTime? birthDate;
  final BiologicalSex sex;
  final bool onboardingComplete;
  final DateTime? lastBackupAt;
  final DateTime? updatedAt;

  AppSettings copyWith({
    UnitSystem? unitSystem,
    ThemePreference? themePreference,
    String? accentColorHex,
    int? firstDayOfWeek,
    int? restTimerSeconds,
    bool? autoStartRestTimer,
    bool? restTimerSoundEnabled,
    bool? hapticsEnabled,
    bool? notificationsEnabled,
    bool? keepScreenOnDuringWorkout,
    int? weeklyWorkoutGoal,
    String? displayName,
    double? heightCm,
    DateTime? birthDate,
    BiologicalSex? sex,
    bool? onboardingComplete,
    DateTime? lastBackupAt,
    DateTime? updatedAt,
  }) {
    return AppSettings(
      unitSystem: unitSystem ?? this.unitSystem,
      themePreference: themePreference ?? this.themePreference,
      accentColorHex: accentColorHex ?? this.accentColorHex,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
      restTimerSeconds: restTimerSeconds ?? this.restTimerSeconds,
      autoStartRestTimer: autoStartRestTimer ?? this.autoStartRestTimer,
      restTimerSoundEnabled:
          restTimerSoundEnabled ?? this.restTimerSoundEnabled,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      keepScreenOnDuringWorkout:
          keepScreenOnDuringWorkout ?? this.keepScreenOnDuringWorkout,
      weeklyWorkoutGoal: weeklyWorkoutGoal ?? this.weeklyWorkoutGoal,
      displayName: displayName ?? this.displayName,
      heightCm: heightCm ?? this.heightCm,
      birthDate: birthDate ?? this.birthDate,
      sex: sex ?? this.sex,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      lastBackupAt: lastBackupAt ?? this.lastBackupAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

extension AppSettingsX on AppSettings {
  bool get usesMetric => unitSystem == UnitSystem.metric;

  String get weightUnitLabel => usesMetric ? 'kg' : 'lb';

  String get distanceUnitLabel => usesMetric ? 'km' : 'mi';

  Duration get restTimerDuration => Duration(seconds: restTimerSeconds);

  int? get age {
    final birth = birthDate;
    if (birth == null) return null;
    final now = DateTime.now();
    var years = now.year - birth.year;
    final hadBirthday =
        now.month > birth.month ||
        (now.month == birth.month && now.day >= birth.day);
    if (!hadBirthday) years -= 1;
    return years < 0 ? null : years;
  }
}
