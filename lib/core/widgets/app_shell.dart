import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_track/app/router/route_names.dart';
import 'package:gym_track/core/utils/responsive.dart';

/// Adaptive shell: bottom nav on mobile, navigation rail on tablet/desktop.
class AppShell extends StatelessWidget {
  const AppShell({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    const destinations = [
      _ShellDestination(
        label: 'Home',
        icon: Icons.home_outlined,
        selectedIcon: Icons.home_rounded,
        path: AppRoutes.home,
      ),
      _ShellDestination(
        label: 'Workouts',
        icon: Icons.fitness_center_outlined,
        selectedIcon: Icons.fitness_center_rounded,
        path: AppRoutes.workouts,
      ),
      _ShellDestination(
        label: 'Exercises',
        icon: Icons.sports_gymnastics_outlined,
        selectedIcon: Icons.sports_gymnastics_rounded,
        path: AppRoutes.exercises,
      ),
      _ShellDestination(
        label: 'Progress',
        icon: Icons.insights_outlined,
        selectedIcon: Icons.insights_rounded,
        path: AppRoutes.progress,
      ),
      _ShellDestination(
        label: 'Settings',
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings_rounded,
        path: AppRoutes.settings,
      ),
    ];

    if (Responsive.isMobile(context)) {
      return Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onDestinationSelected,
          destinations: [
            for (final d in destinations)
              NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: d.label,
              ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: _onDestinationSelected,
            extended: Responsive.isDesktop(context),
            labelType: Responsive.isDesktop(context)
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Icon(
                Icons.fitness_center_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
            ),
            destinations: [
              for (final d in destinations)
                NavigationRailDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: Text(d.label),
                ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

class _ShellDestination {
  const _ShellDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.path,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String path;
}
