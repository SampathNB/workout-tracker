import 'package:gym_track/core/storage/hive_box_data_source.dart';
import 'package:gym_track/features/progress/domain/entities/progress_photo.dart';

/// Hive-backed storage for progress photo metadata.
class ProgressPhotoLocalDataSource extends HiveBoxDataSource<ProgressPhoto> {
  const ProgressPhotoLocalDataSource(super.box);

  @override
  String keyOf(ProgressPhoto item) => item.id;
}
