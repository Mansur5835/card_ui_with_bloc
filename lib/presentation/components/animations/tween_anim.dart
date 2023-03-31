import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TweenAnim<T> extends StatelessWidget {
  T end;
  T begin;
  int duration;
  Curve? curve;
  Widget Function(T value) child;
  TweenAnim(
      {super.key,
      required this.child,
      required this.duration,
      required this.end,
      required this.begin,
      this.curve});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<T>(
        curve: curve ?? Curves.easeIn,
        duration: Duration(milliseconds: duration),
        tween: Tween(begin: begin, end: end),
        builder: (context, value, _) {
          return child(value);
        });
  }
}
