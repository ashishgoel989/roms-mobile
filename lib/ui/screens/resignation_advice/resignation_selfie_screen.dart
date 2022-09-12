import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtl/ui/screens/resignation_advice/resignation_five_screen.dart';
import 'package:rtl/utils/helper/pref_utils.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/helper/theme_manager.dart';

class ResignationSelfieScreen extends StatelessWidget {
  final TextEditingController _commentTextEditingController =
      TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  var _imageFile = XFile('').obs;



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
              'Please authenticate yourself by\ntaking a selfie !',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            Spacer(),
            Bounce(
              duration: Duration(milliseconds: 110),
              onPressed: () {
                captureImages();
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: ThemeManager.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Take Selfie',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    SizedBox(width: 5),
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            )
          ],
        ),
      ),
      bottomNavigationBar: Bounce(
        duration: Duration(milliseconds: 110),
        onPressed: () {
          print(_imageFile.value.path);
          Get.to(ResignationFiveScreen(_imageFile.value.path));
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

  void captureImages() async {
    final selectedImages =
    await imagePicker.pickImage(source: ImageSource.camera);
      _imageFile.value = selectedImages!;
  }


}
