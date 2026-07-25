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
    this.secondaryMuscles = const <MuscleGroup>[],
    this.equipment = Equipment.bodyweight,
    this.category = ExerciseCategory.strength,
    this.tracking = ExerciseTracking.weightAndReps,
    this.instructions,
    this.imagePath,
    this.videoUrl,
    this.defaultRestSeconds = 90,
    this.isCustom = false,
    this.isFavorite = false,
    this.isArchived = false,
    this.updatedAt,
  });

  final String id;
  final String name;
  final MuscleGroup primaryMuscle;
  final List<MuscleGroup> secondaryMuscles;
  final Equipment equipment;
  final ExerciseCategory category;
  final ExerciseTracking tracking;
  final String? instructions;
  final String? imagePath;
  final String? videoUrl;
  final int defaultRestSeconds;
  final bool isCustom;
  final bool isFavorite;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Exercise copyWith({
    String? name,
    MuscleGroup? primaryMuscle,
    List<MuscleGroup>? secondaryMuscles,
    Equipment? equipment,
    ExerciseCategory? category,
    ExerciseTracking? tracking,
    String? instructions,
    String? imagePath,
    String? videoUrl,
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
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      equipment: equipment ?? this.equipment,
      category: category ?? this.category,
      tracking: tracking ?? this.tracking,
      instructions: instructions ?? this.instructions,
      imagePath: imagePath ?? this.imagePath,
      videoUrl: videoUrl ?? this.videoUrl,
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

  /// Case-insensitive match against name, muscles and equipment.
  bool matches(String query) {
    final term = query.trim().toLowerCase();
    if (term.isEmpty) return true;
    return name.toLowerCase().contains(term) ||
        equipment.name.toLowerCase().contains(term) ||
        allMuscles.any((muscle) => muscle.name.toLowerCase().contains(term));
  }
}
