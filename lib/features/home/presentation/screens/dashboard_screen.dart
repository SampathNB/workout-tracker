import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:gym_track/app/router/route_names.dart';
import 'package:gym_track/core/widgets/placeholder_view.dart';

/// Dashboard tab — shell entry point.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: PlaceholderView(
        title: 'Welcome to GymTrack',
        subtitle:
            'Your training overview will live here — today’s session, streaks, '
            'and quick actions.',
        icon: Icons.dashboard_rounded,
        action: FilledButton.icon(
          onPressed: () => context.go(AppRoutes.workout),
          icon: const Icon(Icons.fitness_center_rounded),
          label: const Text('Start workout'),
        ),
      ),
    );
  }
}
