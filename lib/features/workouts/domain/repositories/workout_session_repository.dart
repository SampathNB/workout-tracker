import 'package:gym_track/core/domain/crud_repository.dart';
import 'package:gym_track/features/workouts/domain/entities/session_exercise.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_enums.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_session.dart';

/// Persistence contract for workout sessions.
abstract interface class WorkoutSessionRepository
    implements CrudRepository<WorkoutSession> {
  /// Sessions ordered by start time, newest first.
  Future<List<WorkoutSession>> getAllSorted();

  /// Most recent sessions, newest first.
  Future<List<WorkoutSession>> getRecent({int limit = 10});

  /// Sessions starting inside `[from, to]`, oldest first.
  Future<List<WorkoutSession>> getBetween(DateTime from, DateTime to);

  /// Sessions scheduled or performed on the calendar day of [day].
  Future<List<WorkoutSession>> getForDay(DateTime day);

  Future<List<WorkoutSession>> getByStatus(WorkoutStatus status);

  /// Completed sessions only, newest first.
  Future<List<WorkoutSession>> getCompleted({int? limit});

  /// The session currently in progress, if any.
  Future<WorkoutSession?> getActiveSession();

  Future<List<WorkoutSession>> getByPlan(String planId);

  /// Marks a session completed and stamps its duration.
  Future<WorkoutSession> complete(
    String id, {
    DateTime? completedAt,
    int? durationSeconds,
    int? perceivedExertion,
  });

  /// Inserts or replaces one exercise inside a session.
  Future<WorkoutSession> upsertExercise(
    String sessionId,
    SessionExercise exercise,
  );

  /// Removes an exercise (and its sets) from a session.
  Future<WorkoutSession> removeExercise(String sessionId, String exerciseId);

  /// Number of sessions in `[from, to]`, optionally only completed ones.
  Future<int> countBetween(
    DateTime from,
    DateTime to, {
    bool completedOnly = true,
  });

  /// Sessions for a calendar day, re-emitted on every write.
  Stream<List<WorkoutSession>> watchForDay(DateTime day);

  /// Sessions ordered newest first, re-emitted on every write.
  Stream<List<WorkoutSession>> watchAllSorted();
}
