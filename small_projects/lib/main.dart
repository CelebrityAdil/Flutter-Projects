import 'package:flutter/material.dart';
import 'package:small_projects/DialogueAlert/alertdialog.dart';
import 'package:small_projects/language_translator/language_translation.dart';
import 'package:small_projects/scanqrcode/scanQrcode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter samll projects',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ScanQRCode(),
    );
  }
}
