import 'package:flutter/material.dart';
import 'package:gym_track/app/theme/app_accents.dart';
import 'package:gym_track/app/theme/app_spacing.dart';
import 'package:gym_track/app/theme/app_typography.dart';
import 'package:gym_track/core/widgets/app_card.dart';
import 'package:gym_track/features/home/domain/entities/motivational_quote.dart';

/// Daily motivational quote card.
class MotivationalQuoteCard extends StatelessWidget {
  const MotivationalQuoteCard({
    required this.quote,
    super.key,
  });

  final MotivationalQuote quote;

  @override
  Widget build(BuildContext context) {
    final accents = context.accents;
    final theme = Theme.of(context);

    return AppCard(
      variant: AppCardVariant.outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.format_quote_rounded,
                color: accents.volt,
                size: 28,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'DAILY SPARK',
                style: AppTypography.overline(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '"${quote.text}"',
            style: theme.textTheme.titleMedium?.copyWith(
              height: 1.35,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '— ${quote.author}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
