import 'package:gym_track/core/storage/hive_box_data_source.dart';
import 'package:gym_track/features/progress/domain/entities/weight_entry.dart';

/// Hive-backed storage for body-weight measurements.
class WeightEntryLocalDataSource extends HiveBoxDataSource<WeightEntry> {
  const WeightEntryLocalDataSource(super.box);

  @override
  String keyOf(WeightEntry item) => item.id;
}
