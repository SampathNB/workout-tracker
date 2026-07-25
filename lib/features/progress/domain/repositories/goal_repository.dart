import 'package:gym_track/core/domain/crud_repository.dart';
import 'package:gym_track/features/progress/domain/entities/goal.dart';
import 'package:gym_track/features/progress/domain/entities/progress_enums.dart';

/// Persistence contract for user goals.
abstract interface class GoalRepository implements CrudRepository<Goal> {
  /// Active goals, soonest deadline first.
  Future<List<Goal>> getActive();

  Future<List<Goal>> getByStatus(GoalStatus status);

  Future<List<Goal>> getByType(GoalType type);

  /// Goals tied to a specific library exercise.
  Future<List<Goal>> getForExercise(String exerciseId);

  /// Active goals whose target date has passed.
  Future<List<Goal>> getOverdue();

  /// Records a new measurement, auto-completing the goal when reached.
  Future<Goal> updateProgress(String id, double value);

  Future<Goal> markAchieved(String id, {DateTime? achievedAt});

  Future<Goal> archive(String id);

  /// Active goals, re-emitted on every write.
  Stream<List<Goal>> watchActive();
}
