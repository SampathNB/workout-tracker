import 'package:flutter_test/flutter_test.dart';
import 'package:gym_track/app/app.dart';
import 'package:gym_track/core/constants/app_constants.dart';
import 'package:gym_track/core/di/injection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('GymTrackApp boots with splash then dashboard shell', (
    tester,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const GymTrackApp(),
      ),
    );

    expect(find.text(AppConstants.appName), findsOneWidget);
    expect(find.text('Train smarter. Track better.'), findsOneWidget);

    await tester.pump(AppConstants.splashDuration);
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('Workout'), findsWidgets);
    expect(find.text('Progress'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('Bottom nav switches tabs and preserves destinations', (
    tester,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const GymTrackApp(),
      ),
    );

    await tester.pump(AppConstants.splashDuration);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Calendar'));
    await tester.pumpAndSettle();
    expect(find.text('Training calendar'), findsOneWidget);

    await tester.tap(find.text('Workout'));
    await tester.pumpAndSettle();
    expect(find.text('No workouts yet'), findsOneWidget);

    // Return to calendar — branch should still be available.
    await tester.tap(find.text('Calendar'));
    await tester.pumpAndSettle();
    expect(find.text('Training calendar'), findsOneWidget);
  });
}
