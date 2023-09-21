import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'home_page.dart';

Future<void> main() async {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Topics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: const HomePage(),
    );
  }
}
