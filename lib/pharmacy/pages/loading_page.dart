import 'package:flutter/material.dart';
import 'package:my_learning/pharmacy/pages/login_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'lib/pharmacy/assets/images/Pebble_Pharmacy_Loading.png',
          fit: BoxFit.cover,
          height: double.maxFinite,
          width: double.maxFinite,
        ),
      ),
    );
  }
}
