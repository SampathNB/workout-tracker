import 'package:gym_track/core/data/hive_crud_repository.dart';
import 'package:gym_track/features/progress/data/datasources/progress_photo_local_data_source.dart';
import 'package:gym_track/features/progress/domain/entities/progress_enums.dart';
import 'package:gym_track/features/progress/domain/entities/progress_photo.dart';
import 'package:gym_track/features/progress/domain/repositories/progress_photo_repository.dart';

/// Hive implementation of [ProgressPhotoRepository].
class ProgressPhotoRepositoryImpl extends HiveCrudRepository<ProgressPhoto>
    implements ProgressPhotoRepository {
  const ProgressPhotoRepositoryImpl(
    ProgressPhotoLocalDataSource super.dataSource,
  );

  @override
  String get entityName => 'ProgressPhoto';

  @override
  String idOf(ProgressPhoto item) => item.id;

  @override
  Future<List<ProgressPhoto>> getAllSorted() =>
      guard(() => _newestFirst(dataSource.readAll()), 'load');

  @override
  Future<List<ProgressPhoto>> getByPose(PhotoPose pose) => guard(() {
    final matches = dataSource.readAll().where((photo) => photo.pose == pose);
    return _newestFirst(matches);
  }, 'load');

  @override
  Future<List<ProgressPhoto>> getBetween(DateTime from, DateTime to) =>
      guard(() {
        final start = DateTime(from.year, from.month, from.day);
        final end = DateTime(to.year, to.month, to.day, 23, 59, 59, 999);
        final matches = dataSource.readAll().where(
          (photo) =>
              !photo.takenAt.isBefore(start) && !photo.takenAt.isAfter(end),
        );
        return _newestFirst(matches);
      }, 'load');

  @override
  Future<List<ProgressPhoto>> getForDay(DateTime day) => guard(() {
    final target = DateTime(day.year, day.month, day.day);
    final matches = dataSource.readAll().where((photo) => photo.day == target);
    return _newestFirst(matches);
  }, 'load');

  @override
  Future<List<ProgressPhoto>> getFavorites() => guard(() {
    final matches = dataSource.readAll().where((photo) => photo.isFavorite);
    return _newestFirst(matches);
  }, 'load');

  @override
  Future<ProgressPhoto?> getLatest({PhotoPose? pose}) => guard(() {
    final photos = _newestFirst(
      dataSource.readAll().where(
        (photo) => pose == null || photo.pose == pose,
      ),
    );
    return photos.isEmpty ? null : photos.first;
  }, 'load');

  @override
  Future<({ProgressPhoto before, ProgressPhoto after})?> getComparison(
    PhotoPose pose,
  ) async {
    final photos = await getByPose(pose);
    if (photos.length < 2) return null;
    return (before: photos.last, after: photos.first);
  }

  @override
  Future<ProgressPhoto> toggleFavorite(String id) async {
    final photo = await requireById(id);
    return save(photo.copyWith(isFavorite: !photo.isFavorite));
  }

  @override
  Stream<List<ProgressPhoto>> watchAllSorted() =>
      dataSource.watchAll().map(_newestFirst);

  List<ProgressPhoto> _newestFirst(Iterable<ProgressPhoto> photos) =>
      List<ProgressPhoto>.of(photos)
        ..sort((a, b) => b.takenAt.compareTo(a.takenAt));
}
