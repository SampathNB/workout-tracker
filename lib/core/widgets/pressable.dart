import 'package:flutter/material.dart';

import 'package:gym_track/app/theme/app_motion.dart';

/// Wraps a child with a subtle scale-down on press for tactile feedback.
///
/// Used by interactive design-system components (buttons, cards, chips) to give
/// GymTrack its responsive, athletic feel.
class Pressable extends StatefulWidget {
  const Pressable({
    required this.child,
    super.key,
    this.onTap,
    this.onLongPress,
    this.pressedScale = 0.96,
    this.enabled = true,
    this.borderRadius,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double pressedScale;
  final bool enabled;
  final BorderRadius? borderRadius;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _pressed = false;

  bool get _interactive =>
      widget.enabled && (widget.onTap != null || widget.onLongPress != null);

  void _setPressed(bool value) {
    if (!_interactive) return;
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.enabled ? widget.onTap : null,
      onLongPress: widget.enabled ? widget.onLongPress : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? widget.pressedScale : 1,
        duration: AppDurations.instant,
        curve: AppCurves.standard,
        child: widget.child,
      ),
    );
  }
}
