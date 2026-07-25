import 'package:gym_track/core/storage/hive_box_data_source.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_session.dart';

/// Hive-backed storage for logged and scheduled workout sessions.
class WorkoutSessionLocalDataSource extends HiveBoxDataSource<WorkoutSession> {
  const WorkoutSessionLocalDataSource(super.box);

  @override
  String keyOf(WorkoutSession item) => item.id;
}
