import 'package:flutter/material.dart';

/// GymTrack raw color palette.
///
/// Inspired by Nike Training Club: a high-contrast ink/white base energised by
/// a signature "volt" accent, backed by a full semantic + neutral ramp so the
/// design system never reaches for ad-hoc colors.
abstract final class AppColors {
  const AppColors._();

  // --- Brand seed -----------------------------------------------------------
  /// Seed used when a generated scheme is needed. The shipped schemes are
  /// hand-tuned (see [AppColorSchemes]), this only feeds harmonization.
  static const Color seed = Color(0xFF111113);

  // --- Signature accent (volt) ----------------------------------------------
  static const Color volt = Color(0xFFD7FF3E);
  static const Color voltBright = Color(0xFFC5FF00);
  static const Color voltDim = Color(0xFF9EBE1F);
  static const Color voltInk = Color(0xFF1A2200);

  // --- Energy accents --------------------------------------------------------
  static const Color energy = Color(0xFFFF6B00);
  static const Color coral = Color(0xFFFF4D4D);
  static const Color electric = Color(0xFF3D9BFF);
  static const Color violet = Color(0xFF8B5CF6);

  // --- Semantic --------------------------------------------------------------
  static const Color success = Color(0xFF22C55E);
  static const Color successDark = Color(0xFF4ADE80);
  static const Color warning = Color(0xFFF5A524);
  static const Color warningDark = Color(0xFFFBBF24);
  static const Color danger = Color(0xFFE5484D);
  static const Color dangerDark = Color(0xFFFF6369);
  static const Color info = Color(0xFF3D9BFF);
  static const Color infoDark = Color(0xFF60B4FF);

  // --- Ink / neutral ramp ----------------------------------------------------
  static const Color ink = Color(0xFF111113);
  static const Color ink900 = Color(0xFF0B0B0D);
  static const Color ink800 = Color(0xFF17171A);
  static const Color ink700 = Color(0xFF1F1F23);
  static const Color ink600 = Color(0xFF26262B);
  static const Color ink500 = Color(0xFF3A3A3F);
  static const Color ink400 = Color(0xFF5B5B61);
  static const Color ink300 = Color(0xFF8A8A90);
  static const Color ink200 = Color(0xFFC4C4C8);
  static const Color ink100 = Color(0xFFE3E3E6);
  static const Color ink50 = Color(0xFFF4F4F5);

  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFFAFAFA);
  static const Color black = Color(0xFF000000);
}

/// Hand-tuned Material 3 [ColorScheme]s for light and dark brightness.
abstract final class AppColorSchemes {
  const AppColorSchemes._();

  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.ink,
    onPrimary: AppColors.white,
    primaryContainer: Color(0xFF2A2A2E),
    onPrimaryContainer: AppColors.white,
    secondary: Color(0xFF44464A),
    onSecondary: AppColors.white,
    secondaryContainer: Color(0xFFE7E7EA),
    onSecondaryContainer: Color(0xFF1B1C1E),
    tertiary: AppColors.voltDim,
    onTertiary: AppColors.voltInk,
    tertiaryContainer: Color(0xFFEAF7B8),
    onTertiaryContainer: Color(0xFF2B3600),
    error: AppColors.danger,
    onError: AppColors.white,
    errorContainer: Color(0xFFFCE4E4),
    onErrorContainer: Color(0xFF5C1114),
    surface: AppColors.offWhite,
    onSurface: AppColors.ink,
    surfaceDim: Color(0xFFDCDCDF),
    surfaceBright: AppColors.white,
    surfaceContainerLowest: AppColors.white,
    surfaceContainerLow: Color(0xFFF6F6F7),
    surfaceContainer: Color(0xFFF1F1F3),
    surfaceContainerHigh: Color(0xFFEBEBEE),
    surfaceContainerHighest: Color(0xFFE6E6E9),
    onSurfaceVariant: Color(0xFF46474A),
    outline: Color(0xFFC4C4C8),
    outlineVariant: Color(0xFFE0E0E3),
    inverseSurface: Color(0xFF1B1C1E),
    onInverseSurface: Color(0xFFF2F2F5),
    inversePrimary: Color(0xFFE8E8EA),
    surfaceTint: AppColors.ink,
    shadow: AppColors.black,
    scrim: AppColors.black,
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.white,
    onPrimary: AppColors.ink,
    primaryContainer: Color(0xFF2A2A2E),
    onPrimaryContainer: AppColors.white,
    secondary: Color(0xFFC7C7CC),
    onSecondary: Color(0xFF1B1C1E),
    secondaryContainer: Color(0xFF2E2E33),
    onSecondaryContainer: Color(0xFFE3E3E6),
    tertiary: AppColors.volt,
    onTertiary: AppColors.voltInk,
    tertiaryContainer: Color(0xFF3A4A00),
    onTertiaryContainer: Color(0xFFE7FF9E),
    error: AppColors.dangerDark,
    onError: Color(0xFF3A0709),
    errorContainer: Color(0xFF7A1418),
    onErrorContainer: Color(0xFFFFD9DA),
    surface: AppColors.ink900,
    onSurface: Color(0xFFF2F2F5),
    surfaceDim: AppColors.ink900,
    surfaceBright: Color(0xFF303035),
    surfaceContainerLowest: Color(0xFF060607),
    surfaceContainerLow: Color(0xFF131316),
    surfaceContainer: AppColors.ink800,
    surfaceContainerHigh: AppColors.ink700,
    surfaceContainerHighest: AppColors.ink600,
    onSurfaceVariant: Color(0xFFC4C4C8),
    outline: Color(0xFF3A3A3F),
    outlineVariant: Color(0xFF2A2A2E),
    inverseSurface: Color(0xFFF2F2F5),
    onInverseSurface: Color(0xFF1B1C1E),
    inversePrimary: AppColors.ink,
    surfaceTint: AppColors.white,
    shadow: AppColors.black,
    scrim: AppColors.black,
  );
}
