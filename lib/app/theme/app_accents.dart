import 'package:flutter/material.dart';

import 'package:gym_track/app/theme/app_colors.dart';
import 'package:gym_track/app/theme/app_shadows.dart';

/// Theme extension exposing GymTrack's accent, semantic, gradient, and shadow
/// tokens that fall outside the standard Material [ColorScheme].
///
/// Access via `Theme.of(context).extension<AppAccents>()!` or the
/// `context.accents` convenience getter.
@immutable
class AppAccents extends ThemeExtension<AppAccents> {
  const AppAccents({
    required this.volt,
    required this.onVolt,
    required this.energy,
    required this.electric,
    required this.violet,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.danger,
    required this.onDanger,
    required this.dangerContainer,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.brandGradient,
    required this.voltGradient,
    required this.heroGradient,
    required this.shadowSm,
    required this.shadowMd,
    required this.shadowLg,
  });

  final Color volt;
  final Color onVolt;
  final Color energy;
  final Color electric;
  final Color violet;

  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color danger;
  final Color onDanger;
  final Color dangerContainer;
  final Color info;
  final Color onInfo;
  final Color infoContainer;

  final Gradient brandGradient;
  final Gradient voltGradient;
  final Gradient heroGradient;

  final List<BoxShadow> shadowSm;
  final List<BoxShadow> shadowMd;
  final List<BoxShadow> shadowLg;

  static final AppAccents light = AppAccents(
    volt: AppColors.voltDim,
    onVolt: AppColors.voltInk,
    energy: AppColors.energy,
    electric: AppColors.electric,
    violet: AppColors.violet,
    success: AppColors.success,
    onSuccess: AppColors.white,
    successContainer: const Color(0xFFDCFCE7),
    warning: AppColors.warning,
    onWarning: const Color(0xFF3D2A00),
    warningContainer: const Color(0xFFFEF3C7),
    danger: AppColors.danger,
    onDanger: AppColors.white,
    dangerContainer: const Color(0xFFFCE4E4),
    info: AppColors.info,
    onInfo: AppColors.white,
    infoContainer: const Color(0xFFDBEAFE),
    brandGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.ink, Color(0xFF2E2E33)],
    ),
    voltGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.voltBright, AppColors.volt],
    ),
    heroGradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF17171A), AppColors.ink],
    ),
    shadowSm: AppShadows.sm,
    shadowMd: AppShadows.md,
    shadowLg: AppShadows.lg,
  );

  static final AppAccents dark = AppAccents(
    volt: AppColors.volt,
    onVolt: AppColors.voltInk,
    energy: AppColors.energy,
    electric: AppColors.electric,
    violet: AppColors.violet,
    success: AppColors.successDark,
    onSuccess: const Color(0xFF00210F),
    successContainer: const Color(0xFF14351F),
    warning: AppColors.warningDark,
    onWarning: const Color(0xFF251A00),
    warningContainer: const Color(0xFF3A2D00),
    danger: AppColors.dangerDark,
    onDanger: const Color(0xFF3A0709),
    dangerContainer: const Color(0xFF3A1416),
    info: AppColors.infoDark,
    onInfo: const Color(0xFF001B33),
    infoContainer: const Color(0xFF13273A),
    brandGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.white, Color(0xFFD4D4D8)],
    ),
    voltGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.voltBright, AppColors.volt],
    ),
    heroGradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF1F1F23), AppColors.ink900],
    ),
    shadowSm: AppShadows.smDark,
    shadowMd: AppShadows.mdDark,
    shadowLg: AppShadows.lgDark,
  );

  @override
  AppAccents copyWith({
    Color? volt,
    Color? onVolt,
    Color? energy,
    Color? electric,
    Color? violet,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? danger,
    Color? onDanger,
    Color? dangerContainer,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Gradient? brandGradient,
    Gradient? voltGradient,
    Gradient? heroGradient,
    List<BoxShadow>? shadowSm,
    List<BoxShadow>? shadowMd,
    List<BoxShadow>? shadowLg,
  }) {
    return AppAccents(
      volt: volt ?? this.volt,
      onVolt: onVolt ?? this.onVolt,
      energy: energy ?? this.energy,
      electric: electric ?? this.electric,
      violet: violet ?? this.violet,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
      dangerContainer: dangerContainer ?? this.dangerContainer,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      infoContainer: infoContainer ?? this.infoContainer,
      brandGradient: brandGradient ?? this.brandGradient,
      voltGradient: voltGradient ?? this.voltGradient,
      heroGradient: heroGradient ?? this.heroGradient,
      shadowSm: shadowSm ?? this.shadowSm,
      shadowMd: shadowMd ?? this.shadowMd,
      shadowLg: shadowLg ?? this.shadowLg,
    );
  }

  @override
  AppAccents lerp(covariant ThemeExtension<AppAccents>? other, double t) {
    if (other is! AppAccents) return this;
    return AppAccents(
      volt: Color.lerp(volt, other.volt, t)!,
      onVolt: Color.lerp(onVolt, other.onVolt, t)!,
      energy: Color.lerp(energy, other.energy, t)!,
      electric: Color.lerp(electric, other.electric, t)!,
      violet: Color.lerp(violet, other.violet, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successContainer: Color.lerp(successContainer, other.successContainer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      onDanger: Color.lerp(onDanger, other.onDanger, t)!,
      dangerContainer: Color.lerp(dangerContainer, other.dangerContainer, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      brandGradient: Gradient.lerp(brandGradient, other.brandGradient, t)!,
      voltGradient: Gradient.lerp(voltGradient, other.voltGradient, t)!,
      heroGradient: Gradient.lerp(heroGradient, other.heroGradient, t)!,
      shadowSm: t < 0.5 ? shadowSm : other.shadowSm,
      shadowMd: t < 0.5 ? shadowMd : other.shadowMd,
      shadowLg: t < 0.5 ? shadowLg : other.shadowLg,
    );
  }
}

/// Convenience access to [AppAccents] from a [BuildContext].
extension AppAccentsX on BuildContext {
  AppAccents get accents => Theme.of(this).extension<AppAccents>()!;
}
