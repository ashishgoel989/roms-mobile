import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rtl/controller/leave_controller.dart';
import 'package:rtl/ui/screens/dashboard/dashboard_screen.dart';
import 'package:rtl/utils/helper/theme_manager.dart';

import '../../../utils/helper/primary_button.dart';
import '../../../utils/utils.dart';

class TeamLeaveScreen extends StatefulWidget {
  @override
  _TeamLeaveScreenState createState() => _TeamLeaveScreenState();
}

class _TeamLeaveScreenState extends State<TeamLeaveScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  List<String> hourlist = [
    '1',
    '2',
    '3',
    '4',
    '6',
    '8',
  ];

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
  var selectType;
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
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _leaveController.GetTeamLeaveRequest(leaveHistorycallback);
    _leaveController.GetTeamLeaveHistory(callback);
    currentDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.now().add(Duration(days: selectDay - 1)));
    convertdate = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(Duration(days: selectDay - 1)));
    endDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.now().add(Duration(days: selectDay - 1)));
  }

  leaveHistorycallback(bool status, Map data) async {
    if (status == true) {
    } else {
      // ToastUtils.setToast(data['message']);
    }
  }

  Approvecallback(bool status, Map data) async {
    if (status == true) {
      Navigator.pop(context);
      _leaveController.GetTeamLeaveRequest(leaveHistorycallback);
      _leaveController.GetTeamLeaveHistory(callback);
    } else {
      Utils.showErrorToast(context, data['message']);
      // ToastUtils.setToast(data['message']);
    }
  }

  callback(bool status, Map data) async {
    if (status == true) {
    } else {
      // ToastUtils.setToast(data['message']);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
              'Team Leaves',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
            ),
          ),
          body: GetBuilder<LeaveController>(
              init: _leaveController,
              builder: (_orderController) {
                return Obx(
                  () => !_leaveController.isLoading.value
                      ? Column(
                          children: [
                            // give the tab bar a height [can change hheight to preferred height]
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: Color(0xffFFF8E3),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                // give the indicator a decoration (color and border radius)
                                indicatorColor: ThemeManager.primaryColor,
                                indicatorWeight: 3,
                                labelColor: ThemeManager.primaryColor,
                                unselectedLabelColor: Colors.black,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                                tabs: [
                                  Tab(
                                    text: 'Leave Requests',
                                  ),
                                  Tab(
                                    text: 'History',
                                  ),
                                ],
                              ),
                            ),
                            // tab bar view here
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // first tab bar view widget
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _leaveController
                                          .teamLeaveRequestList.length,
                                      itemBuilder: (BuildContext, index) {
                                        return RequestRowView(index);
                                      },
                                    ),
                                  ),

                                  // second tab bar view widget

                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _leaveController
                                          .teamLeaveHistoryList.length,
                                      itemBuilder: (BuildContext, index) {
                                        return HistoryRowView(index);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(
                              color: ThemeManager.primaryColor)),
                );
              })),
    );
  }

  Widget RequestRowView(int index) {
    String day = DateTime.parse(
            _leaveController.teamLeaveRequestList[index].endDateTime.toString())
        .difference(DateTime.parse(_leaveController
            .teamLeaveRequestList[index].startDateTime
            .toString()))
        .inDays
        .toString();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Container(
            color: ThemeManager.colorGrey.withOpacity(0.2),
            child: Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.brightness_1, color: Colors.grey, size: 10),
                SizedBox(width: 15),
                Image.asset(
                  'assets/images/profile.png',
                  height: 40,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          _leaveController
                              .teamLeaveRequestList[index].employe!.firstName
                              .toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 12)),
                      Text(
                        _leaveController
                            .teamLeaveRequestList[index].employe!.jobTitle!,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 10),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.deepPurpleAccent.withOpacity(0.2),
                  child: Center(
                      child: Text(
                    _leaveController.teamLeaveRequestList[index].leaveType!
                        .leaveDescription!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style:
                        TextStyle(color: Colors.deepPurpleAccent, fontSize: 10),
                  )),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              children: [
                Text(
                  '${DateFormat('dd MMM').format(DateTime.parse(_leaveController.teamLeaveRequestList[index].startDateTime.toString()).toLocal()).replaceAll("T00:00:00Z", '')} to ${DateFormat('dd MMM').format(DateTime.parse(_leaveController.teamLeaveRequestList[index].endDateTime.toString()).toLocal()).replaceAll("T00:00:00Z", '')}    ${_leaveController.teamLeaveRequestList[index].totalDay} Day  ${_leaveController.teamLeaveRequestList[index].totalHour} Hrs',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Bounce(
                    onPressed: () {
                      showDetailsDialog(context, index, true);
                    },
                    duration: Duration(milliseconds: 110),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: ThemeManager.colorWhite,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        'View Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 12),
                      )),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Bounce(
                    onPressed: () {
                      /*  Navigator.push(
                          context,
                          PageTransition(
                              child: ViewScheduleScreen(),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 900),
                              reverseDuration: (const Duration(milliseconds: 900))));*/
                    },
                    duration: Duration(milliseconds: 110),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: ThemeManager.secondaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        _leaveController.teamLeaveRequestList[index].leaveStatus
                                    .toString() ==
                                "1"
                            ? 'Pending'
                            : _leaveController
                                        .teamLeaveRequestList[index].leaveStatus
                                        .toString() ==
                                    "2"
                                ? "Approved"
                                : "Rejected",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 14),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget HistoryRowView(int index) {
    String day = DateTime.parse(
            _leaveController.teamLeaveHistoryList[index].endDateTime.toString())
        .difference(DateTime.parse(_leaveController
            .teamLeaveHistoryList[index].startDateTime
            .toString()))
        .inDays
        .toString();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: _leaveController.teamLeaveHistoryList[index].leaveStatus == 3
          ? Color(0xffF56D91).withOpacity(0.2)
          : Colors.white,
      child: Column(
        children: [
          Container(
            color: ThemeManager.colorGrey.withOpacity(0.2),
            child: Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.brightness_1, color: Colors.grey, size: 10),
                SizedBox(width: 15),
                Image.asset(
                  'assets/images/profile.png',
                  height: 40,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          _leaveController
                              .teamLeaveHistoryList[index].employe!.firstName
                              .toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 12)),
                      Text(
                        _leaveController
                            .teamLeaveHistoryList[index].employe!.jobTitle
                            .toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 10),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.deepPurpleAccent.withOpacity(0.2),
                  child: Center(
                      child: Text(
                    _leaveController
                        .teamLeaveHistoryList[index].leaveType!.leaveDescription
                        .toString(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style:
                        TextStyle(color: Colors.deepPurpleAccent, fontSize: 10),
                  )),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              children: [
                Text(
                  '${DateFormat('dd MMM').format(DateTime.parse(_leaveController.teamLeaveHistoryList[index].startDateTime.toString()).toLocal()).replaceAll("T00:00:00Z", '')} to ${DateFormat('dd MMM').format(DateTime.parse(_leaveController.teamLeaveHistoryList[index].endDateTime.toString()).toLocal()).replaceAll("T00:00:00Z", '')}    ${_leaveController.teamLeaveRequestList[index].totalDay} Day  ${_leaveController.teamLeaveHistoryList[index].totalHour} Hrs',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Bounce(
                    onPressed: () {
                      showDetailsRDialog(context, index, false);
                    },
                    duration: Duration(milliseconds: 110),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: ThemeManager.colorWhite,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        'View Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 12),
                      )),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Bounce(
                    onPressed: () {},
                    duration: Duration(milliseconds: 110),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: ThemeManager.colorWhite,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        _leaveController.teamLeaveHistoryList[index].leaveStatus
                                    .toString() ==
                                "1"
                            ? 'Pending'
                            : _leaveController
                                        .teamLeaveHistoryList[index].leaveStatus
                                        .toString() ==
                                    "2"
                                ? "Approved"
                                : "Rejected",
                        style: TextStyle(
                            color: ThemeManager.secondaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 14),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  void showDetailsDialog(BuildContext context, int index, bool type) {
    String day = DateTime.parse(
            _leaveController.teamLeaveRequestList[index].endDateTime.toString())
        .difference(DateTime.parse(_leaveController
            .teamLeaveRequestList[index].startDateTime
            .toString()))
        .inDays
        .toString();
    final TextEditingController _commentTextEditingController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Large
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Material(
                  type: MaterialType.transparency,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        height: type == true ? 300 : 190,
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
                            SizedBox(height: 5),
                            Container(
                              color: ThemeManager.colorGrey.withOpacity(0.2),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(Icons.brightness_1,
                                      color: Colors.grey, size: 10),
                                  SizedBox(width: 15),
                                  Image.asset(
                                    'assets/images/profile.png',
                                    height: 40,
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            _leaveController
                                                .teamLeaveRequestList[index]
                                                .employe!
                                                .firstName!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12)),
                                        Text(
                                          _leaveController
                                              .teamLeaveRequestList[index]
                                              .employe!
                                              .jobTitle!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 100,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    color: Colors.deepPurpleAccent
                                        .withOpacity(0.2),
                                    child: Center(
                                        child: Text(
                                      _leaveController
                                          .teamLeaveRequestList[index]
                                          .leaveType!
                                          .leaveDescription!,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 10),
                                    )),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${DateFormat('dd MMM').format(DateTime.parse(_leaveController.teamLeaveHistoryList[index].startDateTime.toString()).toLocal()).replaceAll("T00:00:00Z", '')} to ${DateFormat('dd MMM').format(DateTime.parse(_leaveController.teamLeaveHistoryList[index].endDateTime.toString()).toLocal()).replaceAll("T00:00:00Z", '')}    ${_leaveController.teamLeaveRequestList[index].totalDay} Day  ${_leaveController.teamLeaveHistoryList[index].totalHour} Hrs',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                        color: ThemeManager.colorGrey)),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    _leaveController.teamLeaveRequestList[index]
                                        .leaveReason!,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                )),
                            SizedBox(height: 20),
                            Visibility(
                              visible: type,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                        color: ThemeManager.colorGrey)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                      controller: _commentTextEditingController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                          color: ThemeManager.colorBlack,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                      decoration: InputDecoration(
                                          hintText: 'Comment',
                                          hintStyle: TextStyle(
                                              color: ThemeManager.colorBlack,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700),
                                          border: InputBorder.none)),
                                ),
                              ),
                            ),
                            Visibility(
                                visible: type, child: SizedBox(height: 20)),
                            Visibility(
                              visible: type,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Bounce(
                                        onPressed: () {
                                          var data =
                                              '{"id":"${_leaveController.teamLeaveRequestList[index].id}","reviewerRemark": "${_commentTextEditingController.text.toString()}"}';
                                          _leaveController.DeclineRequest(
                                              data, Approvecallback);
                                          //showDetailsDialog(context);
                                        },
                                        duration: Duration(milliseconds: 110),
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: ThemeManager.colorRed,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                            'Decline',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12),
                                          )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Bounce(
                                        onPressed: () {
                                          var data =
                                              '{"id":"${_leaveController.teamLeaveRequestList[index].id}","reviewerRemark": "${_commentTextEditingController.text.toString()}"}';
                                          _leaveController.ApproveRequest(
                                              data, Approvecallback);
                                          /*  Navigator.push(
                              context,
                              PageTransition(
                                  child: ViewScheduleScreen(),
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 900),
                                  reverseDuration: (const Duration(milliseconds: 900))));*/
                                        },
                                        duration: Duration(milliseconds: 110),
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color:
                                                  ThemeManager.secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                            'Approve',
                                            style: TextStyle(
                                                color: ThemeManager.colorWhite,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 14),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ));
            },
          ),
        );
      },
    );
  }
  void showDetailsRDialog(BuildContext context, int index, bool type) {
    String day = DateTime.parse(
            _leaveController.teamLeaveHistoryList[index].endDateTime.toString())
        .difference(DateTime.parse(_leaveController
            .teamLeaveHistoryList[index].startDateTime
            .toString()))
        .inDays
        .toString();
    final TextEditingController _commentTextEditingController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Large
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Material(
                  type: MaterialType.transparency,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        height: type == true ? 300 : 190,
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
                            SizedBox(height: 5),
                            Container(
                              color: ThemeManager.colorGrey.withOpacity(0.2),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(Icons.brightness_1,
                                      color: Colors.grey, size: 10),
                                  SizedBox(width: 15),
                                  Image.asset(
                                    'assets/images/profile.png',
                                    height: 40,
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            _leaveController
                                                .teamLeaveHistoryList[index]
                                                .employe!
                                                .firstName!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12)),
                                        Text(
                                          _leaveController
                                              .teamLeaveHistoryList[index]
                                              .employe!
                                              .jobTitle!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 100,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    color: Colors.deepPurpleAccent
                                        .withOpacity(0.2),
                                    child: Center(
                                        child: Text(
                                      _leaveController
                                          .teamLeaveHistoryList[index]
                                          .leaveType!
                                          .leaveDescription!,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 10),
                                    )),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${DateFormat('dd MMM').format(DateTime.parse(_leaveController.teamLeaveHistoryList[index].startDateTime.toString()).toLocal()).replaceAll("T00:00:00Z", '')} to ${DateFormat('dd MMM').format(DateTime.parse(_leaveController.teamLeaveHistoryList[index].endDateTime.toString()).toLocal()).replaceAll("T00:00:00Z", '')}    ${_leaveController.teamLeaveHistoryList[index].totalDay} Day  ${_leaveController.teamLeaveHistoryList[index].totalHour} Hrs',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                        color: ThemeManager.colorGrey)),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    _leaveController.teamLeaveHistoryList[index]
                                        .leaveReason!,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                )),
                            SizedBox(height: 20),
                            Visibility(
                              visible: type,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                        color: ThemeManager.colorGrey)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                      controller: _commentTextEditingController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                          color: ThemeManager.colorBlack,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                      decoration: InputDecoration(
                                          hintText: 'Comment',
                                          hintStyle: TextStyle(
                                              color: ThemeManager.colorBlack,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700),
                                          border: InputBorder.none)),
                                ),
                              ),
                            ),
                            Visibility(
                                visible: type, child: SizedBox(height: 20)),
                            Visibility(
                              visible: type,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Bounce(
                                        onPressed: () {
                                          var data =
                                              '{"id":"${_leaveController.teamLeaveHistoryList[index].id}","reviewerRemark": "${_commentTextEditingController.text.toString()}"}';
                                          _leaveController.DeclineRequest(
                                              data, Approvecallback);
                                          //showDetailsDialog(context);
                                        },
                                        duration: Duration(milliseconds: 110),
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: ThemeManager.colorRed,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                            'Decline',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12),
                                          )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Bounce(
                                        onPressed: () {
                                          var data =
                                              '{"id":"${_leaveController.teamLeaveHistoryList[index].id}","reviewerRemark": "${_commentTextEditingController.text.toString()}"}';
                                          _leaveController.ApproveRequest(
                                              data, Approvecallback);
                                          /*  Navigator.push(
                              context,
                              PageTransition(
                                  child: ViewScheduleScreen(),
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 900),
                                  reverseDuration: (const Duration(milliseconds: 900))));*/
                                        },
                                        duration: Duration(milliseconds: 110),
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color:
                                                  ThemeManager.secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                            'Approve',
                                            style: TextStyle(
                                                color: ThemeManager.colorWhite,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 14),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ));
            },
          ),
        );
      },
    );
  }
}
