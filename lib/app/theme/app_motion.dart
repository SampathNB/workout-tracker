import 'package:flutter/animation.dart';

/// Animation duration + curve tokens for consistent, energetic motion.
abstract final class AppDurations {
  const AppDurations._();

  /// 100ms — micro feedback (press states).
  static const Duration instant = Duration(milliseconds: 100);

  /// 180ms — fast transitions.
  static const Duration fast = Duration(milliseconds: 180);

  /// 260ms — default UI motion.
  static const Duration normal = Duration(milliseconds: 260);

  /// 380ms — expressive entrances.
  static const Duration slow = Duration(milliseconds: 380);

  /// 600ms — hero / celebratory motion.
  static const Duration expressive = Duration(milliseconds: 600);
}

/// Curve tokens tuned for a snappy, athletic feel.
abstract final class AppCurves {
  const AppCurves._();

  /// Standard easing for most transitions.
  static const Curve standard = Curves.easeOutCubic;

  /// Decelerate for entering elements.
  static const Curve decelerate = Curves.easeOutQuart;

  /// Accelerate for exiting elements.
  static const Curve accelerate = Curves.easeInCubic;

  /// Springy emphasis for press / pop interactions.
  static const Curve emphasized = Curves.easeOutBack;

  /// Smooth in-out for looping / reversible motion.
  static const Curve smooth = Curves.easeInOutCubic;
}
