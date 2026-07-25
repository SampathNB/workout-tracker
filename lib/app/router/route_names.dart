/// Central route path constants for GoRouter.
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String workouts = '/workouts';
  static const String workoutDetail = '/workouts/:id';
  static const String exercises = '/exercises';
  static const String progress = '/progress';
  static const String settings = '/settings';

  static String workoutDetailPath(String id) => '/workouts/$id';
}
