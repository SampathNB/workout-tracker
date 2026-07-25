import 'package:flutter/widgets.dart';

import 'package:gym_track/app/theme/app_colors.dart';

/// Soft, layered shadow tokens for a premium sense of depth.
///
/// Light mode uses subtle cool-grey shadows; dark mode leans on deeper blacks
/// plus optional accent glows for active states.
abstract final class AppShadows {
  const AppShadows._();

  // --- Light elevation levels ------------------------------------------------
  static const List<BoxShadow> none = <BoxShadow>[];

  static List<BoxShadow> get sm => const [
        BoxShadow(
          color: Color(0x0F111113),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get md => const [
        BoxShadow(
          color: Color(0x14111113),
          blurRadius: 16,
          offset: Offset(0, 6),
        ),
        BoxShadow(
          color: Color(0x0A111113),
          blurRadius: 4,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get lg => const [
        BoxShadow(
          color: Color(0x1F111113),
          blurRadius: 32,
          offset: Offset(0, 14),
        ),
        BoxShadow(
          color: Color(0x0D111113),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ];

  // --- Dark elevation levels -------------------------------------------------
  static List<BoxShadow> get smDark => const [
        BoxShadow(
          color: Color(0x40000000),
          blurRadius: 10,
          offset: Offset(0, 3),
        ),
      ];

  static List<BoxShadow> get mdDark => const [
        BoxShadow(
          color: Color(0x59000000),
          blurRadius: 20,
          offset: Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get lgDark => const [
        BoxShadow(
          color: Color(0x73000000),
          blurRadius: 36,
          offset: Offset(0, 16),
        ),
      ];

  /// Signature volt glow for emphasised, active elements.
  static List<BoxShadow> voltGlow({double opacity = 0.45}) => [
        BoxShadow(
          color: AppColors.volt.withValues(alpha: opacity),
          blurRadius: 24,
          spreadRadius: -4,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> forBrightness(
    Brightness brightness, {
    required List<BoxShadow> light,
    required List<BoxShadow> dark,
  }) {
    return brightness == Brightness.dark ? dark : light;
  }
}
