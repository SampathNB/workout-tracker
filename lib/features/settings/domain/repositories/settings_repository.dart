import 'package:gym_track/features/settings/domain/entities/app_settings.dart';

/// Persistence contract for the single user-settings record.
///
/// Unlike the other repositories this is not a CRUD collection: exactly one
/// [AppSettings] record exists, created lazily with defaults.
abstract interface class SettingsRepository {
  /// Current settings, persisting defaults on first run.
  Future<AppSettings> get();

  /// Cached settings without touching storage defaults, or null when unset.
  AppSettings? peek();

  /// Replaces the settings record.
  Future<AppSettings> save(AppSettings settings);

  /// Reads, transforms and persists in one step.
  Future<AppSettings> update(AppSettings Function(AppSettings current) change);

  /// Restores defaults.
  Future<AppSettings> reset();

  /// Current settings, re-emitted on every write.
  Stream<AppSettings> watch();
}
