import 'package:flutter/material.dart';
import 'package:gym_track/app/theme/app_spacing.dart';
import 'package:gym_track/app/theme/app_typography.dart';
import 'package:intl/intl.dart';

/// Time-of-day greeting plus the athlete's first name.
class DashboardGreetingHeader extends StatelessWidget {
  const DashboardGreetingHeader({
    required this.greeting,
    required this.displayName,
    required this.now,
    super.key,
  });

  final String greeting;
  final String displayName;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateLabel = DateFormat('EEEE, MMM d').format(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateLabel.toUpperCase(),
          style: AppTypography.overline(context),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '$greeting,',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          displayName,
          style: theme.textTheme.displaySmall?.copyWith(
            height: 1.05,
          ),
        ),
      ],
    );
  }
}
