import 'package:gym_track/core/data/hive_crud_repository.dart';
import 'package:gym_track/features/progress/data/datasources/goal_local_data_source.dart';
import 'package:gym_track/features/progress/domain/entities/goal.dart';
import 'package:gym_track/features/progress/domain/entities/progress_enums.dart';
import 'package:gym_track/features/progress/domain/repositories/goal_repository.dart';

/// Hive implementation of [GoalRepository].
class GoalRepositoryImpl extends HiveCrudRepository<Goal>
    implements GoalRepository {
  const GoalRepositoryImpl(GoalLocalDataSource super.dataSource);

  @override
  String get entityName => 'Goal';

  @override
  String idOf(Goal item) => item.id;

  @override
  Goal touch(Goal item) => item.copyWith(updatedAt: DateTime.now());

  @override
  Future<List<Goal>> getActive() => guard(() {
    final matches = dataSource.readAll().where((goal) => goal.isActive);
    return _byDeadline(matches);
  }, 'load');

  @override
  Future<List<Goal>> getByStatus(GoalStatus status) => guard(() {
    final matches = dataSource.readAll().where((goal) => goal.status == status);
    return _byDeadline(matches);
  }, 'load');

  @override
  Future<List<Goal>> getByType(GoalType type) => guard(() {
    final matches = dataSource.readAll().where((goal) => goal.type == type);
    return _byDeadline(matches);
  }, 'load');

  @override
  Future<List<Goal>> getForExercise(String exerciseId) => guard(() {
    final matches = dataSource.readAll().where(
      (goal) => goal.exerciseId == exerciseId,
    );
    return _byDeadline(matches);
  }, 'load');

  @override
  Future<List<Goal>> getOverdue() => guard(() {
    final matches = dataSource.readAll().where((goal) => goal.isOverdue);
    return _byDeadline(matches);
  }, 'load');

  @override
  Future<Goal> updateProgress(String id, double value) async {
    final goal = await requireById(id);
    final updated = goal.copyWith(currentValue: value);
    if (updated.isActive && updated.hasReachedTarget) {
      return save(
        updated.copyWith(
          status: GoalStatus.achieved,
          achievedAt: DateTime.now(),
        ),
      );
    }
    return save(updated);
  }

  @override
  Future<Goal> markAchieved(String id, {DateTime? achievedAt}) async {
    final goal = await requireById(id);
    return save(
      goal.copyWith(
        status: GoalStatus.achieved,
        achievedAt: achievedAt ?? DateTime.now(),
        currentValue: goal.targetValue,
      ),
    );
  }

  @override
  Future<Goal> archive(String id) async {
    final goal = await requireById(id);
    return save(goal.copyWith(status: GoalStatus.archived));
  }

  @override
  Stream<List<Goal>> watchActive() => dataSource.watchAll().map(
    (goals) => _byDeadline(goals.where((goal) => goal.isActive)),
  );

  /// Soonest deadline first; goals without a deadline go last.
  List<Goal> _byDeadline(Iterable<Goal> goals) => List<Goal>.of(goals)..sort((
    a,
    b,
  ) {
    final aDate = a.targetDate;
    final bDate = b.targetDate;
    if (aDate == null && bDate == null) {
      return b.startedAt.compareTo(a.startedAt);
    }
    if (aDate == null) return 1;
    if (bDate == null) return -1;
    return aDate.compareTo(bDate);
  });
}
