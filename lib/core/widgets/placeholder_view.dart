import 'package:flutter/material.dart';

import 'package:gym_track/core/widgets/responsive_layout.dart';

/// Shared empty / placeholder feature body used until business logic lands.
class PlaceholderView extends StatelessWidget {
  const PlaceholderView({
    required this.title,
    required this.subtitle,
    required this.icon,
    super.key,
    this.action,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ResponsiveContent(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.45),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Icon(
                  icon,
                  size: 48,
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              title,
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Text(
                subtitle,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (action != null) ...[
              const SizedBox(height: 28),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
