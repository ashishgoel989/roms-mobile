import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rtl/ui/screens/resignation_advice/resignation_selfie_screen.dart';
import 'package:rtl/utils/helper/pref_utils.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import '../../../utils/helper/theme_manager.dart';

class ResignationSignScreen extends StatelessWidget {

  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  ByteData? bytes;

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
            SizedBox(height: 15),
            Text(
              'Please sign below and we will\nprocess your application.',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            Container(
                child: SfSignaturePad(
                    key: signatureGlobalKey,
                    backgroundColor: Colors.white,
                    strokeColor: Colors.black,
                    minimumStrokeWidth: 1.0,
                    maximumStrokeWidth: 4.0),
                height: 180,
                margin: EdgeInsets.all(15),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Bounce(
                onPressed: () {
                  _handleClearButtonPressed();
                },
                duration: Duration(milliseconds: 110),
                child: Container(
                  child: Center(
                    child: Text(
                      'All Clear',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ThemeManager.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bounce(
        duration: Duration(milliseconds: 110),
        onPressed: () {
          Get.to(ResignationSelfieScreen());
        },
        child: Container(
          margin: EdgeInsets.only(right: 30, top: 10, bottom: 20, left: 30),
          height: 45,
          decoration: BoxDecoration(
            color: ThemeManager.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Continue',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              SizedBox(width: 5),
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
  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
    await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    bytes = await data.toByteData(format: ui.ImageByteFormat.png);
  }
}
