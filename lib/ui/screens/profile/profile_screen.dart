import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rtl/controller/leave_controller.dart';
import 'package:rtl/ui/screens/dashboard/dashboard_screen.dart';
import 'package:rtl/utils/helper/theme_manager.dart';

import '../../../utils/helper/primary_button.dart';
import '../../../utils/utils.dart';
import '../resignation_advice/resignation_advice_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  var selectDay = 1;
  var selectType = 0;
  var selectedHours = '0';
  var selectDuration;

  String currentDate = '--/--/--';
  String convertdate = '';
  String endDate = '--/--/--';
  LeaveController _leaveController = Get.find<LeaveController>();

  int daycount = 1;

  String TypeID = '';

  String starttime = '--:--:--';
  String endtime = '--:--:--';

  @override
  void initState() {
    super.initState();
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
            appBar: AppBar(
              backgroundColor: Color(0xffFFF8E3),
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 16),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Matthew Mcconaughey',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'RTL1199',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 10),
                                    ),
                                    SizedBox(width: 40),
                                    Text(
                                      'Operator',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 10),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'YALLOURN',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          ClipOval(
                            child: Image.asset(
                              'assets/images/profile_image.png',
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.cake,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '25/08/1999',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                          ),
                          Icon(
                            Icons.transgender,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '25/08/1999',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.call,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Center(
                            child: Text(
                              '+61 987654321',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.mail,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Center(
                            child: Text(
                              'mmathew@rtl.com.au',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Divider(
                        color: ThemeManager.colorBlack,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'My Services',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  'Service 1',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  'Service 2',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  'Service 3',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Bounce(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: ResignationAdviceScreen(),
                                        type: PageTransitionType.fade,
                                        duration:
                                            const Duration(milliseconds: 900),
                                        reverseDuration: (const Duration(
                                            milliseconds: 900))));
                              },
                              duration: Duration(milliseconds: 110),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent.shade100,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    'Apply Resign',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Switch(value: true, onChanged: (value) {}),
                          Flexible(
                            child: Text(
                              'I wish to receive my payslip in my E-mail stated above.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'My Achievements',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: ThemeManager.colorBlack)),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (BuildContext, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    '25/08/2022',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  )),
                                  Expanded(
                                      child: Text(
                                    'Won Best Employee Award',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ))
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
            )));
  }
}
