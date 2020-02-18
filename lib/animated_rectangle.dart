import 'package:flutter/material.dart';

class AnimatedRectangle extends StatefulWidget {
  @override
  _AnimatedRectangleState createState() => _AnimatedRectangleState();
}

class _AnimatedRectangleState extends State<AnimatedRectangle>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..addListener(() => setState(() {}));

    animation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 150)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 150, end: 30)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 50.0,
        ),
      ],
    ).animate(animationController);

    animationController.forward();

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: animation.value,
      width: animation.value,
    );
  }
}
