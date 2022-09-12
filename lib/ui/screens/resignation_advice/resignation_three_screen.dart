import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:rtl/ui/screens/resignation_advice/resignation_selfie_screen.dart';
import 'package:rtl/ui/screens/resignation_advice/resignation_sign_screen.dart';
import 'package:rtl/utils/helper/pref_utils.dart';

import '../../../utils/helper/theme_manager.dart';

class ResignationThreeScreen extends StatelessWidget {
  final TextEditingController _commentTextEditingController =
      TextEditingController();

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
              'We would like to hear about why you are resigning.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Will you like to write a reason?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ThemeManager.colorGrey)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                          controller: _commentTextEditingController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLines: 5,
                          style: TextStyle(
                              color: ThemeManager.colorBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                              hintText: 'Comments',
                              hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                              border: InputBorder.none)),
                    ),
                  )
                ],
              ),
            ),
            Text(
              'Skip',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ThemeManager.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
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
}
