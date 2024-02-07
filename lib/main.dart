import 'package:flutter/material.dart';

import 'untitled folder/views/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
            titleLarge: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
            bodyLarge: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
