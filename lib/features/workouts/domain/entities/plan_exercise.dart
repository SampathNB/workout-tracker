/// A prescribed exercise inside a [WorkoutPlan], with target volume.
class PlanExercise {
  const PlanExercise({
    required this.id,
    required this.exerciseId,
    required this.exerciseName,
    required this.order,
    this.targetSets = 3,
    this.targetRepsMin = 8,
    this.targetRepsMax,
    this.targetWeightKg,
    this.targetDurationSeconds,
    this.restSeconds = 90,
    this.supersetGroup,
    this.note,
  });

  final String id;

  /// Reference to [Exercise.id] in the exercise library.
  final String exerciseId;

  /// Denormalized name so plans stay readable if the library changes.
  final String exerciseName;

  /// 0-based position within the plan.
  final int order;
  final int targetSets;
  final int targetRepsMin;

  /// Upper bound of a rep range; null means a fixed target.
  final int? targetRepsMax;
  final double? targetWeightKg;
  final int? targetDurationSeconds;
  final int restSeconds;

  /// Exercises sharing a group value are performed as a superset.
  final int? supersetGroup;
  final String? note;

  PlanExercise copyWith({
    String? exerciseId,
    String? exerciseName,
    int? order,
    int? targetSets,
    int? targetRepsMin,
    int? targetRepsMax,
    double? targetWeightKg,
    int? targetDurationSeconds,
    int? restSeconds,
    int? supersetGroup,
    String? note,
  }) {
    return PlanExercise(
      id: id,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseName: exerciseName ?? this.exerciseName,
      order: order ?? this.order,
      targetSets: targetSets ?? this.targetSets,
      targetRepsMin: targetRepsMin ?? this.targetRepsMin,
      targetRepsMax: targetRepsMax ?? this.targetRepsMax,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      targetDurationSeconds:
          targetDurationSeconds ?? this.targetDurationSeconds,
      restSeconds: restSeconds ?? this.restSeconds,
      supersetGroup: supersetGroup ?? this.supersetGroup,
      note: note ?? this.note,
    );
  }
}

extension PlanExerciseX on PlanExercise {
  /// `8` or `8–12` depending on whether a range is configured.
  String get repRangeLabel {
    final max = targetRepsMax;
    if (max == null || max == targetRepsMin) return '$targetRepsMin';
    return '$targetRepsMin–$max';
  }
}
