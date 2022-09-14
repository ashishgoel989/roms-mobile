import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rtl/ui/screens/resignation_advice/resignation_advice_screen.dart';
import 'package:rtl/ui/screens/resignation_advice/resignation_selfie_screen.dart';
import 'package:rtl/utils/helper/pref_utils.dart';
import 'package:rtl/utils/utils.dart';

import '../../../utils/helper/theme_manager.dart';

class ResignationFiveScreen extends StatelessWidget {
  var endDate = ''.obs;
  dynamic imageFile;
  dynamic comment;

  ResignationFiveScreen(dynamic imageFile, dynamic comment) {
    this.imageFile = imageFile;
    this.comment = comment;
  }

  @override
  Widget build(BuildContext context) {
    print(imageFile);
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
              'When would you like to be your\nlast day ?',
              textAlign: TextAlign.start,
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
                    'My last working day will be :',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        fieldHintText: 'dd-mm-yyyy',
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: ThemeManager.primaryColor,
                                onPrimary: Colors.white,
                                onSurface: ThemeManager.colorBlack,
                                background: Colors.white,
                                onBackground: Colors.white,
                                onSecondary: Colors.white,
                              ),
                              dialogBackgroundColor: Colors.white,
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: ThemeManager.primaryColor,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030, 1),
                      ).then((value) {
                        endDate.value = DateFormat('yyyy-MM-dd').format(value!);
                      });
                    },
                    child: Obx(
                      ()=> Container(
                        width: double.infinity,
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ThemeManager.colorGrey)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  endDate.value.isNotEmpty
                                      ? DateFormat('dd/MM/yyyy')
                                          .format(DateTime.parse(endDate.value))
                                      : '--/--/----',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.calendar_month,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        child: Column(
          children: [
            Text(
              'Now we will ask you to digitally signed the\nresignation advice',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12),
            ),
            Bounce(
              duration: Duration(milliseconds: 110),
              onPressed: () {
                if(endDate.value.isNotEmpty) {
                  Get.to(ResignationAdviceScreen(imageFile, comment,endDate.value));
                }else{
                  Utils.showErrorToast(context, 'Please select last working day');
                }
              },
              child: Container(
                margin:
                    EdgeInsets.only(right: 30, top: 10, bottom: 20, left: 30),
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
          ],
        ),
      ),
    );
  }
}
