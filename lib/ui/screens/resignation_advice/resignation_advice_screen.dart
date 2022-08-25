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

class ResignationAdviceScreen extends StatefulWidget {
  ResignationAdviceScreen();

  @override
  _ResignationAdviceScreenState createState() =>
      _ResignationAdviceScreenState();
}

class _ResignationAdviceScreenState extends State<ResignationAdviceScreen>
    with SingleTickerProviderStateMixin {
  List<String> daylist = [
    'Yesterday',
    'Today',
    'Tomorrow',
    'Day After',
    'This Friday',
    'Next Monday',
  ];

  List<String> typelist = [
    'Sick',
    'Rostered Day Off',
    'Carer\'s',
    'Annual',
    'Without Pay',
    'Bereavement',
  ];

  List<String> namelist = [
    'Sick',
    'Rostered Day Off',
    'Carer\'s',
    'Annual',
    'Without Pay',
    'Bereavement',
  ];

  List<String> hourlist = [
    '1',
    '2',
    '3',
    '4',
    '6',
    '8',
  ];
  final TextEditingController _commentTextEditingController =
      TextEditingController();

  List<Color> colorlist = [
    Color(0xff764AF1),
    Color(0xff947EC3),
    Color(0xffF56D91),
    Color(0xff764AF1),
    Color(0xff947EC3),
    Color(0xffF56D91),
    Color(0xff764AF1),
    Color(0xff947EC3),
    Color(0xffF56D91),
    Color(0xff764AF1),
    Color(0xff947EC3),
    Color(0xffF56D91),
  ];

  var selectDay = 1;
  var selectType = 0;
  var selectedHours = '0';
  var selectDuration;

  String currentDate = '--/--/--';
  String convertdate = '';
  String endDate = '--/--/--';
  LeaveController _leaveController = Get.find<LeaveController>();

  int daycount = 0;

  String TypeID = '';

  String starttime = '--:--:--';
  String endtime = '--:--:--';

  @override
  void initState() {
    super.initState();
    //_leaveController.GetLeaveType(leaveTypecallback);
    //_leaveController.GetLeaveHistory(leaveHistorycallback);
    currentDate = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(Duration(days: selectDay - 1)));
    convertdate = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(Duration(days: selectDay - 1)));
    endDate = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(Duration(days: selectDay - 1)));
  }

  leaveTypecallback(bool status, Map data) async {
    if (status == true) {
    } else {
      // ToastUtils.setToast(data['message']);
    }
  }

  leaveHistorycallback(bool status, Map data) async {
    if (status == true) {
      TypeID = _leaveController.leavetypeList[0].id.toString();
    } else {
      // ToastUtils.setToast(data['message']);
    }
  }

  callback(bool status, Map data) async {
    if (status == true) {
      showSuccessDialog(context);
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
            appBar: AppBar(
              backgroundColor: Color(0xffFFF8E3),
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Text(
                'Resignation Advice',
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
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: Text('Name',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12))),
                          Expanded(
                              child: Text('Matthew Mcconaughey',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text('Employee number',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12))),
                          Expanded(
                              child: Text('RTL1199',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)))
                        ],
                      ),
                      SizedBox(height: 5),
                      Divider(color: ThemeManager.colorGrey),
                      SizedBox(height: 5),
                      Text(
                          'Please accept this resignation advice as notice of my intention to cease my employment with RTL Mining and Earthworks Ptv. Ltd.',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                      SizedBox(height: 30),
                      Text('Photograph',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                'Take a selfie',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: ThemeManager.colorGrey)),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Text('Signature',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                'Add Signature',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: ThemeManager.colorGrey)),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                          child: Text(
                        'Date : ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      )),
                      SizedBox(height: 20),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: ThemeManager.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('RESIGN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  )),
            )));
  }

  Widget dayrowView(int index) {
    return Bounce(
      onPressed: () {
        selectDay = index;
        _leaveController.update();
      },
      duration: Duration(milliseconds: 110),
      child: Container(
        height: 70,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
            color: selectDay == index
                ? Color(0xffA760FF)
                : colorlist[index].withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          daylist[index],
          style: TextStyle(
              color: selectDay == index ? Colors.white : colorlist[index],
              fontSize: 12),
        )),
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Material(
                type: MaterialType.transparency,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: 250,
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: Bounce(
                                duration: Duration(milliseconds: 110),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: DashboardScreen(),
                                          type: PageTransitionType.fade,
                                          duration:
                                              const Duration(milliseconds: 900),
                                          reverseDuration: (const Duration(
                                              milliseconds: 900))));
                                },
                                child: Icon(
                                  Icons.close,
                                  color: ThemeManager.primaryColor,
                                ),
                              )),
                          Container(
                            // height: 100,
                            width: 500,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Image.asset(
                              'assets/images/leave_success.png',
                              height: 80,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Leave request sent\nto the manager',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ThemeManager.primaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 60.0),
                            child: PrimaryButton(
                                buttonText: 'Close',
                                onButtonPressed: () {
                                  //  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: DashboardScreen(),
                                          type: PageTransitionType.fade,
                                          duration:
                                              const Duration(milliseconds: 900),
                                          reverseDuration: (const Duration(
                                              milliseconds: 900))));
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
}
