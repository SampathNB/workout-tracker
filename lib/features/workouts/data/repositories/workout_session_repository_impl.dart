import 'package:gym_track/core/data/hive_crud_repository.dart';
import 'package:gym_track/features/workouts/data/datasources/workout_session_local_data_source.dart';
import 'package:gym_track/features/workouts/domain/entities/session_exercise.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_enums.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_session.dart';
import 'package:gym_track/features/workouts/domain/repositories/workout_session_repository.dart';

/// Hive implementation of [WorkoutSessionRepository].
class WorkoutSessionRepositoryImpl extends HiveCrudRepository<WorkoutSession>
    implements WorkoutSessionRepository {
  const WorkoutSessionRepositoryImpl(
    WorkoutSessionLocalDataSource super.dataSource,
  );

  @override
  String get entityName => 'WorkoutSession';

  @override
  String idOf(WorkoutSession item) => item.id;

  @override
  WorkoutSession touch(WorkoutSession item) =>
      item.copyWith(updatedAt: DateTime.now());

  @override
  Future<List<WorkoutSession>> getAllSorted() =>
      guard(() => _newestFirst(dataSource.readAll()), 'load');

  @override
  Future<List<WorkoutSession>> getRecent({int limit = 10}) => guard(() {
    final sessions = _newestFirst(dataSource.readAll());
    return sessions.take(limit).toList(growable: false);
  }, 'load');

  @override
  Future<List<WorkoutSession>> getBetween(DateTime from, DateTime to) =>
      guard(() {
        final start = _startOfDay(from);
        final end = _endOfDay(to);
        final matches = dataSource.readAll().where(
          (session) =>
              !session.startedAt.isBefore(start) &&
              !session.startedAt.isAfter(end),
        );
        return _oldestFirst(matches);
      }, 'load');

  @override
  Future<List<WorkoutSession>> getForDay(DateTime day) => guard(() {
    final target = _startOfDay(day);
    final matches = dataSource.readAll().where(
      (session) => session.day == target,
    );
    return _oldestFirst(matches);
  }, 'load');

  @override
  Future<List<WorkoutSession>> getByStatus(WorkoutStatus status) => guard(() {
    final matches = dataSource.readAll().where(
      (session) => session.status == status,
    );
    return _newestFirst(matches);
  }, 'load');

  @override
  Future<List<WorkoutSession>> getCompleted({int? limit}) => guard(() {
    final matches = _newestFirst(
      dataSource.readAll().where((session) => session.isCompleted),
    );
    if (limit == null) return matches;
    return matches.take(limit).toList(growable: false);
  }, 'load');

  @override
  Future<WorkoutSession?> getActiveSession() => guard(() {
    final active = _newestFirst(
      dataSource.readAll().where((session) => session.isInProgress),
    );
    return active.isEmpty ? null : active.first;
  }, 'load');

  @override
  Future<List<WorkoutSession>> getByPlan(String planId) => guard(() {
    final matches = dataSource.readAll().where(
      (session) => session.planId == planId,
    );
    return _newestFirst(matches);
  }, 'load');

  @override
  Future<WorkoutSession> complete(
    String id, {
    DateTime? completedAt,
    int? durationSeconds,
    int? perceivedExertion,
  }) async {
    final session = await requireById(id);
    final finishedAt = completedAt ?? DateTime.now();
    return save(
      session.copyWith(
        status: WorkoutStatus.completed,
        completedAt: finishedAt,
        durationSeconds:
            durationSeconds ??
            finishedAt.difference(session.startedAt).inSeconds,
        perceivedExertion: perceivedExertion,
      ),
    );
  }

  @override
  Future<WorkoutSession> upsertExercise(
    String sessionId,
    SessionExercise exercise,
  ) async {
    final session = await requireById(sessionId);
    final exercises = List<SessionExercise>.of(session.exercises);
    final index = exercises.indexWhere((item) => item.id == exercise.id);
    if (index == -1) {
      exercises.add(exercise);
    } else {
      exercises[index] = exercise;
    }
    return save(session.copyWith(exercises: exercises));
  }

  @override
  Future<WorkoutSession> removeExercise(
    String sessionId,
    String exerciseId,
  ) async {
    final session = await requireById(sessionId);
    final exercises = session.exercises
        .where((exercise) => exercise.id != exerciseId)
        .toList();
    return save(session.copyWith(exercises: exercises));
  }

  @override
  Future<int> countBetween(
    DateTime from,
    DateTime to, {
    bool completedOnly = true,
  }) async {
    final sessions = await getBetween(from, to);
    if (!completedOnly) return sessions.length;
    return sessions.where((session) => session.isCompleted).length;
  }

  @override
  Stream<List<WorkoutSession>> watchForDay(DateTime day) {
    final target = _startOfDay(day);
    return dataSource.watchAll().map(
      (sessions) =>
          _oldestFirst(sessions.where((session) => session.day == target)),
    );
  }

  @override
  Stream<List<WorkoutSession>> watchAllSorted() =>
      dataSource.watchAll().map(_newestFirst);

  List<WorkoutSession> _newestFirst(Iterable<WorkoutSession> sessions) =>
      List<WorkoutSession>.of(sessions)
        ..sort((a, b) => b.startedAt.compareTo(a.startedAt));

  List<WorkoutSession> _oldestFirst(Iterable<WorkoutSession> sessions) =>
      List<WorkoutSession>.of(sessions)
        ..sort((a, b) => a.startedAt.compareTo(b.startedAt));

  DateTime _startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  DateTime _endOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
}
