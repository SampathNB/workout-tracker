import 'package:gym_track/features/workouts/domain/entities/exercise_set.dart';
import 'package:gym_track/features/workouts/domain/entities/session_exercise.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_enums.dart';

/// A workout performed (or scheduled) by the user on a given day.
class WorkoutSession {
  const WorkoutSession({
    required this.id,
    required this.name,
    required this.startedAt,
    this.status = WorkoutStatus.planned,
    this.planId,
    this.exercises = const <SessionExercise>[],
    this.completedAt,
    this.durationSeconds,
    this.perceivedExertion,
    this.caloriesBurned,
    this.bodyWeightKg,
    this.note,
    this.updatedAt,
  });

  final String id;
  final String name;

  /// Scheduled or actual start time; also the calendar day of the session.
  final DateTime startedAt;
  final WorkoutStatus status;

  /// Reference to the [WorkoutPlan] this session was generated from, if any.
  final String? planId;
  final List<SessionExercise> exercises;
  final DateTime? completedAt;

  /// Elapsed training time, which may exclude long pauses.
  final int? durationSeconds;

  /// Session RPE, 1–10.
  final int? perceivedExertion;
  final int? caloriesBurned;
  final double? bodyWeightKg;
  final String? note;
  final DateTime? updatedAt;

  WorkoutSession copyWith({
    String? name,
    DateTime? startedAt,
    WorkoutStatus? status,
    String? planId,
    List<SessionExercise>? exercises,
    DateTime? completedAt,
    int? durationSeconds,
    int? perceivedExertion,
    int? caloriesBurned,
    double? bodyWeightKg,
    String? note,
    DateTime? updatedAt,
  }) {
    return WorkoutSession(
      id: id,
      name: name ?? this.name,
      startedAt: startedAt ?? this.startedAt,
      status: status ?? this.status,
      planId: planId ?? this.planId,
      exercises: exercises ?? this.exercises,
      completedAt: completedAt ?? this.completedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      perceivedExertion: perceivedExertion ?? this.perceivedExertion,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      bodyWeightKg: bodyWeightKg ?? this.bodyWeightKg,
      note: note ?? this.note,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

extension WorkoutSessionX on WorkoutSession {
  bool get isCompleted => status == WorkoutStatus.completed;

  bool get isInProgress => status == WorkoutStatus.inProgress;

  /// Calendar day of the session, normalized to midnight local time.
  DateTime get day =>
      DateTime(startedAt.year, startedAt.month, startedAt.day);

  List<SessionExercise> get orderedExercises =>
      List<SessionExercise>.of(exercises)
        ..sort((a, b) => a.order.compareTo(b.order));

  Iterable<ExerciseSet> get allSets =>
      exercises.expand((exercise) => exercise.sets);

  int get totalSets => allSets.length;

  int get completedSetCount => allSets.where((set) => set.isCompleted).length;

  /// Total tonnage in kilograms across completed working sets.
  double get totalVolumeKg =>
      exercises.fold(0, (total, exercise) => total + exercise.volumeKg);

  Duration? get duration {
    if (durationSeconds != null) return Duration(seconds: durationSeconds!);
    final end = completedAt;
    if (end == null) return null;
    return end.difference(startedAt);
  }

  double get completionRatio {
    if (totalSets == 0) return 0;
    return completedSetCount / totalSets;
  }
}
