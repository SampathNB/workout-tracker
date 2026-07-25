import 'package:flutter/material.dart';

import 'package:gym_track/core/widgets/placeholder_view.dart';

/// Calendar tab placeholder — training schedule & planned sessions.
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: const PlaceholderView(
        title: 'Training calendar',
        subtitle:
            'Plan sessions, see rest days, and jump into scheduled workouts '
            'from a monthly view.',
        icon: Icons.calendar_month_rounded,
      ),
    );
  }
}
