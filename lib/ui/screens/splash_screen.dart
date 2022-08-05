import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider/theme_provider.dart';
import 'intro/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Image.asset(
          "assets/images/logo.png",
          height: 150,
        )) /* add child content here */,
      ),
    );
  }

  Future init() async {
    const _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigateToPage);
  }

  Future<void> navigateToPage() async {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Introscreen()),
        (Route<dynamic> route) => false);
  }
}
