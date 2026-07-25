import 'package:gym_track/core/data/hive_crud_repository.dart';
import 'package:gym_track/core/utils/id_generator.dart';
import 'package:gym_track/features/workouts/data/datasources/workout_plan_local_data_source.dart';
import 'package:gym_track/features/workouts/domain/entities/plan_exercise.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_plan.dart';
import 'package:gym_track/features/workouts/domain/repositories/workout_plan_repository.dart';

/// Hive implementation of [WorkoutPlanRepository].
class WorkoutPlanRepositoryImpl extends HiveCrudRepository<WorkoutPlan>
    implements WorkoutPlanRepository {
  const WorkoutPlanRepositoryImpl(
    WorkoutPlanLocalDataSource super.dataSource,
  );

  @override
  String get entityName => 'WorkoutPlan';

  @override
  String idOf(WorkoutPlan item) => item.id;

  @override
  WorkoutPlan touch(WorkoutPlan item) =>
      item.copyWith(updatedAt: DateTime.now());

  @override
  Future<List<WorkoutPlan>> getPlans() =>
      guard(() => _newestFirst(_visible(dataSource.readAll())), 'load');

  @override
  Future<List<WorkoutPlan>> getActive() => guard(() {
    final matches = _visible(dataSource.readAll()).where((plan) => plan.isActive);
    return _newestFirst(matches);
  }, 'load');

  @override
  Future<List<WorkoutPlan>> getArchived() => guard(() {
    final matches = dataSource.readAll().where((plan) => plan.isArchived);
    return _newestFirst(matches);
  }, 'load');

  @override
  Future<List<WorkoutPlan>> getScheduledFor(DateTime date) => guard(() {
    final matches = _visible(
      dataSource.readAll(),
    ).where((plan) => plan.isActive && plan.isScheduledOn(date));
    return _newestFirst(matches);
  }, 'load');

  @override
  Future<WorkoutPlan> setActive(String id, {required bool isActive}) async {
    final plan = await requireById(id);
    return save(plan.copyWith(isActive: isActive));
  }

  @override
  Future<WorkoutPlan> archive(String id, {bool isArchived = true}) async {
    final plan = await requireById(id);
    return save(plan.copyWith(isArchived: isArchived, isActive: !isArchived));
  }

  @override
  Future<WorkoutPlan> markPerformed(String id, {DateTime? performedAt}) async {
    final plan = await requireById(id);
    return save(plan.copyWith(lastPerformedAt: performedAt ?? DateTime.now()));
  }

  @override
  Future<WorkoutPlan> duplicate(String id, {String? name}) async {
    final plan = await requireById(id);
    final copy = WorkoutPlan(
      id: IdGenerator.generate(),
      name: name ?? '${plan.name} (copy)',
      createdAt: DateTime.now(),
      description: plan.description,
      difficulty: plan.difficulty,
      exercises: plan.orderedExercises
          .map(_cloneExercise)
          .toList(growable: false),
      scheduledWeekdays: List<int>.of(plan.scheduledWeekdays),
      estimatedDurationMinutes: plan.estimatedDurationMinutes,
      tags: List<String>.of(plan.tags),
      colorHex: plan.colorHex,
      isActive: plan.isActive,
    );
    return create(copy);
  }

  @override
  Future<WorkoutPlan> upsertExercise(
    String planId,
    PlanExercise exercise,
  ) async {
    final plan = await requireById(planId);
    final exercises = List<PlanExercise>.of(plan.exercises);
    final index = exercises.indexWhere((item) => item.id == exercise.id);
    if (index == -1) {
      exercises.add(exercise);
    } else {
      exercises[index] = exercise;
    }
    return save(plan.copyWith(exercises: exercises));
  }

  @override
  Future<WorkoutPlan> removeExercise(String planId, String exerciseId) async {
    final plan = await requireById(planId);
    final exercises = plan.exercises
        .where((exercise) => exercise.id != exerciseId)
        .toList();
    return save(plan.copyWith(exercises: _reindexed(exercises)));
  }

  @override
  Future<WorkoutPlan> reorderExercises(
    String planId,
    List<String> orderedIds,
  ) async {
    final plan = await requireById(planId);
    final byId = <String, PlanExercise>{
      for (final exercise in plan.exercises) exercise.id: exercise,
    };
    final reordered = <PlanExercise>[
      for (final id in orderedIds)
        if (byId.remove(id) case final PlanExercise exercise) exercise,
      // Anything not mentioned keeps its relative order at the end.
      ...byId.values,
    ];
    return save(plan.copyWith(exercises: _reindexed(reordered)));
  }

  @override
  Stream<List<WorkoutPlan>> watchPlans() =>
      dataSource.watchAll().map((plans) => _newestFirst(_visible(plans)));

  /// Copies a prescribed exercise under a fresh id.
  PlanExercise _cloneExercise(PlanExercise exercise) => PlanExercise(
    id: IdGenerator.generate(),
    exerciseId: exercise.exerciseId,
    exerciseName: exercise.exerciseName,
    order: exercise.order,
    targetSets: exercise.targetSets,
    targetRepsMin: exercise.targetRepsMin,
    targetRepsMax: exercise.targetRepsMax,
    targetWeightKg: exercise.targetWeightKg,
    targetDurationSeconds: exercise.targetDurationSeconds,
    restSeconds: exercise.restSeconds,
    supersetGroup: exercise.supersetGroup,
    note: exercise.note,
  );

  Iterable<WorkoutPlan> _visible(Iterable<WorkoutPlan> plans) =>
      plans.where((plan) => !plan.isArchived);

  List<WorkoutPlan> _newestFirst(Iterable<WorkoutPlan> plans) =>
      List<WorkoutPlan>.of(plans)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  List<PlanExercise> _reindexed(List<PlanExercise> exercises) => <PlanExercise>[
    for (var index = 0; index < exercises.length; index++)
      exercises[index].copyWith(order: index),
  ];
}
