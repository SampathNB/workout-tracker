import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gym_track/app/router/route_names.dart';
import 'package:gym_track/core/constants/app_constants.dart';
import 'package:gym_track/core/widgets/animated_branch_container.dart';
import 'package:gym_track/core/widgets/app_shell.dart';
import 'package:gym_track/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:gym_track/features/home/presentation/screens/dashboard_screen.dart';
import 'package:gym_track/features/progress/presentation/screens/progress_screen.dart';
import 'package:gym_track/features/settings/presentation/screens/settings_screen.dart';
import 'package:gym_track/features/splash/presentation/screens/splash_screen.dart';
import 'package:gym_track/features/workouts/presentation/screens/workout_detail_screen.dart';
import 'package:gym_track/features/workouts/presentation/screens/workout_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Provides the application [GoRouter] instance.
///
/// Shell tabs use [StatefulShellRoute] so each branch keeps its own navigator
/// stack and scroll/form state across tab switches.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const _SplashGate(),
      ),
      StatefulShellRoute(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        navigatorContainerBuilder: (context, navigationShell, children) {
          return AnimatedBranchContainer(
            currentIndex: navigationShell.currentIndex,
            children: children,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.dashboard,
                name: 'dashboard',
                pageBuilder: (context, state) => _fadeSlidePage(
                  state: state,
                  child: const DashboardScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.calendar,
                name: 'calendar',
                pageBuilder: (context, state) => _fadeSlidePage(
                  state: state,
                  child: const CalendarScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.workout,
                name: 'workout',
                pageBuilder: (context, state) => _fadeSlidePage(
                  state: state,
                  child: const WorkoutScreen(),
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    name: 'workoutDetail',
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      final id = state.pathParameters['id'] ?? '';
                      return _fadeSlidePage(
                        state: state,
                        child: WorkoutDetailScreen(workoutId: id),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.progress,
                name: 'progress',
                pageBuilder: (context, state) => _fadeSlidePage(
                  state: state,
                  child: const ProgressScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                name: 'settings',
                pageBuilder: (context, state) => _fadeSlidePage(
                  state: state,
                  child: const SettingsScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Not found')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.error?.toString() ?? 'Page not found'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go(AppRoutes.dashboard),
              child: const Text('Go to dashboard'),
            ),
          ],
        ),
      ),
    ),
  );
});

/// Shared fade + slight upward slide for route pushes (e.g. workout detail).
CustomTransitionPage<void> _fadeSlidePage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    name: state.name,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.03),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

/// Shows splash, then navigates into the main shell.
class _SplashGate extends StatefulWidget {
  const _SplashGate();

  @override
  State<_SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<_SplashGate> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(AppConstants.splashDuration, () {
      if (!mounted) return;
      context.go(AppRoutes.dashboard);
    });
  }

  @override
  Widget build(BuildContext context) => const SplashScreen();
}
