import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Premium athletic type system.
///
/// Display + headline styles use Archivo (a tight, confident grotesque) with
/// heavy weights and negative tracking for that bold Nike Training Club feel.
/// Body, title, and label styles use Inter for clean, legible UI text.
abstract final class AppTypography {
  const AppTypography._();

  static TextTheme textThemeFor(Brightness brightness) {
    final base = brightness == Brightness.dark
        ? Typography.material2021().white
        : Typography.material2021().black;

    final display = GoogleFonts.archivoTextTheme(base);
    final body = GoogleFonts.interTextTheme(base);

    return base.copyWith(
      // --- Display: hero numerals & big statements ---------------------------
      displayLarge: display.displayLarge?.copyWith(
        fontSize: 57,
        height: 1.02,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
      ),
      displayMedium: display.displayMedium?.copyWith(
        fontSize: 45,
        height: 1.05,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
      ),
      displaySmall: display.displaySmall?.copyWith(
        fontSize: 36,
        height: 1.08,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),

      // --- Headline: section titles -----------------------------------------
      headlineLarge: display.headlineLarge?.copyWith(
        fontSize: 32,
        height: 1.12,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
      ),
      headlineMedium: display.headlineMedium?.copyWith(
        fontSize: 28,
        height: 1.14,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
      headlineSmall: display.headlineSmall?.copyWith(
        fontSize: 24,
        height: 1.18,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),

      // --- Title: cards, app bars, list headers -----------------------------
      titleLarge: body.titleLarge?.copyWith(
        fontSize: 20,
        height: 1.2,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
      titleMedium: body.titleMedium?.copyWith(
        fontSize: 16,
        height: 1.25,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      titleSmall: body.titleSmall?.copyWith(
        fontSize: 14,
        height: 1.3,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),

      // --- Body --------------------------------------------------------------
      bodyLarge: body.bodyLarge?.copyWith(
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
      ),
      bodyMedium: body.bodyMedium?.copyWith(
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      bodySmall: body.bodySmall?.copyWith(
        fontSize: 12,
        height: 1.45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
      ),

      // --- Label: buttons, chips, overlines ---------------------------------
      labelLarge: body.labelLarge?.copyWith(
        fontSize: 14,
        height: 1.2,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
      labelMedium: body.labelMedium?.copyWith(
        fontSize: 12,
        height: 1.2,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      labelSmall: body.labelSmall?.copyWith(
        fontSize: 11,
        height: 1.2,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
      ),
    );
  }

  /// All-caps, wide-tracked overline used for eyebrow labels above headings.
  static TextStyle overline(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 1.6,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );
  }
}
