import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class RecordMyVoice extends StatefulWidget {
  const RecordMyVoice({super.key});

  @override
  State<RecordMyVoice> createState() => _RecordMyVoiceState();
}

class _RecordMyVoiceState extends State<RecordMyVoice> {
  final record = FlutterSoundRecorder();

  late AudioPlayer audio;

  File? fileRecord;

  startRecord() async {
    await record.startRecorder(toFile: "audio");
  }

  Future stop() async {
    final path = await record.stopRecorder();
    fileRecord = File(path!);

    if (kDebugMode) {
      print("Record File is $fileRecord");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      audio = AudioPlayer();
      await record.openRecorder();
      record.setSubscriptionDuration(const Duration(milliseconds: 500));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "اسجل صوتي في التطيبق و بعدد الثواني",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        StreamBuilder<RecordingDisposition>(
          stream: record.onProgress,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final sec = snapshot.data!.duration.inSeconds % 60;
              final min = snapshot.data!.duration.inMinutes;
              return Text(
                "$min :$sec",
              );
            } else {
              return const Text(
                "00:00",
              );
            }
          },
        ),
        Center(
            child: ElevatedButton(
                onPressed: () async {
                  if (record.isRecording == false) {
                    await startRecord();
                  } else {
                    await stop();
                  }

                  setState(() {});
                },
                child: Text(record.isRecording ? "Recording" : "Record Now"))),
        fileRecord != null
            ? Center(
                child: ElevatedButton(
                    onPressed: () async {
                      audio.play(DeviceFileSource(fileRecord!.path));
                    },
                    child: const Text("Listen")))
            : Container(),
      ],
    );
  }
}
