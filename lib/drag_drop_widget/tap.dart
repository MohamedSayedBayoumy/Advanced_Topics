import 'dart:developer';

import 'package:animation_example/animation/ainmation_algin.dart';
import 'package:flutter/material.dart';

class DraggableContainer extends StatefulWidget {
  const DraggableContainer({super.key});

  @override
  _DraggableContainerState createState() => _DraggableContainerState();
}

class _DraggableContainerState extends State<DraggableContainer> {
  double _containerHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: GestureDetector(
              onLongPressUp: () {
                _containerHeight = 60.0;
                setState(() {});
              },
              onLongPress: () {
                _containerHeight = 140.0;
                setState(() {});
                log("object");
              },
              onVerticalDragStart: (details) {
                log("message");
              },
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < 0.0) {
                  log("herrrrrrrrrrrrrrrrrrrr");
                  // عندما يكون المستخدم يسحب لأعلى
                  // قم بتنفيذ الإجراء الذي تريده هنا
                } else if (details.primaryDelta! > 0.0) {
                  log("noooooooooooooooooooooooo");
                  // عندما يكون المستخدم يسحب لأسفل
                  // يمكنك وضع الشفرة هنا لتنفيذ الإجراء المطلوب عند السحب لأسفل
                }
              },
              // onVerticalDragUpdate: (details) {
              //   if (_containerHeight > 200 && details.delta.dy < 0) {
              //     return;
              //   }
              //   setState(() {
              //     _containerHeight -= details.delta.dy;
              //   });
              // },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedContainer(
                    height: _containerHeight,
                    width: 60,
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.only(
                        bottom: _containerHeight == 60.0 ? 0.0 : 10.0),
                    alignment: _containerHeight == 60.0
                        ? AlignmentDirectional.center
                        : AlignmentDirectional.bottomCenter,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.mic),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
