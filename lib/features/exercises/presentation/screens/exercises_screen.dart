import 'package:flutter/material.dart';

import 'package:gym_track/core/widgets/placeholder_view.dart';

/// Exercise library placeholder.
class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercises')),
      body: const PlaceholderView(
        title: 'Exercise library',
        subtitle:
            'Browse and search exercises by muscle group, equipment, and '
            'movement pattern — coming soon.',
        icon: Icons.sports_gymnastics_rounded,
      ),
    );
  }
}
