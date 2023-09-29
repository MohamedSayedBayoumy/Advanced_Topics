import 'package:animation_example/animation/ainmation_algin.dart';
import 'package:animation_example/responsive/check_portrait_or_landscap.dart';
import 'package:flutter/material.dart';
import 'animation/ainmation_rotation.dart';
import 'animation/ainmation_size.dart';
import 'animation/ainmation_switcher.dart';
import 'animation/animation_scale.dart';
import 'drag_drop_widget/drag_and_drop_screen.dart';
import 'models/topics_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TopicsModel> topics = [
    TopicsModel(
        topicName: "Check Portrat or LandScape View",
        topicPage: const CheckPortraitOrLandscapePage()),
    TopicsModel(
        topicName: "Animated Switcher",
        topicPage: const AnimatedSwitcherWidget()),
    TopicsModel(
        topicName: "Rotation Animation", topicPage: const RotationAnimation()),
    TopicsModel(
        topicName: "Scale Animation", topicPage: const ScaleAnimation()),
    TopicsModel(
        topicName: "Algin Animation", topicPage: const AlginAnimation()),
    TopicsModel(
      topicName: "Size Animation",
      topicPage: const SizeAnimation(),
    ),
    TopicsModel(
      topicName: "Drag and Drop Animation",
      topicPage: const DragAndDropExample(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TextButton(
              child: Text(topics[index].topicName),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => topics[index].topicPage)),
            ),
          ),
        ),
      ),
    );
  }
}
