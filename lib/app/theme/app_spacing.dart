import 'package:flutter/widgets.dart';

/// 4pt-based spacing scale used across GymTrack.
///
/// Prefer these tokens over magic numbers so rhythm stays consistent.
abstract final class AppSpacing {
  const AppSpacing._();

  /// 2 — hairline gaps.
  static const double xxs = 2;

  /// 4 — tight icon/text gaps.
  static const double xs = 4;

  /// 8 — default small gap.
  static const double sm = 8;

  /// 12 — compact padding.
  static const double md = 12;

  /// 16 — base content padding.
  static const double lg = 16;

  /// 20 — comfortable padding.
  static const double xl = 20;

  /// 24 — section padding.
  static const double xxl = 24;

  /// 32 — large section gap.
  static const double xxxl = 32;

  /// 48 — hero / empty-state spacing.
  static const double huge = 48;

  /// 64 — page-level breathing room.
  static const double giant = 64;

  // --- Ready-made gap widgets ------------------------------------------------
  static const Widget gapXs = SizedBox(width: xs, height: xs);
  static const Widget gapSm = SizedBox(width: sm, height: sm);
  static const Widget gapMd = SizedBox(width: md, height: md);
  static const Widget gapLg = SizedBox(width: lg, height: lg);
  static const Widget gapXl = SizedBox(width: xl, height: xl);
  static const Widget gapXxl = SizedBox(width: xxl, height: xxl);

  static SizedBox vertical(double value) => SizedBox(height: value);
  static SizedBox horizontal(double value) => SizedBox(width: value);

  // --- Common insets ---------------------------------------------------------
  static const EdgeInsets screen = EdgeInsets.all(lg);
  static const EdgeInsets screenHorizontal = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets card = EdgeInsets.all(lg);
  static const EdgeInsets listItem =
      EdgeInsets.symmetric(horizontal: lg, vertical: md);
}
