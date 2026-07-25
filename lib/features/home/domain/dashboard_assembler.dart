import 'package:gym_track/features/home/domain/entities/dashboard_snapshot.dart';
import 'package:gym_track/features/home/domain/entities/motivational_quote.dart';
import 'package:gym_track/features/progress/domain/entities/goal.dart';
import 'package:gym_track/features/progress/domain/entities/weight_entry.dart';
import 'package:gym_track/features/progress/domain/repositories/goal_repository.dart';
import 'package:gym_track/features/progress/domain/repositories/weight_entry_repository.dart';
import 'package:gym_track/features/settings/domain/entities/app_settings.dart';
import 'package:gym_track/features/settings/domain/repositories/settings_repository.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_enums.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_session.dart';
import 'package:gym_track/features/workouts/domain/repositories/workout_plan_repository.dart';
import 'package:gym_track/features/workouts/domain/repositories/workout_session_repository.dart';

/// Builds a [DashboardSnapshot] from feature repositories.
abstract final class DashboardAssembler {
  static Future<DashboardSnapshot> assemble({
    required WorkoutSessionRepository sessions,
    required WorkoutPlanRepository plans,
    required WeightEntryRepository weights,
    required GoalRepository goals,
    required SettingsRepository settingsRepo,
    DateTime? now,
  }) async {
    final clock = now ?? DateTime.now();
    final settings = await settingsRepo.get();
    final todaySessions = await sessions.getForDay(clock);
    final weekSessions = await sessions.getBetween(
      startOfWeek(clock, settings.firstDayOfWeek),
      clock,
    );
    final completed = await sessions.getCompleted();
    final scheduledPlans = await plans.getScheduledFor(clock);
    final latestWeight = await weights.getLatest();
    final activeGoals = await goals.getActive();

    return DashboardSnapshot(
      now: clock,
      settings: settings,
      greeting: greetingFor(clock),
      displayName: _displayName(settings),
      streakDays: computeStreak(completed, clock),
      weeklyCompleted: weekSessions.where((s) => s.isCompleted).length,
      weeklyGoal: settings.weeklyWorkoutGoal,
      quote: MotivationalQuotes.forDate(clock),
      todaySession: pickTodaySession(todaySessions),
      todayPlan: scheduledPlans.isEmpty ? null : scheduledPlans.first,
      latestWeight: latestWeight,
      monthlyGoal: pickMonthlyGoal(activeGoals, clock),
    );
  }

  static String greetingFor(DateTime now) {
    final hour = now.hour;
    if (hour < 5) return 'Burning the midnight oil';
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    if (hour < 21) return 'Good evening';
    return 'Good night';
  }

  static String _displayName(AppSettings settings) {
    final name = settings.displayName?.trim();
    if (name == null || name.isEmpty) return 'Athlete';
    return name.split(RegExp(r'\s+')).first;
  }

  /// Start of the calendar week containing [date], using ISO weekday
  /// [firstDayOfWeek] (1 = Monday … 7 = Sunday).
  static DateTime startOfWeek(DateTime date, int firstDayOfWeek) {
    final day = DateTime(date.year, date.month, date.day);
    final offset = (day.weekday - firstDayOfWeek + 7) % 7;
    return day.subtract(Duration(days: offset));
  }

  /// Consecutive completed-workout days ending today (or yesterday if today
  /// is still open).
  static int computeStreak(
    Iterable<WorkoutSession> completedSessions,
    DateTime now,
  ) {
    final days = <DateTime>{
      for (final session in completedSessions)
        if (session.isCompleted) session.day,
    };
    if (days.isEmpty) return 0;

    var cursor = DateTime(now.year, now.month, now.day);
    if (!days.contains(cursor)) {
      cursor = cursor.subtract(const Duration(days: 1));
    }

    var streak = 0;
    while (days.contains(cursor)) {
      streak += 1;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  /// Prefers an in-progress session, then planned, then completed.
  static WorkoutSession? pickTodaySession(List<WorkoutSession> today) {
    if (today.isEmpty) return null;
    WorkoutSession? match(WorkoutStatus status) {
      for (final session in today) {
        if (session.status == status) return session;
      }
      return null;
    }

    return match(WorkoutStatus.inProgress) ??
        match(WorkoutStatus.planned) ??
        match(WorkoutStatus.completed) ??
        today.first;
  }

  /// Prefers a goal due this month; otherwise the soonest active goal.
  static Goal? pickMonthlyGoal(List<Goal> active, DateTime now) {
    if (active.isEmpty) return null;
    final inMonth = active.where((goal) {
      final target = goal.targetDate;
      return target != null &&
          target.year == now.year &&
          target.month == now.month;
    }).toList();
    if (inMonth.isNotEmpty) return inMonth.first;
    return active.first;
  }

  /// Formats [weightKg] using the unit system in [settings].
  static String formatWeight(WeightEntry entry, AppSettings settings) {
    if (settings.usesMetric) {
      return '${_trim(entry.weightKg)} kg';
    }
    return '${_trim(entry.weightLb)} lb';
  }

  static String _trim(double value) {
    if (value == value.roundToDouble()) return value.toStringAsFixed(0);
    return value.toStringAsFixed(1);
  }
}
