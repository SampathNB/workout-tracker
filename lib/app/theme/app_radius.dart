import 'package:flutter/widgets.dart';

/// Corner-radius scale for GymTrack.
///
/// Nike-style surfaces favour crisp geometry: small radii on chrome, generous
/// rounding on cards, and full pills on primary actions.
abstract final class AppRadius {
  const AppRadius._();

  static const double xs = 6;
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 20;
  static const double xl = 28;
  static const double xxl = 36;

  /// Sentinel for fully-rounded / pill shapes.
  static const double pill = 999;

  // --- BorderRadius helpers --------------------------------------------------
  static const BorderRadius allXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius allSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius allMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius allLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius allXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius allXxl = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius allPill = BorderRadius.all(Radius.circular(pill));

  /// Rounds only the top corners — handy for bottom sheets.
  static const BorderRadius topXl = BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );
}
