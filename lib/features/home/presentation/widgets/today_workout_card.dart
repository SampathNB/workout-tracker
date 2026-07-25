import 'package:flutter/material.dart';
import 'package:gym_track/app/theme/app_accents.dart';
import 'package:gym_track/app/theme/app_radius.dart';
import 'package:gym_track/app/theme/app_spacing.dart';
import 'package:gym_track/app/theme/app_typography.dart';
import 'package:gym_track/core/widgets/app_button.dart';
import 'package:gym_track/core/widgets/app_card.dart';
import 'package:gym_track/features/home/domain/entities/dashboard_snapshot.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_enums.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_plan.dart';
import 'package:gym_track/features/workouts/domain/entities/workout_session.dart';

/// Hero card for today's session or scheduled plan.
class TodayWorkoutCard extends StatelessWidget {
  const TodayWorkoutCard({
    required this.workout,
    required this.onStart,
    required this.onContinue,
    required this.onView,
    super.key,
  });

  final TodayWorkout workout;
  final VoidCallback onStart;
  final VoidCallback onContinue;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    return switch (workout) {
      TodaySessionWorkout(:final session) => _SessionCard(
        sessionTitle: session.name,
        status: session.status,
        exerciseCount: session.exercises.length,
        completedSets: session.completedSetCount,
        totalSets: session.totalSets,
        onStart: onStart,
        onContinue: onContinue,
        onView: onView,
      ),
      TodayPlanWorkout(:final plan) => _PlanCard(
        title: plan.name,
        exerciseCount: plan.exercises.length,
        durationMinutes: plan.durationEstimateMinutes,
        onStart: onStart,
      ),
      TodayEmptyWorkout() => _EmptyCard(onStart: onStart),
    };
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({
    required this.sessionTitle,
    required this.status,
    required this.exerciseCount,
    required this.completedSets,
    required this.totalSets,
    required this.onStart,
    required this.onContinue,
    required this.onView,
  });

  final String sessionTitle;
  final WorkoutStatus status;
  final int exerciseCount;
  final int completedSets;
  final int totalSets;
  final VoidCallback onStart;
  final VoidCallback onContinue;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    final accents = context.accents;
    final isDone = status == WorkoutStatus.completed;
    final isLive = status == WorkoutStatus.inProgress;
    final statusLabel = switch (status) {
      WorkoutStatus.planned => 'Scheduled today',
      WorkoutStatus.inProgress => 'In progress',
      WorkoutStatus.completed => 'Completed today',
      WorkoutStatus.skipped => 'Skipped',
    };

    return AppCard(
      variant: AppCardVariant.brand,
      glow: isLive,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "TODAY'S WORKOUT",
                style: AppTypography.overline(context).copyWith(
                  color: Colors.white.withValues(alpha: 0.65),
                ),
              ),
              const Spacer(),
              _StatusPill(
                label: statusLabel,
                background: isDone
                    ? accents.success
                    : isLive
                    ? accents.volt
                    : Colors.white.withValues(alpha: 0.14),
                foreground: isDone
                    ? accents.onSuccess
                    : isLive
                    ? accents.onVolt
                    : Colors.white,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            sessionTitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            exerciseCount == 0
                ? 'No exercises yet'
                : '$exerciseCount exercises · $completedSets/$totalSets sets',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          if (isLive && totalSets > 0) ...[
            const SizedBox(height: AppSpacing.lg),
            ClipRRect(
              borderRadius: AppRadius.allPill,
              child: LinearProgressIndicator(
                value: completedSets / totalSets,
                minHeight: 6,
                backgroundColor: Colors.white.withValues(alpha: 0.12),
                color: accents.volt,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          if (isLive)
            AppButton.expanded(
              label: 'Continue workout',
              variant: AppButtonVariant.volt,
              icon: Icons.play_arrow_rounded,
              onPressed: onContinue,
            )
          else if (isDone)
            AppButton.expanded(
              label: 'View summary',
              variant: AppButtonVariant.secondary,
              icon: Icons.insights_rounded,
              onPressed: onView,
            )
          else
            AppButton.expanded(
              label: 'Start workout',
              variant: AppButtonVariant.volt,
              icon: Icons.fitness_center_rounded,
              onPressed: onStart,
            ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.exerciseCount,
    required this.durationMinutes,
    required this.onStart,
  });

  final String title;
  final int exerciseCount;
  final int durationMinutes;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: AppCardVariant.brand,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TODAY'S WORKOUT",
            style: AppTypography.overline(context).copyWith(
              color: Colors.white.withValues(alpha: 0.65),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '$exerciseCount exercises · ~$durationMinutes min',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton.expanded(
            label: 'Start from plan',
            variant: AppButtonVariant.volt,
            icon: Icons.play_arrow_rounded,
            onPressed: onStart,
          ),
        ],
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: AppCardVariant.brand,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TODAY'S WORKOUT",
            style: AppTypography.overline(context).copyWith(
              color: Colors.white.withValues(alpha: 0.65),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Rest day or free training?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Nothing scheduled — start a session whenever you’re ready.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton.expanded(
            label: 'Start workout',
            variant: AppButtonVariant.volt,
            icon: Icons.fitness_center_rounded,
            onPressed: onStart,
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.allPill,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
