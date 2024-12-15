import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:my_learning/Medwiz_batch_2/pages/chat_page.dart';

const apiKey = "AIzaSyA_eFBTgeFTOkS-Ah8gVHz_VN9_2TRqvLM";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarContrastEnforced: true,
    systemNavigationBarColor: Colors.transparent,
  ));
  Gemini.init(apiKey: apiKey);
  runApp(const MedWiz2App());
}

class MedWiz2App extends StatelessWidget {
  const MedWiz2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      home: ChatPage(),
    );
  }
}
