import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gym_track/app/router/route_names.dart';
import 'package:gym_track/core/constants/app_constants.dart';
import 'package:gym_track/core/widgets/app_shell.dart';
import 'package:gym_track/features/exercises/presentation/screens/exercises_screen.dart';
import 'package:gym_track/features/home/presentation/screens/home_screen.dart';
import 'package:gym_track/features/progress/presentation/screens/progress_screen.dart';
import 'package:gym_track/features/settings/presentation/screens/settings_screen.dart';
import 'package:gym_track/features/splash/presentation/screens/splash_screen.dart';
import 'package:gym_track/features/workouts/presentation/screens/workout_detail_screen.dart';
import 'package:gym_track/features/workouts/presentation/screens/workouts_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Provides the application [GoRouter] instance.
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.workouts,
                name: 'workouts',
                builder: (context, state) => const WorkoutsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    name: 'workoutDetail',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final id = state.pathParameters['id'] ?? '';
                      return WorkoutDetailScreen(workoutId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.exercises,
                name: 'exercises',
                builder: (context, state) => const ExercisesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.progress,
                name: 'progress',
                builder: (context, state) => const ProgressScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
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
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go home'),
            ),
          ],
        ),
      ),
    ),
  );
});

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
      context.go(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) => const SplashScreen();
}
