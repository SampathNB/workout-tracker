import 'package:flutter/material.dart';

import 'package:gym_track/app/theme/app_motion.dart';

/// Keeps every shell branch mounted (state preservation) while animating
/// fade + directional slide when the active index changes.
///
/// Used as GoRouter's [StatefulShellRoute.navigatorContainerBuilder].
class AnimatedBranchContainer extends StatefulWidget {
  const AnimatedBranchContainer({
    required this.currentIndex,
    required this.children,
    super.key,
  });

  final int currentIndex;
  final List<Widget> children;

  @override
  State<AnimatedBranchContainer> createState() =>
      _AnimatedBranchContainerState();
}

class _AnimatedBranchContainerState extends State<AnimatedBranchContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  late int _displayedIndex;
  int? _outgoingIndex;

  @override
  void initState() {
    super.initState();
    _displayedIndex = widget.currentIndex;
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.normal,
    )..value = 1;
    _configureTweens(forward: true);
    _controller.addStatusListener(_onStatus);
  }

  void _onStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && _outgoingIndex != null) {
      setState(() => _outgoingIndex = null);
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedBranchContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex == oldWidget.currentIndex) return;

    _outgoingIndex = oldWidget.currentIndex;
    _displayedIndex = widget.currentIndex;
    final forward = widget.currentIndex > oldWidget.currentIndex;
    _configureTweens(forward: forward);
    _controller.forward(from: 0);
  }

  void _configureTweens({required bool forward}) {
    _fade = CurvedAnimation(
      parent: _controller,
      curve: AppCurves.decelerate,
    );
    _slide = Tween<Offset>(
      begin: Offset(forward ? 0.04 : -0.04, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: AppCurves.decelerate),
    );
  }

  @override
  void dispose() {
    _controller
      ..removeStatusListener(_onStatus)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        for (var i = 0; i < widget.children.length; i++)
          _BranchSlot(
            key: ValueKey('branch-$i'),
            active: i == _displayedIndex,
            outgoing: i == _outgoingIndex,
            fade: _fade,
            slide: _slide,
            child: widget.children[i],
          ),
      ],
    );
  }
}

class _BranchSlot extends StatelessWidget {
  const _BranchSlot({
    required this.active,
    required this.outgoing,
    required this.fade,
    required this.slide,
    required this.child,
    super.key,
  });

  final bool active;
  final bool outgoing;
  final Animation<double> fade;
  final Animation<Offset> slide;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final onStage = active || outgoing;

    Widget content = child;
    if (active) {
      content = FadeTransition(
        opacity: fade,
        child: SlideTransition(position: slide, child: child),
      );
    } else if (outgoing) {
      content = FadeTransition(
        opacity: ReverseAnimation(fade),
        child: IgnorePointer(child: child),
      );
    }

    // Keep inactive branches mounted (state preserved) but offstage.
    return Offstage(
      offstage: !onStage,
      child: TickerMode(
        enabled: active,
        child: content,
      ),
    );
  }
}
