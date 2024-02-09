import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class RecordMyVoice extends StatefulWidget {
  const RecordMyVoice({super.key});

  @override
  State<RecordMyVoice> createState() => _RecordMyVoiceState();
}

class _RecordMyVoiceState extends State<RecordMyVoice> {
  final record = FlutterSoundRecorder();

  late AudioPlayer audio;
  late final RecorderController recorderController;
  void _initialiseController() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 16000;
  }

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
    _initialiseController();
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
                    await recorderController.record();
                    setState(() {});
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
        // AudioWaveforms(
        //   size: Size(MediaQuery.of(context).size.width, 200.0),
        //   recorderController: recorderController,
        // ),
        AudioWaveforms(
          enableGesture: true,
          size: Size(MediaQuery.of(context).size.width / 2, 50),
          recorderController: recorderController,
          waveStyle: const WaveStyle(
            waveColor: Colors.white,
            extendWaveform: true,
            showMiddleLine: false,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: const Color(0xFF1E1B26),
          ),
          padding: const EdgeInsets.only(left: 18),
          margin: const EdgeInsets.symmetric(horizontal: 15),
        ),
        // IconButton(
        //     icon: const Icon(Icons.mic),
        //     tooltip: 'Start recording',
        //     onPressed: _startRecording)
      ],
    );
  }

  // void _startRecording() async {
  //   await recorderController.record(path);
  //   // update state here to, for eample, change the button's state
  // }
}
