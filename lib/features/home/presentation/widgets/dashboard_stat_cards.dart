import 'package:flutter/material.dart';
import 'package:gym_track/app/theme/app_accents.dart';
import 'package:gym_track/app/theme/app_radius.dart';
import 'package:gym_track/app/theme/app_spacing.dart';
import 'package:gym_track/app/theme/app_typography.dart';
import 'package:gym_track/core/widgets/app_card.dart';

/// Compact streak counter card.
class StreakStatCard extends StatelessWidget {
  const StreakStatCard({
    required this.streakDays,
    super.key,
  });

  final int streakDays;

  @override
  Widget build(BuildContext context) {
    final accents = context.accents;
    final theme = Theme.of(context);
    final hasStreak = streakDays > 0;

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: hasStreak
                      ? accents.energy.withValues(alpha: 0.15)
                      : theme.colorScheme.surfaceContainerHigh,
                  borderRadius: AppRadius.allSm,
                ),
                child: Icon(
                  Icons.local_fire_department_rounded,
                  color: hasStreak
                      ? accents.energy
                      : theme.colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ),
              const Spacer(),
              Text(
                'STREAK',
                style: AppTypography.overline(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '$streakDays',
            style: theme.textTheme.displaySmall?.copyWith(height: 1),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            streakDays == 1 ? 'day streak' : 'day streak',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            hasStreak ? 'Keep it going.' : 'Train today to start.',
            style: theme.textTheme.labelMedium?.copyWith(
              color: hasStreak ? accents.energy : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// Weekly completed sessions vs goal with a progress bar.
class WeeklyProgressCard extends StatelessWidget {
  const WeeklyProgressCard({
    required this.completed,
    required this.goal,
    required this.progress,
    super.key,
  });

  final int completed;
  final int goal;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final accents = context.accents;
    final theme = Theme.of(context);
    final met = completed >= goal && goal > 0;

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: met
                      ? accents.success.withValues(alpha: 0.15)
                      : accents.volt.withValues(alpha: 0.18),
                  borderRadius: AppRadius.allSm,
                ),
                child: Icon(
                  Icons.calendar_view_week_rounded,
                  color: met ? accents.success : accents.volt,
                  size: 20,
                ),
              ),
              const Spacer(),
              Text(
                'THIS WEEK',
                style: AppTypography.overline(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$completed',
                  style: theme.textTheme.displaySmall?.copyWith(height: 1),
                ),
                TextSpan(
                  text: ' / $goal',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'workouts',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: AppRadius.allPill,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: theme.colorScheme.surfaceContainerHigh,
              color: met ? accents.success : accents.volt,
            ),
          ),
        ],
      ),
    );
  }
}
