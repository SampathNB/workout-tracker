import 'package:flutter/material.dart';
import 'package:gym_track/app/theme/app_accents.dart';
import 'package:gym_track/app/theme/app_radius.dart';
import 'package:gym_track/app/theme/app_spacing.dart';
import 'package:gym_track/app/theme/app_typography.dart';
import 'package:gym_track/core/widgets/app_card.dart';
import 'package:gym_track/core/widgets/pressable.dart';

/// Four primary shortcuts under the dashboard fold.
class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({
    required this.onStartWorkout,
    required this.onLogWeight,
    required this.onOpenCalendar,
    required this.onOpenProgress,
    super.key,
  });

  final VoidCallback onStartWorkout;
  final VoidCallback onLogWeight;
  final VoidCallback onOpenCalendar;
  final VoidCallback onOpenProgress;

  @override
  Widget build(BuildContext context) {
    final accents = context.accents;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUICK ACTIONS',
          style: AppTypography.overline(context),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _QuickAction(
                icon: Icons.fitness_center_rounded,
                label: 'Workout',
                color: accents.volt,
                onTap: onStartWorkout,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QuickAction(
                icon: Icons.monitor_weight_outlined,
                label: 'Weight',
                color: accents.electric,
                onTap: onLogWeight,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QuickAction(
                icon: Icons.calendar_month_rounded,
                label: 'Calendar',
                color: accents.energy,
                onTap: onOpenCalendar,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QuickAction(
                icon: Icons.insights_rounded,
                label: 'Progress',
                color: accents.violet,
                onTap: onOpenProgress,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Pressable(
      onTap: onTap,
      borderRadius: AppRadius.allLg,
      child: AppCard(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.lg,
          horizontal: AppSpacing.sm,
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.16),
                borderRadius: AppRadius.allMd,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
