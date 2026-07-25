import 'package:gym_track/features/workouts/domain/entities/plan_exercise.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_enums.dart';

/// A reusable workout template the user can schedule and start sessions from.
class WorkoutPlan {
  const WorkoutPlan({
    required this.id,
    required this.name,
    required this.createdAt,
    this.description,
    this.difficulty = PlanDifficulty.beginner,
    this.exercises = const <PlanExercise>[],
    this.scheduledWeekdays = const <int>[],
    this.estimatedDurationMinutes,
    this.tags = const <String>[],
    this.colorHex,
    this.isActive = true,
    this.isArchived = false,
    this.lastPerformedAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String? description;
  final PlanDifficulty difficulty;
  final List<PlanExercise> exercises;

  /// ISO weekdays this plan is scheduled on (1 = Monday … 7 = Sunday).
  final List<int> scheduledWeekdays;
  final int? estimatedDurationMinutes;
  final List<String> tags;

  /// Optional accent colour as `RRGGBB` or `AARRGGBB`.
  final String? colorHex;
  final bool isActive;
  final bool isArchived;
  final DateTime? lastPerformedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  WorkoutPlan copyWith({
    String? name,
    String? description,
    PlanDifficulty? difficulty,
    List<PlanExercise>? exercises,
    List<int>? scheduledWeekdays,
    int? estimatedDurationMinutes,
    List<String>? tags,
    String? colorHex,
    bool? isActive,
    bool? isArchived,
    DateTime? lastPerformedAt,
    DateTime? updatedAt,
  }) {
    return WorkoutPlan(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      difficulty: difficulty ?? this.difficulty,
      exercises: exercises ?? this.exercises,
      scheduledWeekdays: scheduledWeekdays ?? this.scheduledWeekdays,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      tags: tags ?? this.tags,
      colorHex: colorHex ?? this.colorHex,
      isActive: isActive ?? this.isActive,
      isArchived: isArchived ?? this.isArchived,
      lastPerformedAt: lastPerformedAt ?? this.lastPerformedAt,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

extension WorkoutPlanX on WorkoutPlan {
  List<PlanExercise> get orderedExercises => List<PlanExercise>.of(exercises)
    ..sort((a, b) => a.order.compareTo(b.order));

  int get totalSets =>
      exercises.fold(0, (total, exercise) => total + exercise.targetSets);

  bool isScheduledOn(DateTime date) =>
      scheduledWeekdays.contains(date.weekday);

  /// Rough duration estimate from sets and rest when none was configured.
  int get durationEstimateMinutes {
    final configured = estimatedDurationMinutes;
    if (configured != null) return configured;
    final restSeconds = exercises.fold<int>(
      0,
      (total, exercise) => total + exercise.restSeconds * exercise.targetSets,
    );
    // Assume ~45 seconds of work per set on top of prescribed rest.
    return ((restSeconds + totalSets * 45) / 60).ceil();
  }
}
