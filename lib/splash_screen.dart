import 'package:flutter/material.dart';
import 'dart:async';

import 'package:glass_plate/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen())); // Navigate to Home Screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFCFEFF),
      child: Center(
        child: Image.asset('assets/images/logo.png'), // Display your logo
      ),
    );
  }
}