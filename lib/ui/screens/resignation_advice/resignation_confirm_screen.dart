import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:rtl/ui/screens/dashboard/dashboard_screen.dart';
import 'package:rtl/ui/screens/resignation_advice/resignation_two_screen.dart';
import 'package:rtl/utils/helper/pref_utils.dart';

import '../../../utils/helper/theme_manager.dart';

class ResignationConfirmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: (){
        Get.off(DashboardScreen());
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'We recognise your contribution\nin building RTL organisation to\nits current potential.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                ),
                Text(
                  'Our HR team will soon make a\nfollow up call regarding your\napplication.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          bottomNavigationBar: Image.asset(
            'assets/images/check.png',
            height: size.height * 0.3,
          )),
    );
  }
}
