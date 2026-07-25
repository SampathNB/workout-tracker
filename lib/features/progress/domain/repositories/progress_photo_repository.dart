import 'package:gym_track/core/domain/crud_repository.dart';
import 'package:gym_track/features/progress/domain/entities/progress_enums.dart';
import 'package:gym_track/features/progress/domain/entities/progress_photo.dart';

/// Persistence contract for progress photo metadata.
///
/// Only paths are stored; image files live in the app documents directory.
abstract interface class ProgressPhotoRepository
    implements CrudRepository<ProgressPhoto> {
  /// Photos ordered by capture time, newest first.
  Future<List<ProgressPhoto>> getAllSorted();

  Future<List<ProgressPhoto>> getByPose(PhotoPose pose);

  /// Photos captured inside `[from, to]`, newest first.
  Future<List<ProgressPhoto>> getBetween(DateTime from, DateTime to);

  Future<List<ProgressPhoto>> getForDay(DateTime day);

  Future<List<ProgressPhoto>> getFavorites();

  Future<ProgressPhoto?> getLatest({PhotoPose? pose});

  /// Oldest and newest photo for a pose, for before/after comparisons.
  Future<({ProgressPhoto before, ProgressPhoto after})?> getComparison(
    PhotoPose pose,
  );

  Future<ProgressPhoto> toggleFavorite(String id);

  /// Photos ordered newest first, re-emitted on every write.
  Stream<List<ProgressPhoto>> watchAllSorted();
}
