import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class LocalRecord extends StatefulWidget {
  const LocalRecord({super.key});

  @override
  State<LocalRecord> createState() => _LocalRecordState();
}

class _LocalRecordState extends State<LocalRecord> {
  late AudioPlayer audio;

  String? filePath;

  @override
  void initState() {
    super.initState();
    audio = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "اجيب ملف صوتي و ارجع اشغله",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () async {
            await pickFile();
          },
          child: const Text('اختيار الملف'),
        ),
        if (filePath != null)
          ElevatedButton(
            onPressed: () {
              audio.play(DeviceFileSource(filePath!));
            },
            child: const Text('تشغيل الصوت'),
          ),
      ],
    );
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null) {
      String? path = result.files.single.path;
      setState(() {
        filePath = path;
      });
    }
  }
}
