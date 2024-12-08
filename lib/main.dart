import 'package:flutter/material.dart';
import 'package:my_learning/Medwiz/pages/chat_screen.dart';

void main() => runApp(new MedwizApp());

class MedwizApp extends StatelessWidget {
  const MedwizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
    );
  }
}
