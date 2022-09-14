import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rtl/controller/leave_controller.dart';
import 'package:rtl/controller/resign_controller.dart';
import 'package:rtl/ui/screens/dashboard/dashboard_screen.dart';
import 'package:rtl/ui/screens/resignation_advice/resignation_confirm_screen.dart';
import 'package:rtl/utils/helper/pref_utils.dart';
import 'package:rtl/utils/helper/theme_manager.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

import '../../../utils/helper/primary_button.dart';
import '../../../utils/utils.dart';

class ResignationAdviceScreen extends StatefulWidget {
  dynamic imageFile;
  dynamic comment;
  dynamic lastworkingDate;

  ResignationAdviceScreen(dynamic imageFile, dynamic comment, dynamic lastworkingDate) {
    this.imageFile = imageFile;
    this.comment = comment;
    this.lastworkingDate = lastworkingDate;
  }

  @override
  _ResignationAdviceScreenState createState() =>
      _ResignationAdviceScreenState();
}

class _ResignationAdviceScreenState extends State<ResignationAdviceScreen>
    with SingleTickerProviderStateMixin {
  var managerName = ''.obs;
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  LeaveController _leaveController = Get.find<LeaveController>();
  final ResignController _resignController = Get.put(ResignController());

  final ImagePicker imagePicker = ImagePicker();
  XFile? _imageFile;

  ByteData? bytes;

  var signaturefile = File('').obs;

  @override
  void initState() {
    super.initState();
    print('advice' + widget.imageFile.path);
    _leaveController.GetManagerName(callbackManagerName);
  }

  callbackManagerName(bool status, Map data) async {
    if (status == true) {
      managerName.value = data['firstName'] + ' ' + data['lastName'];
    } else {
      // ToastUtils.setToast(data['message']);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Large
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
            height: double.infinity,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black54)),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/big_logo.png'),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Form',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 8),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Divider(
                                color: Colors.black54,
                                height: 1,
                              ),
                            ),
                            Text(
                              'Submitted via RTL mobile app',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 8),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Resignation Advice',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                          child: Text('Photograph',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700))),
                      Text(
                          'Date : ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 10)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: ThemeManager.colorGrey),
                        image: widget.imageFile != null
                            ? DecorationImage(
                                image: FileImage(File(widget.imageFile.path)),
                                fit: BoxFit.fill,
                              )
                            : null),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: Text('Name',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10))),
                      Expanded(
                          child: Text(
                              '${PrefUtils.getFirstName()} ${PrefUtils.getLastName()}',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10)))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text('Employee number',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10))),
                      Expanded(
                          child: Text(PrefUtils.getemployeeNo(),
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10)))
                    ],
                  ),
                  SizedBox(
                      height: widget.comment.toString().isNotEmpty ? 15 : 0),
                  Text(widget.comment,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 10)),
                  SizedBox(
                      height: widget.comment.toString().isNotEmpty ? 15 : 0),
                  Text(
                      'Please accept this resignation advice as notice of my intention to cease my employment with RTL Mining and Earthworks Ptv. Ltd.',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 10)),
                  SizedBox(height: bytes == null ? 30 : 0),
                  bytes == null
                      ? Text('Please sign below',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 14))
                      : Text(''),
                  SizedBox(height: 5),
                  InkWell(
                      onTap: () {
                        showSignatureDialog(context);
                      },
                      child: Container(
                        width: bytes == null ? 120 : null,
                        height: 60,
                        padding: EdgeInsets.all(bytes == null ? 5 : 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: bytes == null
                                    ? ThemeManager.colorGrey
                                    : Colors.white)),
                        child: bytes != null
                            ? Image.file(
                               File( signaturefile.value.path),
                                fit: BoxFit.fill,
                              )
                            : null,
                      )),
                  SizedBox(height: 5),
                  Text(
                    'Regards',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 10),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '${PrefUtils.getFirstName()} ${PrefUtils.getLastName()}',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 100,
            child: Column(
              children: [
                Center(
                    child: Text(
                  'This advice will be send to your manager, ${managerName.value}',
                  style: TextStyle(color: Colors.black54, fontSize: 10),
                )),
                Bounce(
                  duration: Duration(milliseconds: 110),
                  onPressed: () {
                    if(bytes!=null) {
                      _resignController.applyResignation(
                          context, widget.imageFile, signaturefile.value.path,
                          widget.lastworkingDate, widget.comment);
                    }else{
                      Utils.showErrorToast(context, 'Please write signature');
                    }
                    // Get.to(ResignationConfirmScreen());
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        right: 30, top: 10, bottom: 10, left: 30),
                    height: 45,
                    decoration: BoxDecoration(
                      color: ThemeManager.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Submit',
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
        ));
  }

  void captureImages() async {
    final selectedImages =
        await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = selectedImages!;
    });
  }

  void showSignatureDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              // Large
              child: Material(
                  type: MaterialType.transparency,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: 320,
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: Bounce(
                                  duration: Duration(milliseconds: 110),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: ThemeManager.primaryColor,
                                  ),
                                )),
                            Container(
                                child: SfSignaturePad(
                                    key: signatureGlobalKey,
                                    backgroundColor: Colors.white,
                                    strokeColor: Colors.black,
                                    minimumStrokeWidth: 1.0,
                                    maximumStrokeWidth: 4.0),
                                height: 180,
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey))),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Bounce(
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: ThemeManager.primaryColor),
                                    ),
                                  ),
                                  Bounce(
                                    duration: Duration(milliseconds: 110),
                                    onPressed: () {
                                      _handleSaveButtonPressed();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: ThemeManager.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            );
          },
        );
      },
    );
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    signaturefile.value = await writeToFile(bytes!);
    print("path>>>>>>>>>>>>>" + signaturefile.value.path);
    setState(() {});
  }

  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/signature.png';
    print(filePath); // file_01.tmp is dump file, can be anything
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }


}
