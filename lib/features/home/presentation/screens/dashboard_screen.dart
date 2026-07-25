import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_track/app/router/route_names.dart';
import 'package:gym_track/app/theme/app_spacing.dart';
import 'package:gym_track/core/widgets/responsive_layout.dart';
import 'package:gym_track/features/home/domain/entities/dashboard_snapshot.dart';
import 'package:gym_track/features/home/presentation/providers/dashboard_provider.dart';
import 'package:gym_track/features/home/presentation/widgets/dashboard_greeting_header.dart';
import 'package:gym_track/features/home/presentation/widgets/dashboard_stat_cards.dart';
import 'package:gym_track/features/home/presentation/widgets/motivational_quote_card.dart';
import 'package:gym_track/features/home/presentation/widgets/quick_actions_row.dart';
import 'package:gym_track/features/home/presentation/widgets/today_workout_card.dart';
import 'package:gym_track/features/home/presentation/widgets/weight_and_goal_cards.dart';

/// Home tab — greeting, today’s workout, streak, weekly progress, weight,
/// monthly goal, daily quote, and quick actions.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSnapshot = ref.watch(dashboardSnapshotProvider);

    return Scaffold(
      body: SafeArea(
        child: asyncSnapshot.when(
          loading: () => const Center(
            child: Text('Loading dashboard…'),
          ),
          error: (error, _) => _DashboardError(
            message: error.toString(),
            onRetry: () => ref.invalidate(dashboardSnapshotProvider),
          ),
          data: (snapshot) => RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(dashboardSnapshotProvider);
              await ref.read(dashboardSnapshotProvider.future);
            },
            child: _DashboardBody(snapshot: snapshot),
          ),
        ),
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({required this.snapshot});

  final DashboardSnapshot snapshot;

  void _goWorkout(BuildContext context) => context.go(AppRoutes.workout);

  void _goProgress(BuildContext context) => context.go(AppRoutes.progress);

  void _goCalendar(BuildContext context) => context.go(AppRoutes.calendar);

  void _openSession(BuildContext context, String id) =>
      context.go(AppRoutes.workoutDetailPath(id));

  @override
  Widget build(BuildContext context) {
    final today = snapshot.todayWorkout;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            0,
            AppSpacing.lg,
            0,
            AppSpacing.xxxl + bottomInset,
          ),
          sliver: SliverToBoxAdapter(
            child: ResponsiveContent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DashboardGreetingHeader(
                    greeting: snapshot.greeting,
                    displayName: snapshot.displayName,
                    now: snapshot.now,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  TodayWorkoutCard(
                    workout: today,
                    onStart: () => _goWorkout(context),
                    onContinue: () {
                      if (today case TodaySessionWorkout(:final session)) {
                        _openSession(context, session.id);
                      } else {
                        _goWorkout(context);
                      }
                    },
                    onView: () {
                      if (today case TodaySessionWorkout(:final session)) {
                        _openSession(context, session.id);
                      } else {
                        _goProgress(context);
                      }
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: StreakStatCard(
                          streakDays: snapshot.streakDays,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: WeeklyProgressCard(
                          completed: snapshot.weeklyCompleted,
                          goal: snapshot.weeklyGoal,
                          progress: snapshot.weeklyProgress,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CurrentWeightCard(
                          entry: snapshot.latestWeight,
                          settings: snapshot.settings,
                          onLogWeight: () => _goProgress(context),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: MonthlyGoalCard(
                          goal: snapshot.monthlyGoal,
                          onOpenGoals: () => _goProgress(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  MotivationalQuoteCard(quote: snapshot.quote),
                  const SizedBox(height: AppSpacing.xxl),
                  QuickActionsRow(
                    onStartWorkout: () => _goWorkout(context),
                    onLogWeight: () => _goProgress(context),
                    onOpenCalendar: () => _goCalendar(context),
                    onOpenProgress: () => _goProgress(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DashboardError extends StatelessWidget {
  const _DashboardError({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.screen,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Couldn’t load dashboard',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
