import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_track/core/storage/hive_storage.dart';
import 'package:gym_track/features/exercises/data/datasources/exercise_local_data_source.dart';
import 'package:gym_track/features/exercises/data/exercise_library_seeder.dart';
import 'package:gym_track/features/exercises/data/repositories/exercise_repository_impl.dart';
import 'package:gym_track/features/exercises/domain/entities/exercise.dart';
import 'package:gym_track/features/exercises/domain/repositories/exercise_repository.dart';
import 'package:gym_track/features/progress/data/datasources/goal_local_data_source.dart';
import 'package:gym_track/features/progress/data/datasources/progress_photo_local_data_source.dart';
import 'package:gym_track/features/progress/data/datasources/weight_entry_local_data_source.dart';
import 'package:gym_track/features/progress/data/repositories/goal_repository_impl.dart';
import 'package:gym_track/features/progress/data/repositories/progress_photo_repository_impl.dart';
import 'package:gym_track/features/progress/data/repositories/weight_entry_repository_impl.dart';
import 'package:gym_track/features/progress/domain/entities/goal.dart';
import 'package:gym_track/features/progress/domain/entities/progress_photo.dart';
import 'package:gym_track/features/progress/domain/entities/weight_entry.dart';
import 'package:gym_track/features/progress/domain/repositories/goal_repository.dart';
import 'package:gym_track/features/progress/domain/repositories/progress_photo_repository.dart';
import 'package:gym_track/features/progress/domain/repositories/weight_entry_repository.dart';
import 'package:gym_track/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:gym_track/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:gym_track/features/settings/domain/entities/app_settings.dart';
import 'package:gym_track/features/settings/domain/repositories/settings_repository.dart';
import 'package:gym_track/features/workouts/data/datasources/workout_plan_local_data_source.dart';
import 'package:gym_track/features/workouts/data/datasources/workout_session_local_data_source.dart';
import 'package:gym_track/features/workouts/data/repositories/workout_plan_repository_impl.dart';
import 'package:gym_track/features/workouts/data/repositories/workout_session_repository_impl.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_plan.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_session.dart';
import 'package:gym_track/features/workouts/domain/repositories/workout_plan_repository.dart';
import 'package:gym_track/features/workouts/domain/repositories/workout_session_repository.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Holds async dependencies that must be resolved before the widget tree runs.
///
/// Construct via [DependencyInjection.init] and override providers in
/// `ProviderScope` so feature modules can inject these without globals.
final class AppDependencies {
  const AppDependencies({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;
}

/// Bootstraps infrastructure (Hive, SharedPreferences, default library) for DI.
abstract final class DependencyInjection {
  static Future<AppDependencies> init() async {
    await HiveStorage.init();

    // Seed bundled exercises before the UI mounts so the library is ready.
    final exerciseRepository = ExerciseRepositoryImpl(
      ExerciseLocalDataSource(HiveStorage.exercisesBox),
    );
    await ExerciseLibrarySeeder.ensureSeeded(exerciseRepository);

    final sharedPreferences = await SharedPreferences.getInstance();
    return AppDependencies(sharedPreferences: sharedPreferences);
  }
}

/// Provides [SharedPreferences] after bootstrap override.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in ProviderScope',
  );
});

// ---------------------------------------------------------------------------
// Hive boxes
// ---------------------------------------------------------------------------

final settingsBoxProvider = Provider<Box<AppSettings>>(
  (ref) => HiveStorage.settingsBox,
);

final exercisesBoxProvider = Provider<Box<Exercise>>(
  (ref) => HiveStorage.exercisesBox,
);

final workoutSessionsBoxProvider = Provider<Box<WorkoutSession>>(
  (ref) => HiveStorage.workoutSessionsBox,
);

final workoutPlansBoxProvider = Provider<Box<WorkoutPlan>>(
  (ref) => HiveStorage.workoutPlansBox,
);

final weightEntriesBoxProvider = Provider<Box<WeightEntry>>(
  (ref) => HiveStorage.weightEntriesBox,
);

final progressPhotosBoxProvider = Provider<Box<ProgressPhoto>>(
  (ref) => HiveStorage.progressPhotosBox,
);

final goalsBoxProvider = Provider<Box<Goal>>((ref) => HiveStorage.goalsBox);

// ---------------------------------------------------------------------------
// Local datasources
// ---------------------------------------------------------------------------

final exerciseLocalDataSourceProvider = Provider<ExerciseLocalDataSource>(
  (ref) => ExerciseLocalDataSource(ref.watch(exercisesBoxProvider)),
);

final workoutSessionLocalDataSourceProvider =
    Provider<WorkoutSessionLocalDataSource>(
      (ref) =>
          WorkoutSessionLocalDataSource(ref.watch(workoutSessionsBoxProvider)),
    );

final workoutPlanLocalDataSourceProvider = Provider<WorkoutPlanLocalDataSource>(
  (ref) => WorkoutPlanLocalDataSource(ref.watch(workoutPlansBoxProvider)),
);

final weightEntryLocalDataSourceProvider = Provider<WeightEntryLocalDataSource>(
  (ref) => WeightEntryLocalDataSource(ref.watch(weightEntriesBoxProvider)),
);

final progressPhotoLocalDataSourceProvider =
    Provider<ProgressPhotoLocalDataSource>(
      (ref) =>
          ProgressPhotoLocalDataSource(ref.watch(progressPhotosBoxProvider)),
    );

final goalLocalDataSourceProvider = Provider<GoalLocalDataSource>(
  (ref) => GoalLocalDataSource(ref.watch(goalsBoxProvider)),
);

final settingsLocalDataSourceProvider = Provider<SettingsLocalDataSource>(
  (ref) => SettingsLocalDataSource(ref.watch(settingsBoxProvider)),
);

// ---------------------------------------------------------------------------
// Repositories — inject these from feature providers
// ---------------------------------------------------------------------------

final exerciseRepositoryProvider = Provider<ExerciseRepository>(
  (ref) => ExerciseRepositoryImpl(ref.watch(exerciseLocalDataSourceProvider)),
);

final workoutSessionRepositoryProvider = Provider<WorkoutSessionRepository>(
  (ref) => WorkoutSessionRepositoryImpl(
    ref.watch(workoutSessionLocalDataSourceProvider),
  ),
);

final workoutPlanRepositoryProvider = Provider<WorkoutPlanRepository>(
  (ref) =>
      WorkoutPlanRepositoryImpl(ref.watch(workoutPlanLocalDataSourceProvider)),
);

final weightEntryRepositoryProvider = Provider<WeightEntryRepository>(
  (ref) =>
      WeightEntryRepositoryImpl(ref.watch(weightEntryLocalDataSourceProvider)),
);

final progressPhotoRepositoryProvider = Provider<ProgressPhotoRepository>(
  (ref) => ProgressPhotoRepositoryImpl(
    ref.watch(progressPhotoLocalDataSourceProvider),
  ),
);

final goalRepositoryProvider = Provider<GoalRepository>(
  (ref) => GoalRepositoryImpl(ref.watch(goalLocalDataSourceProvider)),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepositoryImpl(ref.watch(settingsLocalDataSourceProvider)),
);
