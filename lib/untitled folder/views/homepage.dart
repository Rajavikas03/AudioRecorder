import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  final recorder = FlutterSoundRecorder();
  String twoDigitMinutes = " ";
  String twoDigitSeconds = " ";

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    final staus = await Permission.storage.request();
    print(staus.isGranted);
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecord() async {
    // Get the directory for storing app documents
    Directory appDocDir = await getTemporaryDirectory();

    // Specify the destination file path in the app's document directory
    String destFilePath = '${appDocDir.path}/.wav';
    final fill = await recorder.startRecorder(
      toFile: destFilePath,
      // audioSource:
    );
    setState(() {
      // recorder.isRecording=
    });
  }

//   Future stopRecorder() async {
//     // final filePath = await recorder.stopRecorder();
//     // final file = File(filePath!);
// //     import 'dart:io';
// // import 'package:path_provider/path_provider.dart';

// // Assume you have the file path stored in the 'filePath' variable
//     final filePath = await recorder.stopRecorder();
//     final file = File(filePath!);

// // Get the directory for the app's local storage
//     Directory appDocDir = await getApplicationDocumentsDirectory();

// // Specify the destination file path in the app's local storage
//     String destFilePath = '${appDocDir.path}/$file.wav';

//     try {
//       // Copy the file to local storage
//       await file.copy(destFilePath);

//       // File saved successfully
//       print('File saved to: $destFilePath');
//     } catch (e) {
//       // Handle errors, such as permission issues or file not found
//       print('Error saving file: $e');
//     }

//     // print(twoDigitMinutes);
//     // print(twoDigitSeconds);

//     // print('Recorded file path: $file');
//     setState(() {
//       // recorder.isRecording == true;
//       // twoDigitSeconds = "";
//       // twoDigitMinutes = " ";
//     });
//   }

  // Future stopRecorder() async {

  //   // Assume you have the file path stored in the 'filePath' variable
  //   final filePath = await recorder.stopRecorder();
  //   final file = File(filePath!);

  //   // Get the directory for storing temporary files
  //   Directory tempDir = await getTemporaryDirectory();

  //   // Specify the destination file path in the temporary directory
  //   String destFilePath = '${tempDir.path}/$file.wav';

  //   try {
  //     // Copy the file to the temporary directory
  //     await file.(destFilePath);

  //     // File saved successfully
  //     print('File saved to: $destFilePath');
  //   } catch (e) {
  //     // Handle errors, such as permission issues or file not found
  //     print('Error saving file: $e');
  //   }
  //   setState(() {
  //     twoDigitMinutes = " ";
  //     twoDigitSeconds = " ";
  //   });
  // }

  Future stopRecorder() async {
    // Assume you have the file path stored in the 'filePath' variable
    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);

    // Get the directory for storing app documents
    Directory appDocDir = await getTemporaryDirectory();

    // Specify the destination file path in the app's document directory
    String destFilePath = '${appDocDir.path}/.wav';

    try {
      // Copy the file to the document directory
      await file.copy(destFilePath);

      // File saved successfully
      print('File saved to: $destFilePath');
      // print(appDocDir);
      // print(file);
      // print(filePath);
    } catch (e) {
      // Handle errors, such as permission issues or file not found
      print('Error saving file: $e');
    }
    setState(() {
      twoDigitMinutes = " ";
      twoDigitSeconds = " ";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Audio recorder',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<RecordingDisposition>(
                builder: (context, snapshot) {
                  final duration = snapshot.hasData
                      ? snapshot.data!.duration
                      : Duration.zero;

                  String twoDigits(int n) => n.toString().padLeft(2, '0');

                  twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
                  twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

                  return Text(
                    '$twoDigitMinutes:$twoDigitSeconds',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
                stream: recorder.onProgress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (recorder.isRecording) {
                    await stopRecorder();
                    setState(() {
                      // recorder.isRecording = !recorder.isRecording;
                      // twoDigitMinutes = " ";
                      // twoDigitSeconds = " ";
                    });
                  } else {
                    await startRecord();
                    setState(() {
                      // twoDigitMinutes = " ";
                      // twoDigitSeconds = " ";
                    });
                  }
                },
                child: Icon(
                  recorder.isRecording ? Icons.stop : Icons.mic,
                  size: 100,
                  color: recorder.isRecording
                      ? Colors.red
                      : Colors.lightBlueAccent,
                ),
              ),
            ],
          ),
        ));
  }
}
