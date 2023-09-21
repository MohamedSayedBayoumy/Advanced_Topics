import 'package:flutter/material.dart';

class ScaleAnimation extends StatefulWidget {
  const ScaleAnimation({super.key});

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? scale;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
        upperBound: 1,
        lowerBound: 0.2)
      ..forward();
    scale = CurvedAnimation(parent: animationController!, curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            ScaleTransition(scale: scale!, child: const FlutterLogo(size: 100)),
      ),
    );
  }
}
