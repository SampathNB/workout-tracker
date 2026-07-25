import 'package:flutter/material.dart';

import 'package:gym_track/core/utils/responsive.dart';

/// Builds different subtrees for mobile / tablet / desktop breakpoints.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.mobile,
    super.key,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return switch (Responsive.deviceTypeOf(context)) {
      DeviceType.desktop => desktop ?? tablet ?? mobile,
      DeviceType.tablet => tablet ?? mobile,
      DeviceType.mobile => mobile,
    };
  }
}

/// Constrains child width and applies responsive horizontal padding.
class ResponsiveContent extends StatelessWidget {
  const ResponsiveContent({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.maxContentWidth(context);
    final padding = Responsive.horizontalPadding(context);

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: child,
        ),
      ),
    );
  }
}
