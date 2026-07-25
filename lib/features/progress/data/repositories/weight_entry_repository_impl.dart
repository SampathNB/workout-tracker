import 'package:gym_track/core/data/hive_crud_repository.dart';
import 'package:gym_track/features/progress/data/datasources/weight_entry_local_data_source.dart';
import 'package:gym_track/features/progress/domain/entities/weight_entry.dart';
import 'package:gym_track/features/progress/domain/repositories/weight_entry_repository.dart';

/// Hive implementation of [WeightEntryRepository].
class WeightEntryRepositoryImpl extends HiveCrudRepository<WeightEntry>
    implements WeightEntryRepository {
  const WeightEntryRepositoryImpl(
    WeightEntryLocalDataSource super.dataSource,
  );

  @override
  String get entityName => 'WeightEntry';

  @override
  String idOf(WeightEntry item) => item.id;

  @override
  WeightEntry touch(WeightEntry item) =>
      item.copyWith(updatedAt: DateTime.now());

  @override
  Future<List<WeightEntry>> getAllSorted() =>
      guard(() => _newestFirst(dataSource.readAll()), 'load');

  @override
  Future<List<WeightEntry>> getBetween(DateTime from, DateTime to) =>
      guard(() => _oldestFirst(_entriesBetween(from, to)), 'load');

  @override
  Future<List<WeightEntry>> getRecent({int days = 30}) {
    final now = DateTime.now();
    return getBetween(now.subtract(Duration(days: days)), now);
  }

  @override
  Future<WeightEntry?> getLatest() => guard(() {
    final entries = _newestFirst(dataSource.readAll());
    return entries.isEmpty ? null : entries.first;
  }, 'load');

  @override
  Future<List<WeightEntry>> getForDay(DateTime day) => guard(() {
    final target = DateTime(day.year, day.month, day.day);
    final matches = dataSource.readAll().where((entry) => entry.day == target);
    return _newestFirst(matches);
  }, 'load');

  @override
  Future<double?> getChangeBetween(DateTime from, DateTime to) async {
    final entries = await getBetween(from, to);
    if (entries.length < 2) return null;
    return entries.last.weightKg - entries.first.weightKg;
  }

  @override
  Stream<List<WeightEntry>> watchAllSorted() =>
      dataSource.watchAll().map(_newestFirst);

  @override
  Stream<WeightEntry?> watchLatest() => dataSource.watchAll().map((entries) {
    final sorted = _newestFirst(entries);
    return sorted.isEmpty ? null : sorted.first;
  });

  Iterable<WeightEntry> _entriesBetween(DateTime from, DateTime to) {
    final start = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day, 23, 59, 59, 999);
    return dataSource.readAll().where(
      (entry) =>
          !entry.recordedAt.isBefore(start) && !entry.recordedAt.isAfter(end),
    );
  }

  List<WeightEntry> _newestFirst(Iterable<WeightEntry> entries) =>
      List<WeightEntry>.of(entries)
        ..sort((a, b) => b.recordedAt.compareTo(a.recordedAt));

  List<WeightEntry> _oldestFirst(Iterable<WeightEntry> entries) =>
      List<WeightEntry>.of(entries)
        ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
}
