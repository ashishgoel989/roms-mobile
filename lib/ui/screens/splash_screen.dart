import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:rtl/utils/helper/pref_utils.dart';

import '../../controller/notification_controller.dart';
import '../../provider/provider/theme_provider.dart';
import 'dashboard/dashboard_screen.dart';
import 'intro/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NotificationController _notificationController =
      Get.find<NotificationController>();

  @override
  void initState() {
    super.initState();
    init();
    if (PrefUtils.getUserToken().isNotEmpty) {
      _notificationController.GetNotification(callback);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: Image.asset('assets/images/splash.gif'),
    );
  }

  Future init() async {
    const _duration = Duration(milliseconds: 5500);
    return Timer(_duration, navigateToPage);
  }

  Future<void> navigateToPage() async {
    print(PrefUtils.getUserToken());
    if (PrefUtils.getUserToken().isEmpty) {
      Get.offAll(Introscreen());
    } else {
      Get.offAll(DashboardScreen());
    }
  }

  callback(bool status, Map data) async {
    if (status == true) {
    } else {
      // ToastUtils.setToast(data['message']);
    }
  }
}
