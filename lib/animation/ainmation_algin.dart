import 'package:flutter/material.dart';

class AlginAnimation extends StatefulWidget {
  const AlginAnimation({super.key});

  @override
  State<AlginAnimation> createState() => _AlginAnimationState();
}

class _AlginAnimationState extends State<AlginAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<AlignmentGeometry>? alignment;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..forward();
    alignment = Tween<AlignmentGeometry>(
            begin: Alignment.bottomLeft, end: Alignment.topRight)
        .animate(CurvedAnimation(
            parent: animationController!, curve: Curves.easeInQuint));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AlignTransition(
            alignment: alignment!, child: const FlutterLogo(size: 100)),
      ),
    );
  }
}
