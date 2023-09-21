import 'package:animation_example/responsive/check_portrait_or_landscap.dart';
import 'package:flutter/material.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) => TextButton(
            child: Text(topics[index].topicName),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => topics[index].topicPage)),
          ),
        ),
      ),
    );
  }
}
