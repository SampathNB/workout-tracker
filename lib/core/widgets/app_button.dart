import 'package:flutter/material.dart';

import 'package:gym_track/app/theme/app_accents.dart';
import 'package:gym_track/app/theme/app_motion.dart';
import 'package:gym_track/app/theme/app_radius.dart';
import 'package:gym_track/app/theme/app_spacing.dart';

/// Visual style variants for [AppButton].
enum AppButtonVariant {
  /// High-emphasis solid button (ink in light, white in dark).
  primary,

  /// Neutral filled button on a container surface.
  secondary,

  /// Signature volt accent button for standout CTAs.
  volt,

  /// Outlined, medium-emphasis button.
  outline,

  /// Low-emphasis text button.
  ghost,

  /// Destructive action button.
  danger,
}

/// Size options controlling height, padding, and text scale.
enum AppButtonSize { small, medium, large }

/// A premium, Nike-inspired button with variants, sizes, loading and icon
/// support, and tactile press feedback.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    super.key,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.large,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.expand = false,
  });

  /// Convenience constructor for a full-width button.
  const AppButton.expanded({
    required this.label,
    super.key,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.large,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
  }) : expand = true;

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool expand;

  bool get _enabled => onPressed != null && !isLoading;

  double get _height => switch (size) {
        AppButtonSize.small => 40,
        AppButtonSize.medium => 48,
        AppButtonSize.large => 56,
      };

  EdgeInsets get _padding => switch (size) {
        AppButtonSize.small =>
          const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        AppButtonSize.medium =>
          const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        AppButtonSize.large =>
          const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
      };

  double get _iconSize => switch (size) {
        AppButtonSize.small => 18,
        AppButtonSize.medium => 20,
        AppButtonSize.large => 22,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final accents = context.accents;
    final palette = _resolvePalette(colorScheme, accents);

    final textStyle = (size == AppButtonSize.small
            ? theme.textTheme.labelMedium
            : theme.textTheme.labelLarge)
        ?.copyWith(color: palette.foreground);

    final child = AnimatedSwitcher(
      duration: AppDurations.fast,
      child: isLoading
          ? SizedBox(
              key: const ValueKey('loading'),
              height: _iconSize,
              width: _iconSize,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: palette.foreground,
              ),
            )
          : Row(
              key: const ValueKey('content'),
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: _iconSize, color: palette.foreground),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Flexible(
                  child: Text(
                    label,
                    style: textStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                if (trailingIcon != null) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Icon(trailingIcon, size: _iconSize, color: palette.foreground),
                ],
              ],
            ),
    );

    final button = AnimatedOpacity(
      duration: AppDurations.fast,
      opacity: _enabled ? 1 : 0.45,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        curve: AppCurves.standard,
        height: _height,
        padding: _padding,
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: AppRadius.allPill,
          border: palette.border,
          boxShadow: _enabled ? palette.shadow : null,
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );

    final tappable = Material(
      color: Colors.transparent,
      borderRadius: AppRadius.allPill,
      child: InkWell(
        onTap: _enabled ? onPressed : null,
        borderRadius: AppRadius.allPill,
        splashColor: palette.foreground.withValues(alpha: 0.1),
        highlightColor: palette.foreground.withValues(alpha: 0.05),
        child: button,
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: tappable) : tappable;
  }

  _ButtonPalette _resolvePalette(ColorScheme scheme, AppAccents accents) {
    switch (variant) {
      case AppButtonVariant.primary:
        return _ButtonPalette(
          background: scheme.primary,
          foreground: scheme.onPrimary,
          shadow: accents.shadowSm,
        );
      case AppButtonVariant.secondary:
        return _ButtonPalette(
          background: scheme.surfaceContainerHigh,
          foreground: scheme.onSurface,
        );
      case AppButtonVariant.volt:
        return _ButtonPalette(
          background: accents.volt,
          foreground: accents.onVolt,
          shadow: accents.shadowSm,
        );
      case AppButtonVariant.danger:
        return _ButtonPalette(
          background: accents.danger,
          foreground: accents.onDanger,
        );
      case AppButtonVariant.outline:
        return _ButtonPalette(
          background: Colors.transparent,
          foreground: scheme.onSurface,
          border: Border.all(color: scheme.outline, width: 1.5),
        );
      case AppButtonVariant.ghost:
        return _ButtonPalette(
          background: Colors.transparent,
          foreground: scheme.onSurface,
        );
    }
  }
}

class _ButtonPalette {
  const _ButtonPalette({
    required this.background,
    required this.foreground,
    this.border,
    this.shadow,
  });

  final Color background;
  final Color foreground;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;
}
