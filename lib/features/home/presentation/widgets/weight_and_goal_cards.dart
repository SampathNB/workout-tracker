import 'package:flutter/material.dart';
import 'package:gym_track/app/theme/app_accents.dart';
import 'package:gym_track/app/theme/app_radius.dart';
import 'package:gym_track/app/theme/app_spacing.dart';
import 'package:gym_track/app/theme/app_typography.dart';
import 'package:gym_track/core/widgets/app_card.dart';
import 'package:gym_track/features/home/domain/dashboard_assembler.dart';
import 'package:gym_track/features/progress/domain/entities/goal.dart';
import 'package:gym_track/features/progress/domain/entities/weight_entry.dart';
import 'package:gym_track/features/settings/domain/entities/app_settings.dart';
import 'package:intl/intl.dart';

/// Latest body-weight reading with empty-state CTA.
class CurrentWeightCard extends StatelessWidget {
  const CurrentWeightCard({
    required this.entry,
    required this.settings,
    required this.onLogWeight,
    super.key,
  });

  final WeightEntry? entry;
  final AppSettings settings;
  final VoidCallback onLogWeight;

  @override
  Widget build(BuildContext context) {
    final accents = context.accents;
    final theme = Theme.of(context);
    final weight = entry;

    return AppCard(
      onTap: onLogWeight,
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
                  color: accents.electric.withValues(alpha: 0.15),
                  borderRadius: AppRadius.allSm,
                ),
                child: Icon(
                  Icons.monitor_weight_outlined,
                  color: accents.electric,
                  size: 20,
                ),
              ),
              const Spacer(),
              Text('WEIGHT', style: AppTypography.overline(context)),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          if (weight == null) ...[
            Text(
              '—',
              style: theme.textTheme.displaySmall?.copyWith(height: 1),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Tap to log weight',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ] else ...[
            Text(
              DashboardAssembler.formatWeight(weight, settings),
              style: theme.textTheme.displaySmall?.copyWith(height: 1),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Updated ${DateFormat.MMMd().format(weight.recordedAt)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Primary monthly / active goal with progress ring.
class MonthlyGoalCard extends StatelessWidget {
  const MonthlyGoalCard({
    required this.goal,
    required this.onOpenGoals,
    super.key,
  });

  final Goal? goal;
  final VoidCallback onOpenGoals;

  @override
  Widget build(BuildContext context) {
    final accents = context.accents;
    final theme = Theme.of(context);
    final active = goal;

    return AppCard(
      onTap: onOpenGoals,
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
                  color: accents.violet.withValues(alpha: 0.15),
                  borderRadius: AppRadius.allSm,
                ),
                child: Icon(
                  Icons.flag_rounded,
                  color: accents.violet,
                  size: 20,
                ),
              ),
              const Spacer(),
              Text('GOAL', style: AppTypography.overline(context)),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          if (active == null) ...[
            Text(
              'Set a goal',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Track a monthly target',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ] else ...[
            Text(
              active.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: active.progress,
                        strokeWidth: 5,
                        backgroundColor: theme.colorScheme.surfaceContainerHigh,
                        color: accents.violet,
                      ),
                      Center(
                        child: Text(
                          '${(active.progress * 100).round()}%',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    '${_fmt(active.value)} → ${_fmt(active.targetValue)} ${active.unit}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  static String _fmt(double value) {
    if (value == value.roundToDouble()) return value.toStringAsFixed(0);
    return value.toStringAsFixed(1);
  }
}
