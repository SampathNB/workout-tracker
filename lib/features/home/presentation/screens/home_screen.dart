import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:gym_track/app/router/route_names.dart';
import 'package:gym_track/core/widgets/placeholder_view.dart';

/// Dashboard placeholder — shell entry point.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: PlaceholderView(
        title: 'Welcome to GymTrack',
        subtitle:
            'Your training dashboard will live here. Start by browsing workouts '
            'or exploring the exercise library.',
        icon: Icons.home_rounded,
        action: FilledButton.icon(
          onPressed: () => context.go(AppRoutes.workouts),
          icon: const Icon(Icons.fitness_center_rounded),
          label: const Text('Browse workouts'),
        ),
      ),
    );
  }
}
