import 'package:flutter/material.dart';

import 'package:gym_track/app/theme/app_accents.dart';
import 'package:gym_track/app/theme/app_radius.dart';
import 'package:gym_track/app/theme/app_spacing.dart';
import 'package:gym_track/core/widgets/pressable.dart';

/// Visual style variants for [AppCard].
enum AppCardVariant {
  /// Filled surface container.
  filled,

  /// Transparent with a hairline outline.
  outlined,

  /// Elevated with a soft shadow.
  elevated,

  /// Dark brand gradient (great for hero / stat cards).
  brand,
}

/// A flexible, premium surface used to group content.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    super.key,
    this.variant = AppCardVariant.filled,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
    this.borderRadius = AppRadius.allLg,
    this.glow = false,
  });

  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;

  /// Adds a signature volt glow — use sparingly for emphasised cards.
  final bool glow;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accents = context.accents;

    Color? color;
    Gradient? gradient;
    BoxBorder? border;
    List<BoxShadow>? shadow;

    switch (variant) {
      case AppCardVariant.filled:
        color = scheme.surfaceContainerLow;
      case AppCardVariant.outlined:
        color = scheme.surface;
        border = Border.all(color: scheme.outlineVariant);
      case AppCardVariant.elevated:
        color = scheme.surfaceContainerLow;
        shadow = accents.shadowMd;
      case AppCardVariant.brand:
        gradient = accents.heroGradient;
        shadow = accents.shadowMd;
    }

    if (glow) {
      shadow = [
        ...?shadow,
        BoxShadow(
          color: accents.volt.withValues(alpha: 0.35),
          blurRadius: 28,
          spreadRadius: -6,
          offset: const Offset(0, 10),
        ),
      ];
    }

    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: borderRadius,
        border: border,
        boxShadow: shadow,
      ),
      child: child,
    );

    if (onTap == null) return content;

    return Pressable(
      onTap: onTap,
      borderRadius: borderRadius,
      child: content,
    );
  }
}
