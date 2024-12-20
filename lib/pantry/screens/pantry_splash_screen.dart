import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_learning/pantry/screens/auth/pantry_sign_in.dart';

class PantrySplashScreen extends StatefulWidget {
  const PantrySplashScreen({super.key});

  @override
  State<PantrySplashScreen> createState() => _PantrySplashScreenState();
}

class _PantrySplashScreenState extends State<PantrySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PantrySignIn(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("lib/assets/images/Pantry_App_loading_screen.png"),
        ),
      ),
    );
  }
}
