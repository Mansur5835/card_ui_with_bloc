import 'package:flutter/material.dart';

class SlideAndOpasityAnimation extends StatefulWidget {
  final int opasityDuration;
  final int? slideDuration;
  final Widget child;
  final Offset? slideBegin;
  final Offset? slideEnd;
  final Curve? curve;

  const SlideAndOpasityAnimation(
      {Key? key,
      this.opasityDuration = 3500,
      this.slideDuration,
      this.curve,
      this.slideEnd,
      this.slideBegin,
      required this.child})
      : super(key: key);

  @override
  State<SlideAndOpasityAnimation> createState() =>
      _SlideAndApasityAnimationState();
}

class _SlideAndApasityAnimationState extends State<SlideAndOpasityAnimation>
    with TickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _animationController;

  bool _visible = false;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _animationController = AnimationController(
          vsync: this,
          duration: Duration(milliseconds: widget.slideDuration ?? 3000));
      _animation = Tween(
              begin: widget.slideBegin ??
                  const Offset(
                    0,
                    5,
                  ),
              end: widget.slideEnd ?? Offset.zero)
          .animate(CurvedAnimation(
              parent: _animationController,
              curve: widget.curve ?? Curves.easeOut));

      _animationController.forward();
      _visibleFunc();
    }
  }

  _visibleFunc() async {
    await Future.delayed(Duration(milliseconds: widget.opasityDuration));
    setState(() {
      _visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: widget.opasityDuration),
      opacity: _visible ? 1 : 0,
      child: SlideTransition(position: _animation, child: widget.child),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
