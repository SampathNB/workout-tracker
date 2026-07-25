import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gym_track/app/theme/app_accents.dart';
import 'package:gym_track/app/theme/app_motion.dart';
import 'package:gym_track/app/theme/app_radius.dart';
import 'package:gym_track/app/theme/app_spacing.dart';

/// Destination metadata for [AnimatedBottomNav].
class NavDestination {
  const NavDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// Premium animated bottom navigation with a sliding pill indicator,
/// icon scale, and label fade — Nike Training Club inspired.
class AnimatedBottomNav extends StatelessWidget {
  const AnimatedBottomNav({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final List<NavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accents = context.accents;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: SizedBox(
          height: 72,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.sm,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth / destinations.length;

                return Stack(
                  children: [
                    // Sliding indicator pill
                    AnimatedPositioned(
                      duration: AppDurations.normal,
                      curve: AppCurves.emphasized,
                      left: itemWidth * selectedIndex + AppSpacing.xs,
                      top: 0,
                      bottom: 0,
                      width: itemWidth - AppSpacing.sm,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          borderRadius: AppRadius.allPill,
                          boxShadow: accents.shadowSm,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        for (var i = 0; i < destinations.length; i++)
                          Expanded(
                            child: _NavItem(
                              destination: destinations[i],
                              selected: i == selectedIndex,
                              onTap: () {
                                if (i == selectedIndex) return;
                                HapticFeedback.selectionClick();
                                onDestinationSelected(i);
                              },
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final NavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final activeColor = scheme.onPrimary;
    final inactiveColor = scheme.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.allPill,
        splashColor: scheme.onSurface.withValues(alpha: 0.08),
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: selected ? 1.08 : 1,
                duration: AppDurations.fast,
                curve: AppCurves.emphasized,
                child: AnimatedSwitcher(
                  duration: AppDurations.fast,
                  switchInCurve: AppCurves.decelerate,
                  switchOutCurve: AppCurves.accelerate,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Icon(
                    selected ? destination.selectedIcon : destination.icon,
                    key: ValueKey('${destination.label}-$selected'),
                    size: 22,
                    color: selected ? activeColor : inactiveColor,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxs + 1),
              AnimatedDefaultTextStyle(
                duration: AppDurations.fast,
                curve: AppCurves.standard,
                style: (theme.textTheme.labelSmall ?? const TextStyle()).copyWith(
                  color: selected ? activeColor : inactiveColor,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  fontSize: selected ? 11 : 10,
                  letterSpacing: selected ? 0.2 : 0.1,
                ),
                child: Text(
                  destination.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
