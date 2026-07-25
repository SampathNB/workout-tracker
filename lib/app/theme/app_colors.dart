import 'package:flutter/material.dart';

/// GymTrack brand color tokens (Material 3 seed + accents).
abstract final class AppColors {
  /// Primary brand seed — deep athletic teal (not purple/cream AI defaults).
  static const Color seed = Color(0xFF0D7377);

  static const Color lightSurface = Color(0xFFF5F7F7);
  static const Color darkSurface = Color(0xFF0E1414);

  static const Color accent = Color(0xFFE85D04);
  static const Color success = Color(0xFF2A9D8F);
  static const Color warning = Color(0xFFE9C46A);
  static const Color danger = Color(0xFFE76F51);
}
