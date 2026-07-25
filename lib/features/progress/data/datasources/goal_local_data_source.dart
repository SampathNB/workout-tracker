import 'package:gym_track/core/storage/hive_box_data_source.dart';
import 'package:gym_track/features/progress/domain/entities/goal.dart';

/// Hive-backed storage for user goals.
class GoalLocalDataSource extends HiveBoxDataSource<Goal> {
  const GoalLocalDataSource(super.box);

  @override
  String keyOf(Goal item) => item.id;
}
