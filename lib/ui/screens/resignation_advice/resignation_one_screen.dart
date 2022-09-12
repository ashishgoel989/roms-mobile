import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:rtl/ui/screens/resignation_advice/resignation_two_screen.dart';
import 'package:rtl/utils/helper/pref_utils.dart';

import '../../../utils/helper/theme_manager.dart';

class ResignationOneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  'Hey ${PrefUtils.getFirstName()},\nWe are sad to hear this !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
            ),
            Text(
              'Do you really want to resign from your current position in RTL?',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Bounce(
        duration: Duration(milliseconds: 110),
        onPressed: () {
          Get.to(ResignationTwoScreen());
        },
        child: Container(
          margin: EdgeInsets.all(30),
          height: 45,
          decoration: BoxDecoration(
            color: ThemeManager.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Yes, Continue',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              SizedBox(width: 15),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
