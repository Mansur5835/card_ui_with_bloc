import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ZoomWidget extends StatefulWidget {
  Widget child;

  ZoomWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<ZoomWidget> createState() => _ZoomWidgetState();
}

class _ZoomWidgetState extends State<ZoomWidget>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    controller = TransformationController();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            controller.value = animation!.value;
          });
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        clipBehavior: Clip.none,
        transformationController: controller,
        minScale: 1,
        maxScale: 5,
        onInteractionEnd: (details) {
          _resetAnimatioon();
        },
        child: widget.child);
  }

  _resetAnimatioon() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    animationController.forward(from: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    animationController.dispose();
  }
}
