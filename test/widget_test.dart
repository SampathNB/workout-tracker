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

  testWidgets('GymTrackApp boots with splash branding', (tester) async {
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

    // Advance past splash delay and settle navigation.
    await tester.pump(AppConstants.splashDuration);
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
  });
}
