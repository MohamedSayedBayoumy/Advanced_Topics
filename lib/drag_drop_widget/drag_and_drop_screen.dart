import 'package:flutter/material.dart';

class DragAndDropExample extends StatefulWidget {
  const DragAndDropExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DragAndDropExampleState createState() => _DragAndDropExampleState();
}

class _DragAndDropExampleState extends State<DragAndDropExample>
    with SingleTickerProviderStateMixin {
  List<String> draggableItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3',
    'Item 3'
  ];
  List<String> droppedItems = [];

  AnimationController? animationController;
  Animation<double>? scale;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
        upperBound: 1,
        lowerBound: 0.9)
      ..forward();

    scale =
        CurvedAnimation(parent: animationController!, curve: Curves.easeInExpo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: draggableItems
                  .map((item) => Draggable<String>(
                        data: item,
                        feedback: DragItem(item: item, feedback: true),
                        childWhenDragging: Container(),
                        child: DragItem(item: item),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          DragTarget<String>(
            onAccept: (data) {
              animationController!
                  .reverse()
                  .whenComplete(() => animationController!.forward());

              setState(() {
                draggableItems.remove(data);
                droppedItems.add(data);
              });
            },
            builder: (context, candidateData, rejectedData) {
              return ScaleTransition(
                scale: scale!,
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.blueGrey,
                  child: const Center(
                    child: Text('Drop Here'),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text('Dropped Items: ${droppedItems.join(', ')}'),
        ],
      ),
    );
  }
}

class DragItem extends StatelessWidget {
  final String item;
  final bool feedback;

  const DragItem({super.key, required this.item, this.feedback = false});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: feedback ? 0.5 : 1.0,
      child: Container(
        width: 80,
        height: 80,
        color: Colors.lightBlue,
        child: Center(
          child: Text(
            item,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
