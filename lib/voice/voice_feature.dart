// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'widgets/active_sound_from_assets.dart';
import 'widgets/local_record.dart';
import 'widgets/record_my_voice_and_listen_it.dart';

class RecordFeature extends StatefulWidget {
  const RecordFeature({super.key});

  @override
  State<RecordFeature> createState() => _RecredFeatureState();
}

class _RecredFeatureState extends State<RecordFeature> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LocalRecord(),
          Divider(color: Colors.black, height: 5),
          RecordMyVoice(),
          Divider(color: Colors.black, height: 5),
          ActiveAssetsFromAssets()
        ],
      ),
    );
  }

  Future<void> checkCameraPermission() async {
    var status = await Permission.microphone.request();

    if (status.isGranted) {
      showPermissionStatus('permission is granted!');
    } else {
      status = await Permission.microphone.status;
      if (status.isGranted) {
        showPermissionStatus('permission is granted!');
      } else {
        showPermissionStatus('permission is denied.');
      }
    }
  }

  void showPermissionStatus(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
