import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rtl/ui/screens/resignation_advice/resignation_three_screen.dart';
import 'package:rtl/utils/helper/pref_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/helper/theme_manager.dart';

class ResignationTwoScreen extends StatelessWidget {
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
              'We will be sad to loose you, ${PrefUtils.getFirstName()} !',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Would you like to talk to our\nHR personnel about this\nbefore you make your\nfinal decision ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
            ),
            Text(
              'This process will take less than 1 min to complete',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          InkWell(
            onTap: () async {
              const url = "tel:+61 987654321";
              if (await canLaunch(url)) {
              await launch(url);
              } else {
              throw 'Could not launch $url';
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 30, top: 10, bottom: 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 45,
              decoration: BoxDecoration(
                color: ThemeManager.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text('Call HR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Bounce(
              onPressed: () {
                Get.to(ResignationThreeScreen());
              },
              duration: Duration(milliseconds: 110),
              child: Container(
                margin:
                    EdgeInsets.only(right: 30, top: 10, bottom: 20, left: 20),
                height: 45,
                decoration: BoxDecoration(
                  color: ThemeManager.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No, Continue',
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
          ),
        ],
      ),
    );
  }
}
