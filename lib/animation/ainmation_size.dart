import 'package:flutter/material.dart';

class SizeAnimation extends StatefulWidget {
  const SizeAnimation({super.key});

  @override
  State<SizeAnimation> createState() => _SizeAnimationState();
}

class _SizeAnimationState extends State<SizeAnimation>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? sizeFactor;

  AnimationController? animationController2;
  Animation<double>? scale;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    sizeFactor = CurvedAnimation(
        parent: animationController!, curve: Curves.fastOutSlowIn);

    animationController2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    scale = CurvedAnimation(
        parent: animationController2!, curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                  onTap: () {
                    animationController!.forward().whenComplete(() {
                      animationController2!.forward();
                    });
                  },
                  child: const Text("data")),
            ),
            Expanded(
              child: SizeTransition(
                  sizeFactor: sizeFactor!,
                  axis: Axis.horizontal,
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: ScaleTransition(
                          scale: scale!,
                          child: const Icon(Icons.password),
                        ),
                        focusedBorder: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder()),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
