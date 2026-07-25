import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_track/app/app.dart';
import 'package:gym_track/core/di/injection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  final dependencies = await DependencyInjection.init();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          dependencies.sharedPreferences,
        ),
      ],
      child: const GymTrackApp(),
    ),
  );
}
