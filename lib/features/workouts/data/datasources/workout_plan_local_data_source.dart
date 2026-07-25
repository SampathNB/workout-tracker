import 'package:gym_track/core/storage/hive_box_data_source.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_plan.dart';

/// Hive-backed storage for workout plans (templates).
class WorkoutPlanLocalDataSource extends HiveBoxDataSource<WorkoutPlan> {
  const WorkoutPlanLocalDataSource(super.box);

  @override
  String keyOf(WorkoutPlan item) => item.id;
}
