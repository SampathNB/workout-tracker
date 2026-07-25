import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gym_track/core/error/exceptions.dart';
import 'package:gym_track/core/storage/hive_storage.dart';
import 'package:gym_track/core/utils/id_generator.dart';
import 'package:gym_track/features/exercises/data/datasources/exercise_local_data_source.dart';
import 'package:gym_track/features/exercises/data/repositories/exercise_repository_impl.dart';
import 'package:gym_track/features/exercises/domain/entities/exercise.dart';
import 'package:gym_track/features/exercises/domain/entities/exercise_enums.dart';
import 'package:gym_track/features/progress/data/datasources/goal_local_data_source.dart';
import 'package:gym_track/features/progress/data/datasources/progress_photo_local_data_source.dart';
import 'package:gym_track/features/progress/data/datasources/weight_entry_local_data_source.dart';
import 'package:gym_track/features/progress/data/repositories/goal_repository_impl.dart';
import 'package:gym_track/features/progress/data/repositories/progress_photo_repository_impl.dart';
import 'package:gym_track/features/progress/data/repositories/weight_entry_repository_impl.dart';
import 'package:gym_track/features/progress/domain/entities/goal.dart';
import 'package:gym_track/features/progress/domain/entities/progress_enums.dart';
import 'package:gym_track/features/progress/domain/entities/progress_photo.dart';
import 'package:gym_track/features/progress/domain/entities/weight_entry.dart';
import 'package:gym_track/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:gym_track/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:gym_track/features/settings/domain/entities/app_settings.dart';
import 'package:gym_track/features/settings/domain/entities/settings_enums.dart';
import 'package:gym_track/features/workouts/data/datasources/workout_plan_local_data_source.dart';
import 'package:gym_track/features/workouts/data/datasources/workout_session_local_data_source.dart';
import 'package:gym_track/features/workouts/data/repositories/workout_plan_repository_impl.dart';
import 'package:gym_track/features/workouts/data/repositories/workout_session_repository_impl.dart';
import 'package:gym_track/features/workouts/domain/entities/exercise_set.dart';
import 'package:gym_track/features/workouts/domain/entities/plan_exercise.dart';
import 'package:gym_track/features/workouts/domain/entities/session_exercise.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_enums.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_plan.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_session.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('gym_track_hive_test');
    await HiveStorage.init(path: tempDir.path);
    await HiveStorage.clearAll();
  });

  tearDown(() async {
    await HiveStorage.close();
    await tempDir.delete(recursive: true);
  });

  group('ExerciseRepository', () {
    ExerciseRepositoryImpl buildRepository() => ExerciseRepositoryImpl(
      ExerciseLocalDataSource(HiveStorage.exercisesBox),
    );

    Exercise buildExercise({
      String name = 'Bench Press',
      MuscleGroup muscle = MuscleGroup.chest,
      Equipment equipment = Equipment.barbell,
      ExerciseLibraryCategory libraryCategory = ExerciseLibraryCategory.chest,
    }) => Exercise(
      id: IdGenerator.generate(),
      name: name,
      primaryMuscle: muscle,
      libraryCategory: libraryCategory,
      equipment: equipment,
      secondaryMuscles: const [MuscleGroup.triceps],
      recommendedSets: 3,
      recommendedRepsMin: 8,
      recommendedRepsMax: 12,
      createdAt: DateTime(2026, 7, 1),
    );

    test('round-trips an exercise through the generated adapter', () async {
      final repository = buildRepository();
      final created = await repository.create(buildExercise());

      final loaded = await repository.getById(created.id);

      expect(loaded, isNotNull);
      expect(loaded!.name, 'Bench Press');
      expect(loaded.primaryMuscle, MuscleGroup.chest);
      expect(loaded.libraryCategory, ExerciseLibraryCategory.chest);
      expect(loaded.secondaryMuscles, [MuscleGroup.triceps]);
      expect(loaded.equipment, Equipment.barbell);
      expect(loaded.tracking, ExerciseTracking.weightAndReps);
      expect(loaded.recommendedSets, 3);
      expect(loaded.recommendedRepsMin, 8);
      expect(loaded.recommendedRepsMax, 12);
      expect(loaded.prescriptionLabel, '3×8–12');
      expect(loaded.createdAt, DateTime(2026, 7, 1));
      expect(loaded.updatedAt, isNotNull);
    });

    test('rejects duplicate ids and missing updates', () async {
      final repository = buildRepository();
      final exercise = await repository.create(buildExercise());

      expect(
        () => repository.create(exercise),
        throwsA(isA<DuplicateRecordException>()),
      );
      expect(
        () => repository.update(buildExercise()),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('queries library by muscle, equipment and search term', () async {
      final repository = buildRepository();
      await repository.create(buildExercise());
      await repository.create(
        buildExercise(
          name: 'Back Squat',
          muscle: MuscleGroup.quadriceps,
        ),
      );

      expect(await repository.getLibrary(), hasLength(2));
      expect(
        (await repository.getLibrary()).first.name,
        'Back Squat', // alphabetical
      );
      expect(await repository.getByMuscle(MuscleGroup.quadriceps), hasLength(1));
      expect(await repository.getByEquipment(Equipment.barbell), hasLength(2));
      expect(await repository.search('squat'), hasLength(1));
      expect(await repository.search('triceps'), hasLength(2));
    });

    test('toggles favorites and hides archived exercises', () async {
      final repository = buildRepository();
      final exercise = await repository.create(buildExercise());

      final favorited = await repository.toggleFavorite(exercise.id);
      expect(favorited.isFavorite, isTrue);
      expect(await repository.getFavorites(), hasLength(1));

      await repository.archive(exercise.id);
      expect(await repository.getLibrary(), isEmpty);
      expect(await repository.count(), 1);
    });

    test('watchLibrary emits after writes', () async {
      final repository = buildRepository();
      final emissions = <int>[];
      final subscription = repository.watchLibrary().listen(
        (exercises) => emissions.add(exercises.length),
      );

      await Future<void>.delayed(Duration.zero);
      await repository.create(buildExercise(name: 'Deadlift'));
      await Future<void>.delayed(Duration.zero);

      await subscription.cancel();
      expect(emissions, [0, 1]);
    });
  });

  group('WorkoutSessionRepository', () {
    WorkoutSessionRepositoryImpl buildRepository() =>
        WorkoutSessionRepositoryImpl(
          WorkoutSessionLocalDataSource(HiveStorage.workoutSessionsBox),
        );

    WorkoutSession buildSession({DateTime? startedAt}) {
      final started = startedAt ?? DateTime(2026, 7, 20, 9);
      return WorkoutSession(
        id: IdGenerator.generate(),
        name: 'Push day',
        startedAt: started,
        status: WorkoutStatus.inProgress,
        exercises: [
          SessionExercise(
            id: IdGenerator.generate(),
            exerciseId: 'exercise-1',
            exerciseName: 'Bench Press',
            order: 0,
            sets: [
              ExerciseSet(
                id: IdGenerator.generate(),
                setNumber: 1,
                reps: 10,
                weightKg: 80,
                isCompleted: true,
              ),
              ExerciseSet(
                id: IdGenerator.generate(),
                setNumber: 2,
                reps: 8,
                weightKg: 85,
              ),
            ],
          ),
        ],
      );
    }

    test('persists nested exercises and sets', () async {
      final repository = buildRepository();
      final created = await repository.create(buildSession());

      final loaded = await repository.requireById(created.id);

      expect(loaded.exercises, hasLength(1));
      expect(loaded.exercises.single.sets, hasLength(2));
      expect(loaded.totalSets, 2);
      expect(loaded.completedSetCount, 1);
      expect(loaded.totalVolumeKg, 800);
    });

    test('filters by day, status and plan', () async {
      final repository = buildRepository();
      await repository.create(buildSession());
      await repository.create(
        buildSession(startedAt: DateTime(2026, 7, 21, 18)),
      );

      expect(await repository.getForDay(DateTime(2026, 7, 20)), hasLength(1));
      expect(
        await repository.getBetween(
          DateTime(2026, 7, 19),
          DateTime(2026, 7, 21),
        ),
        hasLength(2),
      );
      expect(
        await repository.getByStatus(WorkoutStatus.inProgress),
        hasLength(2),
      );
      expect(await repository.getByPlan('missing'), isEmpty);
      expect(await repository.getActiveSession(), isNotNull);
    });

    test('completes a session and stamps duration', () async {
      final repository = buildRepository();
      final session = await repository.create(buildSession());

      final completed = await repository.complete(
        session.id,
        completedAt: DateTime(2026, 7, 20, 10),
        perceivedExertion: 8,
      );

      expect(completed.status, WorkoutStatus.completed);
      expect(completed.durationSeconds, 3600);
      expect(completed.perceivedExertion, 8);
      expect(await repository.getCompleted(), hasLength(1));
      expect(
        await repository.countBetween(
          DateTime(2026, 7, 20),
          DateTime(2026, 7, 20),
        ),
        1,
      );
    });

    test('upserts and removes session exercises', () async {
      final repository = buildRepository();
      final session = await repository.create(buildSession());
      final exercise = session.exercises.single;

      final updated = await repository.upsertExercise(
        session.id,
        exercise.copyWith(note: 'Felt strong'),
      );
      expect(updated.exercises.single.note, 'Felt strong');

      final stripped = await repository.removeExercise(
        session.id,
        exercise.id,
      );
      expect(stripped.exercises, isEmpty);
    });
  });

  group('WorkoutPlanRepository', () {
    WorkoutPlanRepositoryImpl buildRepository() => WorkoutPlanRepositoryImpl(
      WorkoutPlanLocalDataSource(HiveStorage.workoutPlansBox),
    );

    WorkoutPlan buildPlan() => WorkoutPlan(
      id: IdGenerator.generate(),
      name: 'Upper/Lower',
      createdAt: DateTime(2026, 7, 1),
      difficulty: PlanDifficulty.intermediate,
      scheduledWeekdays: const [1, 4],
      exercises: [
        PlanExercise(
          id: IdGenerator.generate(),
          exerciseId: 'exercise-1',
          exerciseName: 'Bench Press',
          order: 0,
          targetRepsMax: 12,
        ),
        PlanExercise(
          id: IdGenerator.generate(),
          exerciseId: 'exercise-2',
          exerciseName: 'Row',
          order: 1,
        ),
      ],
    );

    test('stores schedule and prescribed exercises', () async {
      final repository = buildRepository();
      final created = await repository.create(buildPlan());

      final loaded = await repository.requireById(created.id);

      expect(loaded.difficulty, PlanDifficulty.intermediate);
      expect(loaded.scheduledWeekdays, [1, 4]);
      expect(loaded.totalSets, 6);
      expect(loaded.orderedExercises.first.repRangeLabel, '8–12');
      expect(
        await repository.getScheduledFor(DateTime(2026, 7, 20)), // Monday
        hasLength(1),
      );
      expect(await repository.getScheduledFor(DateTime(2026, 7, 21)), isEmpty);
    });

    test('duplicate copies exercises under new ids', () async {
      final repository = buildRepository();
      final plan = await repository.create(buildPlan());

      final copy = await repository.duplicate(plan.id);

      expect(copy.id, isNot(plan.id));
      expect(copy.name, 'Upper/Lower (copy)');
      expect(copy.exercises, hasLength(2));
      expect(
        copy.exercises.map((exercise) => exercise.id),
        isNot(contains(plan.exercises.first.id)),
      );
      expect(await repository.getPlans(), hasLength(2));
    });

    test('reorders exercises and archives plans', () async {
      final repository = buildRepository();
      final plan = await repository.create(buildPlan());
      final reversed = plan.exercises.reversed
          .map((exercise) => exercise.id)
          .toList();

      final reordered = await repository.reorderExercises(plan.id, reversed);
      expect(reordered.orderedExercises.first.exerciseName, 'Row');

      final archived = await repository.archive(plan.id);
      expect(archived.isArchived, isTrue);
      expect(archived.isActive, isFalse);
      expect(await repository.getPlans(), isEmpty);
      expect(await repository.getArchived(), hasLength(1));
    });
  });

  group('Progress repositories', () {
    test('weight entries sort, filter and report change', () async {
      final repository = WeightEntryRepositoryImpl(
        WeightEntryLocalDataSource(HiveStorage.weightEntriesBox),
      );

      await repository.create(
        WeightEntry(
          id: IdGenerator.generate(),
          weightKg: 82.5,
          recordedAt: DateTime(2026, 7, 1, 7),
          bodyFatPercentage: 18.4,
        ),
      );
      await repository.create(
        WeightEntry(
          id: IdGenerator.generate(),
          weightKg: 81,
          recordedAt: DateTime(2026, 7, 15, 7),
        ),
      );

      final latest = await repository.getLatest();
      expect(latest?.weightKg, 81);
      expect(
        await repository.getChangeBetween(
          DateTime(2026, 7, 1),
          DateTime(2026, 7, 15),
        ),
        closeTo(-1.5, 0.001),
      );
      expect(await repository.getForDay(DateTime(2026, 7, 1)), hasLength(1));
      expect((await repository.getAllSorted()).first.weightKg, 81);
    });

    test('progress photos support pose queries and comparison', () async {
      final repository = ProgressPhotoRepositoryImpl(
        ProgressPhotoLocalDataSource(HiveStorage.progressPhotosBox),
      );

      await repository.create(
        ProgressPhoto(
          id: IdGenerator.generate(),
          filePath: '/photos/front-1.jpg',
          takenAt: DateTime(2026, 5, 1),
        ),
      );
      await repository.create(
        ProgressPhoto(
          id: IdGenerator.generate(),
          filePath: '/photos/front-2.jpg',
          takenAt: DateTime(2026, 7, 1),
          weightKg: 81,
        ),
      );

      expect(await repository.getByPose(PhotoPose.front), hasLength(2));
      final comparison = await repository.getComparison(PhotoPose.front);
      expect(comparison?.before.filePath, '/photos/front-1.jpg');
      expect(comparison?.after.filePath, '/photos/front-2.jpg');
      expect((await repository.getLatest())?.weightKg, 81);
    });

    test('goal progress auto-completes when the target is reached', () async {
      final repository = GoalRepositoryImpl(
        GoalLocalDataSource(HiveStorage.goalsBox),
      );

      final goal = await repository.create(
        Goal(
          id: IdGenerator.generate(),
          title: 'Bench 100kg',
          type: GoalType.strength,
          startValue: 80,
          targetValue: 100,
          startedAt: DateTime(2026, 7, 1),
          targetDate: DateTime(2026, 12, 1),
        ),
      );

      final halfway = await repository.updateProgress(goal.id, 90);
      expect(halfway.progress, closeTo(0.5, 0.001));
      expect(halfway.status, GoalStatus.active);
      expect(await repository.getActive(), hasLength(1));

      final done = await repository.updateProgress(goal.id, 102);
      expect(done.status, GoalStatus.achieved);
      expect(done.achievedAt, isNotNull);
      expect(await repository.getActive(), isEmpty);
      expect(await repository.getByType(GoalType.strength), hasLength(1));
    });
  });

  group('SettingsRepository', () {
    test('creates defaults, updates and resets', () async {
      final repository = SettingsRepositoryImpl(
        SettingsLocalDataSource(HiveStorage.settingsBox),
      );

      final defaults = await repository.get();
      expect(defaults.unitSystem, UnitSystem.metric);
      expect(defaults.restTimerSeconds, 90);
      expect(defaults.weeklyWorkoutGoal, 4);

      final updated = await repository.update(
        (current) => current.copyWith(
          unitSystem: UnitSystem.imperial,
          restTimerSeconds: 120,
          displayName: 'Sam',
        ),
      );
      expect(updated.unitSystem, UnitSystem.imperial);
      expect(updated.weightUnitLabel, 'lb');
      expect(repository.peek()?.displayName, 'Sam');

      final reset = await repository.reset();
      expect(reset.unitSystem, UnitSystem.metric);
      expect(reset.displayName, isNull);
      expect(await repository.get(), isNotNull);
    });

    test('watch emits current settings then updates', () async {
      final repository = SettingsRepositoryImpl(
        SettingsLocalDataSource(HiveStorage.settingsBox),
      );
      final emissions = <int>[];
      final subscription = repository.watch().listen(
        (settings) => emissions.add(settings.restTimerSeconds),
      );

      await Future<void>.delayed(Duration.zero);
      await repository.update((current) => current.copyWith(restTimerSeconds: 60));
      await Future<void>.delayed(Duration.zero);

      await subscription.cancel();
      expect(emissions, [90, 60]);
    });
  });
}
