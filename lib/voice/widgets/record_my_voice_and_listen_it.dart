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

  PlayerController? playerController;

  File? fileRecord;

  void _initialiseController2() {
    playerController = PlayerController();
  }

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
    _initialiseController2();

    _initialiseController();
    setState(() {});
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
                    // await playerController.startPlayer();
                    setState(() {});
                  } else {
                    await stop();
                    await recorderController.pause();
                    // await playerController.stopPlayer();
                  }

                  setState(() {});
                },
                child: Text(record.isRecording ? "Recording" : "Record Now"))),
        fileRecord != null
            ? Center(
                child: ElevatedButton(
                    onPressed: () async {
                      playerController!
                          .preparePlayer(path: fileRecord!.path)
                          .whenComplete(() async {
                        // audio.play(DeviceFileSource(fileRecord!.path));
                        playerController!.startPlayer();
                        // playerController!.
                      });
                      // recorderController.reset(); // remove
                    },
                    child: const Text("Listen")))
            : Container(),
        fileRecord != null
            ? Container(
                color: Colors.amber,
                child: AudioFileWaveforms(
                  enableSeekGesture: true,
                  size: const Size(300, 80),
                  playerController: playerController!,
                  backgroundColor: Colors.orange,
                  playerWaveStyle: PlayerWaveStyle(
                      seekLineColor: Colors.transparent,
                      spacing: 5,
                      backgroundColor: Colors.black,
                      fixedWaveColor: Colors.grey.shade300,
                      liveWaveColor: Colors.white,
                      waveCap: StrokeCap.round,
                      scaleFactor: 240.0),
                ),
              )
            : AudioWaveforms(
                enableGesture: true,
                size: const Size(80, 50),
                shouldCalculateScrolledPosition: true,
                recorderController: recorderController,
                waveStyle: WaveStyle(
                    waveColor: Colors.grey.shade300,
                    extendWaveform: true,
                    showMiddleLine: false,
                    scaleFactor: 50.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.only(left: 0),
                margin: const EdgeInsets.symmetric(horizontal: 0),
              ),
      ],
    );
  }

  // void _playandPause() async {
  //   final x = playerController.playerState;
  //   x == x.isPlaying
  //       ? await playerController.pausePlayer()
  //       : await playerController.startPlayer(finishMode: FinishMode.loop);
  // }
}
