import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:gym_track/app/router/route_names.dart';
import 'package:gym_track/core/widgets/placeholder_view.dart';

/// Workout tab placeholder — sessions and templates.
class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.workoutDetailPath('new')),
        icon: const Icon(Icons.add_rounded),
        label: const Text('New workout'),
      ),
      body: PlaceholderView(
        title: 'No workouts yet',
        subtitle:
            'Workout sessions and templates will appear here once tracking '
            'is implemented.',
        icon: Icons.fitness_center_rounded,
        action: OutlinedButton(
          onPressed: () => context.push(AppRoutes.workoutDetailPath('demo')),
          child: const Text('Open sample detail'),
        ),
      ),
    );
  }
}
