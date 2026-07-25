import 'package:flutter/widgets.dart';

import 'package:gym_track/core/constants/breakpoints.dart';

/// Device size class derived from [Breakpoints].
enum DeviceType { mobile, tablet, desktop }

/// Helpers for building responsive UIs from [MediaQuery] / [BoxConstraints].
abstract final class Responsive {
  static DeviceType deviceTypeOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return deviceTypeForWidth(width);
  }

  static DeviceType deviceTypeForWidth(double width) {
    if (width >= Breakpoints.desktop) return DeviceType.desktop;
    if (width >= Breakpoints.tablet) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  static bool isMobile(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.desktop;

  /// Horizontal content padding that scales with viewport width.
  static double horizontalPadding(BuildContext context) {
    return switch (deviceTypeOf(context)) {
      DeviceType.mobile => 16,
      DeviceType.tablet => 24,
      DeviceType.desktop => 32,
    };
  }

  /// Max content width for readable layouts on large screens.
  static double maxContentWidth(BuildContext context) {
    return switch (deviceTypeOf(context)) {
      DeviceType.mobile => double.infinity,
      DeviceType.tablet => 720,
      DeviceType.desktop => 1100,
    };
  }
}
