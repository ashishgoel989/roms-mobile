import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rtl/utils/helper/pref_utils.dart';

import '../../provider/provider/theme_provider.dart';
import 'dashboard/dashboard_screen.dart';
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
      ),
     bottomNavigationBar: Image.asset('assets/images/splash.gif'),
    );
  }

  Future init() async {
    const _duration = Duration(milliseconds: 8010);
    return Timer(_duration, navigateToPage);
  }

  Future<void> navigateToPage() async {
    print(PrefUtils.getUserToken());
    if (PrefUtils.getUserToken().isEmpty) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Introscreen()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
          (Route<dynamic> route) => false);
    }
  }
}
