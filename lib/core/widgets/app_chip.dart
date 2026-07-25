import 'package:flutter/material.dart';

import 'package:gym_track/app/theme/app_accents.dart';
import 'package:gym_track/app/theme/app_motion.dart';
import 'package:gym_track/app/theme/app_radius.dart';
import 'package:gym_track/app/theme/app_spacing.dart';

/// A selectable pill chip for filters, tags, and category selection.
///
/// Selected state uses the ink primary (or volt when [emphasized]) to match the
/// Nike Training Club aesthetic.
class AppChip extends StatelessWidget {
  const AppChip({
    required this.label,
    super.key,
    this.selected = false,
    this.onSelected,
    this.icon,
    this.emphasized = false,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final IconData? icon;

  /// When selected, use the volt accent instead of the ink primary.
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final accents = context.accents;
    final enabled = onSelected != null;

    final selectedBg = emphasized ? accents.volt : scheme.primary;
    final selectedFg = emphasized ? accents.onVolt : scheme.onPrimary;

    final background = selected ? selectedBg : scheme.surfaceContainerHigh;
    final foreground = selected ? selectedFg : scheme.onSurfaceVariant;

    return AnimatedOpacity(
      duration: AppDurations.fast,
      opacity: enabled ? 1 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.allPill,
          onTap: enabled ? () => onSelected!(!selected) : null,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            curve: AppCurves.standard,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm + 2,
            ),
            decoration: BoxDecoration(
              color: background,
              borderRadius: AppRadius.allPill,
              border: Border.all(
                color: selected ? Colors.transparent : scheme.outlineVariant,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16, color: foreground),
                  const SizedBox(width: AppSpacing.xs + 2),
                ],
                Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: foreground,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Small non-interactive status badge (e.g. "PR", "New", "Rest day").
class AppBadge extends StatelessWidget {
  const AppBadge({
    required this.label,
    super.key,
    this.color,
    this.icon,
  });

  final String label;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = color ?? context.accents.volt;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.16),
        borderRadius: AppRadius.allSm,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs + 2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 12, color: accent),
              const SizedBox(width: AppSpacing.xs),
            ],
            Text(
              label.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: accent,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
