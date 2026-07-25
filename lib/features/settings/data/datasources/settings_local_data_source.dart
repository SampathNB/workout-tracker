import 'package:gym_track/core/constants/app_constants.dart';
import 'package:gym_track/core/storage/hive_box_data_source.dart';
import 'package:gym_track/features/settings/domain/entities/app_settings.dart';

/// Hive-backed storage for the single [AppSettings] record.
class SettingsLocalDataSource extends HiveBoxDataSource<AppSettings> {
  const SettingsLocalDataSource(super.box);

  /// Settings are a singleton, so the key is constant.
  @override
  String keyOf(AppSettings item) => AppConstants.settingsKey;

  AppSettings? readSettings() => read(AppConstants.settingsKey);

  Stream<AppSettings?> watchSettings() =>
      watchById(AppConstants.settingsKey);
}
