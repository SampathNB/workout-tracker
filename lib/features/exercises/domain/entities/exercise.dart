import 'package:gym_track/features/exercises/domain/entities/exercise_enums.dart';

/// A movement in the exercise library, either bundled or user-created.
///
/// Persisted with a generated Hive adapter (see `lib/hive/hive_adapters.dart`),
/// so this class intentionally stays free of persistence annotations.
class Exercise {
  const Exercise({
    required this.id,
    required this.name,
    required this.primaryMuscle,
    required this.createdAt,
    this.libraryCategory = ExerciseLibraryCategory.chest,
    this.secondaryMuscles = const <MuscleGroup>[],
    this.equipment = Equipment.bodyweight,
    this.category = ExerciseCategory.strength,
    this.tracking = ExerciseTracking.weightAndReps,
    this.instructions,
    this.imagePath,
    this.videoUrl,
    this.recommendedSets = 3,
    this.recommendedRepsMin = 8,
    this.recommendedRepsMax = 12,
    this.recommendedDurationSeconds,
    this.recommendedDurationMaxSeconds,
    this.defaultRestSeconds = 90,
    this.isCustom = false,
    this.isFavorite = false,
    this.isArchived = false,
    this.updatedAt,
  });

  final String id;
  final String name;
  final MuscleGroup primaryMuscle;

  /// Browse category in the default workout library.
  final ExerciseLibraryCategory libraryCategory;
  final List<MuscleGroup> secondaryMuscles;
  final Equipment equipment;
  final ExerciseCategory category;
  final ExerciseTracking tracking;
  final String? instructions;
  final String? imagePath;
  final String? videoUrl;

  /// Suggested working sets when adding this exercise to a session/plan.
  final int recommendedSets;

  /// Lower bound of the suggested rep range (ignored when duration-based).
  final int recommendedRepsMin;

  /// Upper bound of the suggested rep range; null means a fixed target.
  final int? recommendedRepsMax;

  /// Lower (or sole) duration target in seconds for timed work / cardio.
  final int? recommendedDurationSeconds;

  /// Optional upper duration bound for timed ranges (e.g. 30–60 s planks).
  final int? recommendedDurationMaxSeconds;
  final int defaultRestSeconds;
  final bool isCustom;
  final bool isFavorite;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Exercise copyWith({
    String? name,
    MuscleGroup? primaryMuscle,
    ExerciseLibraryCategory? libraryCategory,
    List<MuscleGroup>? secondaryMuscles,
    Equipment? equipment,
    ExerciseCategory? category,
    ExerciseTracking? tracking,
    String? instructions,
    String? imagePath,
    String? videoUrl,
    int? recommendedSets,
    int? recommendedRepsMin,
    int? recommendedRepsMax,
    int? recommendedDurationSeconds,
    int? recommendedDurationMaxSeconds,
    int? defaultRestSeconds,
    bool? isCustom,
    bool? isFavorite,
    bool? isArchived,
    DateTime? updatedAt,
  }) {
    return Exercise(
      id: id,
      name: name ?? this.name,
      primaryMuscle: primaryMuscle ?? this.primaryMuscle,
      libraryCategory: libraryCategory ?? this.libraryCategory,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      equipment: equipment ?? this.equipment,
      category: category ?? this.category,
      tracking: tracking ?? this.tracking,
      instructions: instructions ?? this.instructions,
      imagePath: imagePath ?? this.imagePath,
      videoUrl: videoUrl ?? this.videoUrl,
      recommendedSets: recommendedSets ?? this.recommendedSets,
      recommendedRepsMin: recommendedRepsMin ?? this.recommendedRepsMin,
      recommendedRepsMax: recommendedRepsMax ?? this.recommendedRepsMax,
      recommendedDurationSeconds:
          recommendedDurationSeconds ?? this.recommendedDurationSeconds,
      recommendedDurationMaxSeconds: recommendedDurationMaxSeconds ??
          this.recommendedDurationMaxSeconds,
      defaultRestSeconds: defaultRestSeconds ?? this.defaultRestSeconds,
      isCustom: isCustom ?? this.isCustom,
      isFavorite: isFavorite ?? this.isFavorite,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

extension ExerciseX on Exercise {
  /// All muscles worked, primary first.
  List<MuscleGroup> get allMuscles => <MuscleGroup>[
    primaryMuscle,
    ...secondaryMuscles.where((muscle) => muscle != primaryMuscle),
  ];

  bool get tracksWeight => tracking == ExerciseTracking.weightAndReps;

  bool get tracksReps =>
      tracking == ExerciseTracking.weightAndReps ||
      tracking == ExerciseTracking.repsOnly;

  bool get isDurationBased =>
      tracking == ExerciseTracking.duration ||
      tracking == ExerciseTracking.distanceAndDuration;

  /// `3×8–12`, `3×10`, or `3×30–60s` depending on tracking type.
  String get prescriptionLabel {
    if (isDurationBased) {
      final min = recommendedDurationSeconds;
      final max = recommendedDurationMaxSeconds;
      if (min == null) return '$recommendedSets sets';
      final range = max == null || max == min
          ? _formatDuration(min)
          : '${_formatDuration(min)}–${_formatDuration(max)}';
      return '$recommendedSets×$range';
    }
    final max = recommendedRepsMax;
    final reps = max == null || max == recommendedRepsMin
        ? '$recommendedRepsMin'
        : '$recommendedRepsMin–$max';
    return '$recommendedSets×$reps';
  }

  /// Case-insensitive match against name, muscles, category and equipment.
  bool matches(String query) {
    final term = query.trim().toLowerCase();
    if (term.isEmpty) return true;
    return name.toLowerCase().contains(term) ||
        equipment.name.toLowerCase().contains(term) ||
        libraryCategory.label.toLowerCase().contains(term) ||
        allMuscles.any((muscle) => muscle.name.toLowerCase().contains(term));
  }

  static String _formatDuration(int seconds) {
    if (seconds >= 60 && seconds % 60 == 0) {
      return '${seconds ~/ 60}min';
    }
    return '${seconds}s';
  }
}
