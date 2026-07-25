import 'package:gym_track/core/domain/crud_repository.dart';
import 'package:gym_track/features/progress/domain/entities/weight_entry.dart';

/// Persistence contract for body-weight tracking.
abstract interface class WeightEntryRepository
    implements CrudRepository<WeightEntry> {
  /// Entries ordered by measurement time, newest first.
  Future<List<WeightEntry>> getAllSorted();

  /// Entries recorded inside `[from, to]`, oldest first (chart-friendly).
  Future<List<WeightEntry>> getBetween(DateTime from, DateTime to);

  /// Entries from the last [days] days, oldest first.
  Future<List<WeightEntry>> getRecent({int days = 30});

  /// Most recent entry, or null when nothing was logged yet.
  Future<WeightEntry?> getLatest();

  /// Entries recorded on the calendar day of [day].
  Future<List<WeightEntry>> getForDay(DateTime day);

  /// Signed change between the first and last entry in `[from, to]`.
  Future<double?> getChangeBetween(DateTime from, DateTime to);

  /// Entries ordered newest first, re-emitted on every write.
  Stream<List<WeightEntry>> watchAllSorted();

  /// Latest entry, re-emitted on every write.
  Stream<WeightEntry?> watchLatest();
}
