import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class ActiveAssetsFromAssets extends StatefulWidget {
  const ActiveAssetsFromAssets({super.key});

  @override
  State<ActiveAssetsFromAssets> createState() => _ActiveAssetsFromAssetsState();
}

class _ActiveAssetsFromAssetsState extends State<ActiveAssetsFromAssets> {
  late AssetsAudioPlayer soundController;

  bool play = false;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      soundController = AssetsAudioPlayer();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "تشغيل صوت من ملف ال assets",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              if (play == false) {
                soundController.open(Audio("assets/k.mp3"));

                soundController.play();
                play = true;
              } else {
                soundController.pause();
                play = false;
              }
            },
            child: const Text("Sound"),
          ),
        ),
      ],
    );
  }
}
