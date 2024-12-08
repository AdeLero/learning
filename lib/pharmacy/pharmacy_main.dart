import 'package:flutter/material.dart';
import 'package:my_learning/pharmacy/pages/loading_page.dart';

void main() {
  runApp(PharmacyApp());
}

class PharmacyApp extends StatelessWidget {
  const PharmacyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PharmacyApp',
      home: LoadingPage(),
    );
  }
}
