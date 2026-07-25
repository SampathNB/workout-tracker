/// Central route path constants for GoRouter.
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String dashboard = '/dashboard';
  static const String calendar = '/calendar';
  static const String workout = '/workout';
  static const String workoutDetail = '/workout/:id';
  static const String progress = '/progress';
  static const String settings = '/settings';

  static String workoutDetailPath(String id) => '/workout/$id';
}

/// Shell tab indices — keep in sync with [StatefulShellRoute] branch order.
abstract final class ShellTabs {
  static const int dashboard = 0;
  static const int calendar = 1;
  static const int workout = 2;
  static const int progress = 3;
  static const int settings = 4;
}
