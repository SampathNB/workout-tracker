import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_track/app/app.dart';
import 'package:gym_track/core/constants/app_constants.dart';
import 'package:gym_track/core/di/injection.dart';
import 'package:gym_track/core/storage/hive_storage.dart';
import 'package:gym_track/features/home/domain/entities/dashboard_snapshot.dart';
import 'package:gym_track/features/home/domain/entities/motivational_quote.dart';
import 'package:gym_track/features/home/presentation/providers/dashboard_provider.dart';
import 'package:gym_track/features/settings/domain/entities/app_settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

DashboardSnapshot get _fixtureSnapshot => DashboardSnapshot(
  now: DateTime(2026, 7, 25, 9, 30),
  settings: const AppSettings(displayName: 'Sam', weeklyWorkoutGoal: 4),
  greeting: 'Good morning',
  displayName: 'Sam',
  streakDays: 3,
  weeklyCompleted: 2,
  weeklyGoal: 4,
  quote: const MotivationalQuote(
    text: 'Consistency beats intensity.',
    author: 'GymTrack',
  ),
);

List<Override> _overrides(SharedPreferences prefs) => [
  sharedPreferencesProvider.overrideWithValue(prefs),
  dashboardSnapshotProvider.overrideWith((ref) async => _fixtureSnapshot),
];

Future<void> _pumpPastSplash(WidgetTester tester) async {
  await tester.pump(AppConstants.splashDuration);
  await tester.pump(); // apply GoRouter navigation + first dashboard frame
  await tester.pump(const Duration(milliseconds: 50));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    tempDir = await Directory.systemTemp.createTemp('gym_track_widget_');
    await HiveStorage.init(path: tempDir.path);
    await HiveStorage.clearAll();
  });

  tearDown(() async {
    await HiveStorage.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  testWidgets('GymTrackApp boots with splash then dashboard shell', (
    tester,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: _overrides(prefs),
        child: const GymTrackApp(),
      ),
    );

    expect(find.text(AppConstants.appName), findsOneWidget);
    expect(find.text('Train smarter. Track better.'), findsOneWidget);

    await _pumpPastSplash(tester);

    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Calendar'), findsWidgets);
    expect(find.text('Workout'), findsWidgets);
    expect(find.text('Progress'), findsWidgets);
    expect(find.text('Settings'), findsOneWidget);

    expect(find.text('Good morning,'), findsOneWidget);
    expect(find.text('Sam'), findsOneWidget);
    expect(find.text("TODAY'S WORKOUT"), findsOneWidget);
    expect(find.text('QUICK ACTIONS'), findsOneWidget);
    expect(find.textContaining('day streak'), findsOneWidget);
    expect(find.textContaining('Consistency beats intensity'), findsOneWidget);
  });

  testWidgets('Bottom nav switches tabs and preserves destinations', (
    tester,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: _overrides(prefs),
        child: const GymTrackApp(),
      ),
    );

    await _pumpPastSplash(tester);

    // Prefer the bottom-nav label (last) over the Quick Actions chip.
    await tester.tap(find.text('Calendar').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Training calendar'), findsOneWidget);

    await tester.tap(find.text('Workout').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('No workouts yet'), findsOneWidget);

    await tester.tap(find.text('Calendar').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Training calendar'), findsOneWidget);
  });

  testWidgets('Dashboard start workout CTA opens workout tab', (tester) async {
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: _overrides(prefs),
        child: const GymTrackApp(),
      ),
    );

    await _pumpPastSplash(tester);

    await tester.tap(find.text('Start workout').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('No workouts yet'), findsOneWidget);
  });
}
