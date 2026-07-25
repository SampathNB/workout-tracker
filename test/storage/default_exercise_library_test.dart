import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gym_track/core/storage/hive_storage.dart';
import 'package:gym_track/features/exercises/data/datasources/exercise_local_data_source.dart';
import 'package:gym_track/features/exercises/data/default_exercise_library.dart';
import 'package:gym_track/features/exercises/data/exercise_library_seeder.dart';
import 'package:gym_track/features/exercises/data/repositories/exercise_repository_impl.dart';
import 'package:gym_track/features/exercises/domain/entities/exercise.dart';
import 'package:gym_track/features/exercises/domain/entities/exercise_enums.dart';

void main() {
  group('DefaultExerciseLibrary catalog', () {
    test('covers all eight browse categories with 8–12 exercises each', () {
      expect(
        DefaultExerciseLibrary.byCategory.keys,
        unorderedEquals(ExerciseLibraryCategory.values),
      );

      for (final category in ExerciseLibraryCategory.values) {
        final exercises = DefaultExerciseLibrary.of(category);
        expect(
          exercises.length,
          inInclusiveRange(8, 12),
          reason: '${category.label} should have 8–12 exercises',
        );
        expect(
          exercises.every((exercise) => exercise.libraryCategory == category),
          isTrue,
        );
        expect(
          exercises.every((exercise) => !exercise.isCustom),
          isTrue,
        );
        expect(
          exercises.map((exercise) => exercise.id).toSet(),
          hasLength(exercises.length),
          reason: '${category.label} ids must be unique',
        );
      }
    });

    test('every exercise has a usable prescription', () {
      for (final exercise in DefaultExerciseLibrary.all) {
        expect(exercise.recommendedSets, greaterThan(0));
        expect(exercise.prescriptionLabel, isNotEmpty);
        expect(exercise.id, startsWith('default_'));

        if (exercise.isDurationBased) {
          expect(exercise.recommendedDurationSeconds, isNotNull);
          expect(exercise.recommendedDurationSeconds!, greaterThan(0));
        } else {
          expect(exercise.recommendedRepsMin, greaterThan(0));
          expect(
            exercise.recommendedRepsMax,
            greaterThanOrEqualTo(exercise.recommendedRepsMin),
          );
        }
      }
    });

    test('exposes expected category sizes', () {
      expect(DefaultExerciseLibrary.chest, hasLength(10));
      expect(DefaultExerciseLibrary.back, hasLength(12));
      expect(DefaultExerciseLibrary.shoulders, hasLength(10));
      expect(DefaultExerciseLibrary.biceps, hasLength(10));
      expect(DefaultExerciseLibrary.triceps, hasLength(10));
      expect(DefaultExerciseLibrary.legs, hasLength(12));
      expect(DefaultExerciseLibrary.cardio, hasLength(10));
      expect(DefaultExerciseLibrary.abs, hasLength(12));
      expect(DefaultExerciseLibrary.all, hasLength(86));
    });
  });

  group('ExerciseLibrarySeeder', () {
    late Directory tempDir;
    late ExerciseRepositoryImpl repository;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('gym_track_library_test');
      await HiveStorage.init(path: tempDir.path);
      await HiveStorage.clearAll();
      repository = ExerciseRepositoryImpl(
        ExerciseLocalDataSource(HiveStorage.exercisesBox),
      );
    });

    tearDown(() async {
      await HiveStorage.close();
      await tempDir.delete(recursive: true);
    });

    test('seeds the full library on first run', () async {
      final inserted = await ExerciseLibrarySeeder.ensureSeeded(repository);

      expect(inserted, DefaultExerciseLibrary.all.length);
      expect(await repository.getLibrary(), hasLength(86));
      expect(
        await repository.getByLibraryCategory(ExerciseLibraryCategory.chest),
        hasLength(10),
      );
      expect(
        await repository.getByLibraryCategory(ExerciseLibraryCategory.legs),
        hasLength(12),
      );
      expect(await repository.getDefaults(), hasLength(86));
      expect(await repository.getCustom(), isEmpty);

      final bench = await repository.getById(
        'default_chest_barbell_bench_press',
      );
      expect(bench?.prescriptionLabel, '4×6–10');
      expect(bench?.libraryCategory, ExerciseLibraryCategory.chest);

      final plank = await repository.getById('default_abs_plank');
      expect(plank?.prescriptionLabel, '3×30s–1min');
      expect(plank?.tracking, ExerciseTracking.duration);
    });

    test('is idempotent and preserves favorites', () async {
      await ExerciseLibrarySeeder.ensureSeeded(repository);
      await repository.toggleFavorite('default_chest_barbell_bench_press');

      final secondPass = await ExerciseLibrarySeeder.ensureSeeded(repository);
      expect(secondPass, 0);

      final favorited = await repository.getById(
        'default_chest_barbell_bench_press',
      );
      expect(favorited?.isFavorite, isTrue);
      expect(await repository.getFavorites(), hasLength(1));
    });
  });
}
