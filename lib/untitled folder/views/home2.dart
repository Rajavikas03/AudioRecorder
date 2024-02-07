// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.black,
//         textTheme: const TextTheme(
//             titleLarge: TextStyle(
//                 color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
//             bodyLarge: TextStyle(
//                 color: Colors.white,
//                 fontSize: 25,
//                 fontWeight: FontWeight.w600)),
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Audio App'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initstate() {
//     super.initState();
//     initRecorder();
//   }

//   @override
//   void disspose() {
//     recorder.closeRecorder();
//     super.dispose();
//   }

//   Future initRecorder() async {
//     final status = await Permission.microphone.request();

//     if (status != PermissionStatus.granted) {
//       throw 'Microphone permission not granted';
//     }
//     await recorder.openRecorder();
//     print(' Start recording ${recorder.isRecording}');
//     isRecording = true;

//     recorder.setSubscriptionDuration(
//       const Duration(microseconds: 500),
//     );
//   }

//   // final recorder = FlutterSoundRecorder;
//   FlutterSoundRecorder recorder = FlutterSoundRecorder();
//   bool isRecording = false;
//   Future record() async {
//     if (!isRecording) return;
//     await recorder.startRecorder(toFile: "www.example.com");
//   }

//   Future stop() async {
//     if (isRecording) return;
//     print(" stop recording ${recorder.isRecording}");
//     final path = await recorder.stopRecorder();
//     final audioFile = File(path!);

//     print('Record audio: $audioFile');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title:
//             Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
//         centerTitle: true,
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           StreamBuilder(
//               stream: recorder.onProgress,
//               builder: (context, snapshot) {
//                 final duration =
//                     snapshot.hasData ? snapshot.data!.duration : Duration.zero;
//                 String twoDigit(int n) => n.toString();
//                 final twoDigitMinutes =
//                     twoDigit(duration.inMinutes.remainder(60));
//                 final twoDigitSeconds =
//                     twoDigit(duration.inSeconds.remainder(60));
//                 return Text(' $twoDigitMinutes:$twoDigitSeconds ',
//                     style: Theme.of(context).textTheme.bodyLarge);
//               }),
//           ElevatedButton(
//               onPressed: () async {
//                 if (recorder.isRecording) {
//                   print('stop recording ${recorder.isRecording}');
//                   await stop();
//                 } else {
//                   print("start recording ${recorder.isRecording}");
//                   await record();
//                 }
//                 setState(() {
//                   isRecording = true;
//                   // print(recorder.isRecording);
//                 });
//               },
//               child: Icon(recorder.isRecording ? Icons.stop : Icons.mic)),
//         ],
//       )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
