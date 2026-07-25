import 'package:gym_track/core/constants/app_constants.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

/// Initializes Hive CE and opens application boxes.
///
/// Call once during app bootstrap before [runApp].
abstract final class HiveStorage {
  static Future<void> init() async {
    await Hive.initFlutter();

    await Future.wait([
      Hive.openBox<dynamic>(AppConstants.settingsBox),
      Hive.openBox<dynamic>(AppConstants.workoutsBox),
      Hive.openBox<dynamic>(AppConstants.exercisesBox),
    ]);
  }

  static Box<dynamic> get settingsBox =>
      Hive.box<dynamic>(AppConstants.settingsBox);

  static Box<dynamic> get workoutsBox =>
      Hive.box<dynamic>(AppConstants.workoutsBox);

  static Box<dynamic> get exercisesBox =>
      Hive.box<dynamic>(AppConstants.exercisesBox);

  static Future<void> close() => Hive.close();
}
