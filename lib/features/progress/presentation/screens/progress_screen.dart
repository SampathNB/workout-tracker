import 'package:flutter/material.dart';

import 'package:gym_track/core/widgets/placeholder_view.dart';

/// Progress / analytics placeholder.
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: const PlaceholderView(
        title: 'Track your progress',
        subtitle:
            'Charts for volume, personal records, and consistency streaks '
            'will show up here.',
        icon: Icons.insights_rounded,
      ),
    );
  }
}
