import 'dart:async';

import 'package:gym_track/core/error/exceptions.dart';
import 'package:gym_track/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:gym_track/features/settings/domain/entities/app_settings.dart';
import 'package:gym_track/features/settings/domain/repositories/settings_repository.dart';

/// Hive implementation of [SettingsRepository].
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this.dataSource);

  final SettingsLocalDataSource dataSource;

  static const AppSettings defaults = AppSettings();

  @override
  Future<AppSettings> get() => _guard(() async {
    final stored = dataSource.readSettings();
    if (stored != null) return stored;
    await dataSource.write(defaults);
    return defaults;
  }, 'load');

  @override
  AppSettings? peek() => dataSource.readSettings();

  @override
  Future<AppSettings> save(AppSettings settings) => _guard(() async {
    final stamped = settings.copyWith(updatedAt: DateTime.now());
    await dataSource.write(stamped);
    return stamped;
  }, 'save');

  @override
  Future<AppSettings> update(
    AppSettings Function(AppSettings current) change,
  ) async {
    final current = await get();
    return save(change(current));
  }

  @override
  Future<AppSettings> reset() => save(defaults);

  @override
  Stream<AppSettings> watch() async* {
    yield await get();
    yield* dataSource
        .watchSettings()
        .map((settings) => settings ?? defaults);
  }

  Future<T> _guard<T>(FutureOr<T> Function() action, String operation) async {
    try {
      return await action();
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        CacheException('Failed to $operation AppSettings: $error'),
        stackTrace,
      );
    }
  }
}
