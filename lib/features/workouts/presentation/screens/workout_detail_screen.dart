import 'package:flutter/material.dart';

import 'package:gym_track/core/widgets/placeholder_view.dart';

/// Single workout detail placeholder.
class WorkoutDetailScreen extends StatelessWidget {
  const WorkoutDetailScreen({
    required this.workoutId,
    super.key,
  });

  final String workoutId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workoutId == 'new' ? 'New workout' : 'Workout'),
      ),
      body: PlaceholderView(
        title: workoutId == 'new' ? 'Create workout' : 'Workout detail',
        subtitle: workoutId == 'new'
            ? 'The workout builder will go here.'
            : 'Details for workout "$workoutId" will appear here.',
        icon: workoutId == 'new'
            ? Icons.add_circle_outline_rounded
            : Icons.list_alt_rounded,
      ),
    );
  }
}
