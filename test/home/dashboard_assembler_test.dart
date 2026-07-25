import 'package:flutter_test/flutter_test.dart';
import 'package:gym_track/features/home/domain/dashboard_assembler.dart';
import 'package:gym_track/features/home/domain/entities/motivational_quote.dart';
import 'package:gym_track/features/progress/domain/entities/goal.dart';
import 'package:gym_track/features/progress/domain/entities/progress_enums.dart';
import 'package:gym_track/features/progress/domain/entities/weight_entry.dart';
import 'package:gym_track/features/settings/domain/entities/app_settings.dart';
import 'package:gym_track/features/settings/domain/entities/settings_enums.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_enums.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_session.dart';

void main() {
  group('DashboardAssembler', () {
    test('greeting changes by time of day', () {
      expect(
        DashboardAssembler.greetingFor(DateTime(2026, 7, 25, 8)),
        'Good morning',
      );
      expect(
        DashboardAssembler.greetingFor(DateTime(2026, 7, 25, 14)),
        'Good afternoon',
      );
      expect(
        DashboardAssembler.greetingFor(DateTime(2026, 7, 25, 19)),
        'Good evening',
      );
    });

    test('computes consecutive workout streak', () {
      final now = DateTime(2026, 7, 25, 12);
      final sessions = [
        _completed(DateTime(2026, 7, 25)),
        _completed(DateTime(2026, 7, 24)),
        _completed(DateTime(2026, 7, 23)),
        _completed(DateTime(2026, 7, 21)), // gap
      ];

      expect(DashboardAssembler.computeStreak(sessions, now), 3);
    });

    test('keeps streak alive when today is not yet trained', () {
      final now = DateTime(2026, 7, 25, 9);
      final sessions = [
        _completed(DateTime(2026, 7, 24)),
        _completed(DateTime(2026, 7, 23)),
      ];

      expect(DashboardAssembler.computeStreak(sessions, now), 2);
    });

    test('startOfWeek respects firstDayOfWeek', () {
      // Saturday Jul 25 2026 — week starting Monday is Jul 20.
      final saturday = DateTime(2026, 7, 25);
      expect(
        DashboardAssembler.startOfWeek(saturday, 1),
        DateTime(2026, 7, 20),
      );
      // Week starting Sunday is Jul 19.
      expect(
        DashboardAssembler.startOfWeek(saturday, 7),
        DateTime(2026, 7, 19),
      );
    });

    test('prefers in-progress session for today', () {
      final planned = WorkoutSession(
        id: '1',
        name: 'Planned',
        startedAt: DateTime(2026, 7, 25, 8),
      );
      final live = WorkoutSession(
        id: '2',
        name: 'Live',
        startedAt: DateTime(2026, 7, 25, 9),
        status: WorkoutStatus.inProgress,
      );

      expect(
        DashboardAssembler.pickTodaySession([planned, live])?.id,
        '2',
      );
    });

    test('picks monthly goal due this month first', () {
      final now = DateTime(2026, 7, 15);
      final later = Goal(
        id: 'later',
        title: 'Later',
        type: GoalType.custom,
        startValue: 0,
        targetValue: 10,
        startedAt: now,
        targetDate: DateTime(2026, 12, 1),
      );
      final thisMonth = Goal(
        id: 'month',
        title: 'July goal',
        type: GoalType.bodyWeight,
        startValue: 80,
        targetValue: 75,
        startedAt: now,
        direction: GoalDirection.decrease,
        targetDate: DateTime(2026, 7, 31),
      );

      expect(
        DashboardAssembler.pickMonthlyGoal([later, thisMonth], now)?.id,
        'month',
      );
    });

    test('formats weight with unit system', () {
      final entry = WeightEntry(
        id: 'w1',
        weightKg: 80,
        recordedAt: DateTime(2026, 7, 25),
      );
      expect(
        DashboardAssembler.formatWeight(
          entry,
          const AppSettings(),
        ),
        '80 kg',
      );
      expect(
        DashboardAssembler.formatWeight(
          entry,
          const AppSettings(unitSystem: UnitSystem.imperial),
        ),
        contains('lb'),
      );
    });

    test('quote is stable for a given day', () {
      final a = MotivationalQuotes.forDate(DateTime(2026, 7, 25));
      final b = MotivationalQuotes.forDate(DateTime(2026, 7, 25, 23));
      final c = MotivationalQuotes.forDate(DateTime(2026, 7, 26));
      expect(a.text, b.text);
      expect(a.text, isNot(c.text));
    });
  });
}

WorkoutSession _completed(DateTime day) => WorkoutSession(
  id: 's-${day.millisecondsSinceEpoch}',
  name: 'Session',
  startedAt: day,
  status: WorkoutStatus.completed,
  completedAt: day.add(const Duration(hours: 1)),
);
