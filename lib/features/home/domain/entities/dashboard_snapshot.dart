import 'package:gym_track/features/home/domain/entities/motivational_quote.dart';
import 'package:gym_track/features/progress/domain/entities/goal.dart';
import 'package:gym_track/features/progress/domain/entities/weight_entry.dart';
import 'package:gym_track/features/settings/domain/entities/app_settings.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_enums.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_plan.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_session.dart';

/// Aggregated view-model for the home dashboard.
class DashboardSnapshot {
  const DashboardSnapshot({
    required this.now,
    required this.settings,
    required this.greeting,
    required this.displayName,
    required this.streakDays,
    required this.weeklyCompleted,
    required this.weeklyGoal,
    required this.quote,
    this.todaySession,
    this.todayPlan,
    this.latestWeight,
    this.monthlyGoal,
  });

  final DateTime now;
  final AppSettings settings;
  final String greeting;
  final String displayName;
  final int streakDays;
  final int weeklyCompleted;
  final int weeklyGoal;
  final MotivationalQuote quote;
  final WorkoutSession? todaySession;
  final WorkoutPlan? todayPlan;
  final WeightEntry? latestWeight;
  final Goal? monthlyGoal;

  double get weeklyProgress {
    if (weeklyGoal <= 0) return 0;
    return (weeklyCompleted / weeklyGoal).clamp(0, 1).toDouble();
  }

  bool get weeklyGoalMet => weeklyCompleted >= weeklyGoal;

  /// Preferred workout to surface for today.
  TodayWorkout get todayWorkout {
    final session = todaySession;
    if (session != null) {
      return TodayWorkout.session(session);
    }
    final plan = todayPlan;
    if (plan != null) {
      return TodayWorkout.plan(plan);
    }
    return const TodayWorkout.empty();
  }
}

/// Discriminated "today's workout" slot on the dashboard.
sealed class TodayWorkout {
  const TodayWorkout();

  const factory TodayWorkout.session(WorkoutSession session) =
      TodaySessionWorkout;
  const factory TodayWorkout.plan(WorkoutPlan plan) = TodayPlanWorkout;
  const factory TodayWorkout.empty() = TodayEmptyWorkout;
}

final class TodaySessionWorkout extends TodayWorkout {
  const TodaySessionWorkout(this.session);
  final WorkoutSession session;

  String get title => session.name;

  String get statusLabel => switch (session.status) {
    WorkoutStatus.planned => 'Scheduled',
    WorkoutStatus.inProgress => 'In progress',
    WorkoutStatus.completed => 'Completed',
    WorkoutStatus.skipped => 'Skipped',
  };

  int get exerciseCount => session.exercises.length;
}

final class TodayPlanWorkout extends TodayWorkout {
  const TodayPlanWorkout(this.plan);
  final WorkoutPlan plan;

  String get title => plan.name;
  int get exerciseCount => plan.exercises.length;
  int get durationMinutes => plan.durationEstimateMinutes;
}

final class TodayEmptyWorkout extends TodayWorkout {
  const TodayEmptyWorkout();
}
