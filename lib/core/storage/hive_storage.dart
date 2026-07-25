import 'package:gym_track/core/constants/app_constants.dart';
import 'package:gym_track/features/exercises/domain/entities/exercise.dart';
import 'package:gym_track/features/progress/domain/entities/goal.dart';
import 'package:gym_track/features/progress/domain/entities/progress_photo.dart';
import 'package:gym_track/features/progress/domain/entities/weight_entry.dart';
import 'package:gym_track/features/settings/domain/entities/app_settings.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_plan.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_session.dart';
import 'package:gym_track/hive/hive_registrar.g.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

/// Initializes Hive CE, registers generated adapters and opens typed boxes.
///
/// Call [init] once during app bootstrap before `runApp`. Pass [path] to run
/// against a temporary directory in tests.
abstract final class HiveStorage {
  static bool _adaptersRegistered = false;
  static bool _initialized = false;

  static Future<void> init({String? path}) async {
    if (_initialized) return;

    if (path == null) {
      await Hive.initFlutter();
    } else {
      Hive.init(path);
    }

    registerAdapters();
    await openBoxes();
    _initialized = true;
  }

  /// Registers every generated adapter exactly once.
  static void registerAdapters() {
    if (_adaptersRegistered) return;
    Hive.registerAdapters();
    _adaptersRegistered = true;
  }

  /// Opens all application boxes in parallel.
  static Future<void> openBoxes() async {
    await Future.wait<void>([
      Hive.openBox<AppSettings>(AppConstants.settingsBox),
      Hive.openBox<Exercise>(AppConstants.exercisesBox),
      Hive.openBox<WorkoutSession>(AppConstants.workoutSessionsBox),
      Hive.openBox<WorkoutPlan>(AppConstants.workoutPlansBox),
      Hive.openBox<WeightEntry>(AppConstants.weightEntriesBox),
      Hive.openBox<ProgressPhoto>(AppConstants.progressPhotosBox),
      Hive.openBox<Goal>(AppConstants.goalsBox),
    ]);
  }

  static Box<AppSettings> get settingsBox =>
      Hive.box<AppSettings>(AppConstants.settingsBox);

  static Box<Exercise> get exercisesBox =>
      Hive.box<Exercise>(AppConstants.exercisesBox);

  static Box<WorkoutSession> get workoutSessionsBox =>
      Hive.box<WorkoutSession>(AppConstants.workoutSessionsBox);

  static Box<WorkoutPlan> get workoutPlansBox =>
      Hive.box<WorkoutPlan>(AppConstants.workoutPlansBox);

  static Box<WeightEntry> get weightEntriesBox =>
      Hive.box<WeightEntry>(AppConstants.weightEntriesBox);

  static Box<ProgressPhoto> get progressPhotosBox =>
      Hive.box<ProgressPhoto>(AppConstants.progressPhotosBox);

  static Box<Goal> get goalsBox => Hive.box<Goal>(AppConstants.goalsBox);

  /// Wipes every box. Used by "reset app data" and by tests.
  static Future<void> clearAll() async {
    await Future.wait<void>([
      settingsBox.clear(),
      exercisesBox.clear(),
      workoutSessionsBox.clear(),
      workoutPlansBox.clear(),
      weightEntriesBox.clear(),
      progressPhotosBox.clear(),
      goalsBox.clear(),
    ]);
  }

  /// Flushes pending writes to disk.
  static Future<void> flush() async {
    await Future.wait<void>([
      settingsBox.flush(),
      exercisesBox.flush(),
      workoutSessionsBox.flush(),
      workoutPlansBox.flush(),
      weightEntriesBox.flush(),
      progressPhotosBox.flush(),
      goalsBox.flush(),
    ]);
  }

  static Future<void> close() async {
    await Hive.close();
    _initialized = false;
  }
}
