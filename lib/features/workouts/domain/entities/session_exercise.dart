import 'package:gym_track/features/workouts/domain/entities/exercise_set.dart';

/// One exercise performed during a workout session, with its logged sets.
class SessionExercise {
  const SessionExercise({
    required this.id,
    required this.exerciseId,
    required this.exerciseName,
    required this.order,
    this.sets = const <ExerciseSet>[],
    this.restSeconds,
    this.supersetGroup,
    this.note,
  });

  final String id;

  /// Reference to [Exercise.id] in the exercise library.
  final String exerciseId;

  /// Denormalized name so history stays readable if the library changes.
  final String exerciseName;

  /// 0-based position within the session.
  final int order;
  final List<ExerciseSet> sets;
  final int? restSeconds;

  /// Exercises sharing a group value are performed as a superset.
  final int? supersetGroup;
  final String? note;

  SessionExercise copyWith({
    String? exerciseId,
    String? exerciseName,
    int? order,
    List<ExerciseSet>? sets,
    int? restSeconds,
    int? supersetGroup,
    String? note,
  }) {
    return SessionExercise(
      id: id,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseName: exerciseName ?? this.exerciseName,
      order: order ?? this.order,
      sets: sets ?? this.sets,
      restSeconds: restSeconds ?? this.restSeconds,
      supersetGroup: supersetGroup ?? this.supersetGroup,
      note: note ?? this.note,
    );
  }
}

extension SessionExerciseX on SessionExercise {
  List<ExerciseSet> get completedSets =>
      sets.where((set) => set.isCompleted).toList(growable: false);

  int get completedSetCount => completedSets.length;

  double get volumeKg =>
      completedSets.fold(0, (total, set) => total + set.volumeKg);

  double? get heaviestWeightKg {
    final weights = completedSets
        .where((set) => set.isWorkingSet && set.weightKg > 0)
        .map((set) => set.weightKg);
    if (weights.isEmpty) return null;
    return weights.reduce((a, b) => a > b ? a : b);
  }

  double? get estimatedOneRepMax {
    final estimates = completedSets
        .map((set) => set.estimatedOneRepMax)
        .whereType<double>();
    if (estimates.isEmpty) return null;
    return estimates.reduce((a, b) => a > b ? a : b);
  }

  bool get isFinished => sets.isNotEmpty && sets.every((set) => set.isCompleted);
}
