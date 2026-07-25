/// Browse categories in the default workout library.
///
/// Distinct from [MuscleGroup]: a single category (e.g. Legs) can span several
/// primary muscles (quads, hamstrings, glutes, calves).
enum ExerciseLibraryCategory {
  chest,
  back,
  shoulders,
  biceps,
  triceps,
  legs,
  cardio,
  abs,
}

/// Muscle groups an exercise can target.
enum MuscleGroup {
  chest,
  upperBack,
  lats,
  shoulders,
  biceps,
  triceps,
  forearms,
  core,
  glutes,
  quadriceps,
  hamstrings,
  calves,
  fullBody,
  cardio,
}

/// Equipment required to perform an exercise.
enum Equipment {
  bodyweight,
  barbell,
  dumbbell,
  kettlebell,
  machine,
  cable,
  smithMachine,
  resistanceBand,
  medicineBall,
  pullUpBar,
  bench,
  cardioMachine,
  other,
}

/// Broad training intent of an exercise.
enum ExerciseCategory {
  strength,
  hypertrophy,
  cardio,
  mobility,
  plyometric,
  olympic,
  stretching,
}

/// Determines which set fields are meaningful for an exercise.
enum ExerciseTracking {
  /// Weight lifted for a number of reps (most strength work).
  weightAndReps,

  /// Reps only, e.g. push-ups.
  repsOnly,

  /// Time under tension, e.g. planks.
  duration,

  /// Distance plus elapsed time, e.g. running.
  distanceAndDuration,
}

/// Display helpers kept out of the entity so generated adapters stay stable.
extension ExerciseLibraryCategoryX on ExerciseLibraryCategory {
  String get label => switch (this) {
    ExerciseLibraryCategory.chest => 'Chest',
    ExerciseLibraryCategory.back => 'Back',
    ExerciseLibraryCategory.shoulders => 'Shoulders',
    ExerciseLibraryCategory.biceps => 'Biceps',
    ExerciseLibraryCategory.triceps => 'Triceps',
    ExerciseLibraryCategory.legs => 'Legs',
    ExerciseLibraryCategory.cardio => 'Cardio',
    ExerciseLibraryCategory.abs => 'Abs',
  };

  /// Short cue shown under the category name in the library UI.
  String get subtitle => switch (this) {
    ExerciseLibraryCategory.chest => 'Presses & flyes',
    ExerciseLibraryCategory.back => 'Pulls & rows',
    ExerciseLibraryCategory.shoulders => 'Presses & raises',
    ExerciseLibraryCategory.biceps => 'Curls & flexors',
    ExerciseLibraryCategory.triceps => 'Extensions & pushdowns',
    ExerciseLibraryCategory.legs => 'Squats, hinges & calves',
    ExerciseLibraryCategory.cardio => 'Conditioning & endurance',
    ExerciseLibraryCategory.abs => 'Core strength & stability',
  };
}

extension MuscleGroupX on MuscleGroup {
  String get label => switch (this) {
    MuscleGroup.chest => 'Chest',
    MuscleGroup.upperBack => 'Upper back',
    MuscleGroup.lats => 'Lats',
    MuscleGroup.shoulders => 'Shoulders',
    MuscleGroup.biceps => 'Biceps',
    MuscleGroup.triceps => 'Triceps',
    MuscleGroup.forearms => 'Forearms',
    MuscleGroup.core => 'Core',
    MuscleGroup.glutes => 'Glutes',
    MuscleGroup.quadriceps => 'Quads',
    MuscleGroup.hamstrings => 'Hamstrings',
    MuscleGroup.calves => 'Calves',
    MuscleGroup.fullBody => 'Full body',
    MuscleGroup.cardio => 'Cardio',
  };
}

extension EquipmentX on Equipment {
  String get label => switch (this) {
    Equipment.bodyweight => 'Bodyweight',
    Equipment.barbell => 'Barbell',
    Equipment.dumbbell => 'Dumbbell',
    Equipment.kettlebell => 'Kettlebell',
    Equipment.machine => 'Machine',
    Equipment.cable => 'Cable',
    Equipment.smithMachine => 'Smith machine',
    Equipment.resistanceBand => 'Resistance band',
    Equipment.medicineBall => 'Medicine ball',
    Equipment.pullUpBar => 'Pull-up bar',
    Equipment.bench => 'Bench',
    Equipment.cardioMachine => 'Cardio machine',
    Equipment.other => 'Other',
  };
}
