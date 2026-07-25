import 'package:gym_track/features/workouts/domain/entities/workout_enums.dart';

/// A single logged set inside a [SessionExercise].
class ExerciseSet {
  const ExerciseSet({
    required this.id,
    required this.setNumber,
    this.type = SetType.normal,
    this.reps = 0,
    this.weightKg = 0,
    this.durationSeconds,
    this.distanceMeters,
    this.restSeconds,
    this.rpe,
    this.isCompleted = false,
    this.completedAt,
    this.note,
  });

  final String id;

  /// 1-based position within the exercise.
  final int setNumber;
  final SetType type;
  final int reps;
  final double weightKg;
  final int? durationSeconds;
  final double? distanceMeters;
  final int? restSeconds;

  /// Rate of perceived exertion, 1–10.
  final double? rpe;
  final bool isCompleted;
  final DateTime? completedAt;
  final String? note;

  ExerciseSet copyWith({
    int? setNumber,
    SetType? type,
    int? reps,
    double? weightKg,
    int? durationSeconds,
    double? distanceMeters,
    int? restSeconds,
    double? rpe,
    bool? isCompleted,
    DateTime? completedAt,
    String? note,
  }) {
    return ExerciseSet(
      id: id,
      setNumber: setNumber ?? this.setNumber,
      type: type ?? this.type,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      restSeconds: restSeconds ?? this.restSeconds,
      rpe: rpe ?? this.rpe,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      note: note ?? this.note,
    );
  }
}

extension ExerciseSetX on ExerciseSet {
  /// Load × reps, excluding warm-ups which do not count toward volume.
  double get volumeKg =>
      type == SetType.warmUp ? 0 : weightKg * reps.toDouble();

  /// Estimated one-rep max (Epley formula), null when not applicable.
  double? get estimatedOneRepMax {
    if (weightKg <= 0 || reps <= 0) return null;
    return weightKg * (1 + reps / 30);
  }

  bool get isWorkingSet => type != SetType.warmUp && type != SetType.cooldown;
}
