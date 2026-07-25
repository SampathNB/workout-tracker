import 'package:gym_track/core/domain/crud_repository.dart';
import 'package:gym_track/features/workouts/domain/entities/plan_exercise.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_plan.dart';

/// Persistence contract for workout plans (templates).
abstract interface class WorkoutPlanRepository
    implements CrudRepository<WorkoutPlan> {
  /// Non-archived plans, most recently created first.
  Future<List<WorkoutPlan>> getPlans();

  /// Active, non-archived plans.
  Future<List<WorkoutPlan>> getActive();

  Future<List<WorkoutPlan>> getArchived();

  /// Plans scheduled on the weekday of [date].
  Future<List<WorkoutPlan>> getScheduledFor(DateTime date);

  Future<WorkoutPlan> setActive(String id, {required bool isActive});

  Future<WorkoutPlan> archive(String id, {bool isArchived = true});

  /// Stamps [performedAt] as the plan's last performed date.
  Future<WorkoutPlan> markPerformed(String id, {DateTime? performedAt});

  /// Copies a plan (new ids for the plan and its exercises).
  Future<WorkoutPlan> duplicate(String id, {String? name});

  /// Inserts or replaces one prescribed exercise.
  Future<WorkoutPlan> upsertExercise(String planId, PlanExercise exercise);

  Future<WorkoutPlan> removeExercise(String planId, String exerciseId);

  /// Applies a new order to the plan's exercises.
  Future<WorkoutPlan> reorderExercises(String planId, List<String> orderedIds);

  /// Non-archived plans, re-emitted on every write.
  Stream<List<WorkoutPlan>> watchPlans();
}
