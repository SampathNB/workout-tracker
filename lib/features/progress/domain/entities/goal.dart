import 'package:gym_track/features/progress/domain/entities/progress_enums.dart';

/// A measurable target the user is working toward.
class Goal {
  const Goal({
    required this.id,
    required this.title,
    required this.type,
    required this.startValue,
    required this.targetValue,
    required this.startedAt,
    this.currentValue,
    this.unit = 'kg',
    this.direction = GoalDirection.increase,
    this.status = GoalStatus.active,
    this.description,
    this.targetDate,
    this.achievedAt,
    this.exerciseId,
    this.updatedAt,
  });

  final String id;
  final String title;
  final GoalType type;

  /// Baseline measurement when the goal was created.
  final double startValue;
  final double targetValue;

  /// Latest measurement; falls back to [startValue] when null.
  final double? currentValue;

  /// Unit label for the tracked values, e.g. `kg`, `%`, `workouts`.
  final String unit;
  final GoalDirection direction;
  final GoalStatus status;
  final String? description;
  final DateTime startedAt;
  final DateTime? targetDate;
  final DateTime? achievedAt;

  /// Reference to [Exercise.id] for strength goals.
  final String? exerciseId;
  final DateTime? updatedAt;

  Goal copyWith({
    String? title,
    GoalType? type,
    double? startValue,
    double? targetValue,
    double? currentValue,
    String? unit,
    GoalDirection? direction,
    GoalStatus? status,
    String? description,
    DateTime? startedAt,
    DateTime? targetDate,
    DateTime? achievedAt,
    String? exerciseId,
    DateTime? updatedAt,
  }) {
    return Goal(
      id: id,
      title: title ?? this.title,
      type: type ?? this.type,
      startValue: startValue ?? this.startValue,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      unit: unit ?? this.unit,
      direction: direction ?? this.direction,
      status: status ?? this.status,
      description: description ?? this.description,
      startedAt: startedAt ?? this.startedAt,
      targetDate: targetDate ?? this.targetDate,
      achievedAt: achievedAt ?? this.achievedAt,
      exerciseId: exerciseId ?? this.exerciseId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

extension GoalX on Goal {
  double get value => currentValue ?? startValue;

  bool get isActive => status == GoalStatus.active;

  bool get isAchieved => status == GoalStatus.achieved;

  /// Completion in the 0–1 range, clamped at both ends.
  double get progress {
    final span = targetValue - startValue;
    if (span == 0) return value == targetValue ? 1 : 0;
    final ratio = (value - startValue) / span;
    return ratio.clamp(0, 1).toDouble();
  }

  /// True when the current value has reached the target in [direction].
  bool get hasReachedTarget => direction == GoalDirection.increase
      ? value >= targetValue
      : value <= targetValue;

  double get remaining => (targetValue - value).abs();

  bool get isOverdue {
    final deadline = targetDate;
    if (deadline == null || isAchieved) return false;
    return DateTime.now().isAfter(deadline);
  }

  int? get daysRemaining {
    final deadline = targetDate;
    if (deadline == null) return null;
    return deadline.difference(DateTime.now()).inDays;
  }
}
