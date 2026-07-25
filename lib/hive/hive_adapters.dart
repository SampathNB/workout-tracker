import 'package:gym_track/features/exercises/domain/entities/exercise.dart';
import 'package:gym_track/features/exercises/domain/entities/exercise_enums.dart';
import 'package:gym_track/features/progress/domain/entities/goal.dart';
import 'package:gym_track/features/progress/domain/entities/progress_enums.dart';
import 'package:gym_track/features/progress/domain/entities/progress_photo.dart';
import 'package:gym_track/features/progress/domain/entities/weight_entry.dart';
import 'package:gym_track/features/settings/domain/entities/app_settings.dart';
import 'package:gym_track/features/settings/domain/entities/settings_enums.dart';
import 'package:gym_track/features/workouts/domain/entities/exercise_set.dart';
import 'package:gym_track/features/workouts/domain/entities/plan_exercise.dart';
import 'package:gym_track/features/workouts/domain/entities/session_exercise.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_enums.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_plan.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_session.dart';
import 'package:hive_ce/hive_ce.dart';

/// Single source of truth for Hive type adapters.
///
/// Domain entities stay persistence-agnostic: adapters are generated here
/// instead of annotating entities with `@HiveType`/`@HiveField`. Type ids and
/// field indices are managed by `hive_adapters.g.yaml`, which MUST be checked
/// into version control.
///
/// Regenerate after changing any entity below:
/// ```bash
/// dart run build_runner build --delete-conflicting-outputs
/// ```
@GenerateAdapters([
  // Exercises
  AdapterSpec<Exercise>(),
  AdapterSpec<MuscleGroup>(),
  AdapterSpec<Equipment>(),
  AdapterSpec<ExerciseCategory>(),
  AdapterSpec<ExerciseTracking>(),

  // Workouts
  AdapterSpec<WorkoutSession>(),
  AdapterSpec<SessionExercise>(),
  AdapterSpec<ExerciseSet>(),
  AdapterSpec<WorkoutPlan>(),
  AdapterSpec<PlanExercise>(),
  AdapterSpec<WorkoutStatus>(),
  AdapterSpec<SetType>(),
  AdapterSpec<PlanDifficulty>(),

  // Progress
  AdapterSpec<WeightEntry>(),
  AdapterSpec<ProgressPhoto>(),
  AdapterSpec<Goal>(),
  AdapterSpec<GoalType>(),
  AdapterSpec<GoalStatus>(),
  AdapterSpec<GoalDirection>(),
  AdapterSpec<PhotoPose>(),

  // Settings
  AdapterSpec<AppSettings>(),
  AdapterSpec<UnitSystem>(),
  AdapterSpec<ThemePreference>(),
  AdapterSpec<BiologicalSex>(),
])
part 'hive_adapters.g.dart';
