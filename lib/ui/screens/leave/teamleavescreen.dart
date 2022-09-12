import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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

import '../../../controller/notification_controller.dart';
import '../../../utils/helper/pref_utils.dart';
import '../../../utils/helper/primary_button.dart';
import '../../../utils/utils.dart';

class TeamLeaveScreen extends StatefulWidget {
  String type;
  String eventID;

  TeamLeaveScreen(this.type, this.eventID);

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
  NotificationController _notificationController =
      Get.find<NotificationController>();

  int daycount = 0;

  String TypeID = '';

  String starttime = '--:--:--';
  String endtime = '--:--:--';
  late ScrollController _controller;
  List _leaveRequestList = [];
  var _isFirstLoadRunning = false.obs;
  var _hasNextPage = true.obs;
  var _isLoadMoreRunning = false.obs;
  var _page = 0.obs;
  late ScrollController _controllerHistory;
  List _leaveHistoryList = [];
  var _isFirstLoadRunningHistory = false.obs;
  var _hasNextPageHistory = true.obs;
  var _isLoadMoreRunningHistory = false.obs;
  var _limit = 10.obs;
  var _pageHistory = 0.obs;
  bool isFirstTime = true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _controller = ScrollController()..addListener(_loadMore);
    _controllerHistory = ScrollController()..addListener(_loadMoreHistory);

    _leaveController.GetTeamLeaveRequest(leaveHistorycallback, _page);
    _leaveController.GetTeamLeaveHistory(callback, _pageHistory);
    currentDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.now().add(Duration(days: selectDay - 1)));
    convertdate = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(Duration(days: selectDay - 1)));
    endDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.now().add(Duration(days: selectDay - 1)));
  }

  leaveHistorycallback(bool status, Map data) async {
    if (status == true) {
      if (_isFirstLoadRunning.value == true) {
        _leaveRequestList.addAll(data['data']);
        _isFirstLoadRunning.value = false;
      } else {
        _leaveRequestList.addAll(data['data']);
        _isLoadMoreRunning.value = false;
        if (_leaveRequestList.length >= data['totalElement']) {
          _hasNextPage.value = false;
        }
      }
      setState(() {});
    } else {
      // ToastUtils.setToast(data['message']);
    }
  }

  Approvecallback(bool status, Map data) async {
    if (status == true) {
      _leaveRequestList = [];
      _leaveHistoryList = [];
      Future.delayed(const Duration(milliseconds: 500), () {
        _leaveController.GetTeamLeaveRequest(leaveHistorycallback, _page.value);
        _leaveController.GetTeamLeaveHistory(callback, _pageHistory.value);
      });
    } else {
      Navigator.pop(context);
      Utils.showErrorToast(context, data['message']);
      // ToastUtils.setToast(data['message']);
    }
  }

  callback(bool status, Map data) async {
    if (status == true) {
      if (_isFirstLoadRunningHistory.value == true) {
        _leaveHistoryList.addAll(data['data']);
        _isFirstLoadRunningHistory.value = false;
      } else {
        _leaveHistoryList.addAll(data['data']);
        _isLoadMoreRunningHistory.value = false;
        if (_leaveHistoryList.length >= data['totalElement']) {
          _hasNextPageHistory.value = false;
        }
      }
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
          body: Column(
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
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
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
                    Obx(
                      () => Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView.builder(
                              controller: _controller,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _leaveRequestList.length,
                              itemBuilder: (BuildContext, index) {
                                return RequestRowView(index);
                              },
                            ),
                          ),
                          !_leaveController.isLoading.value
                              ? Container()
                              : Center(
                                  child: CircularProgressIndicator(
                                  color: ThemeManager.primaryColor,
                                ))
                        ],
                      ),
                    ),

                    // second tab bar view widget

                    Obx(
                      () => Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView.builder(
                              controller: _controllerHistory,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _leaveHistoryList.length,
                              itemBuilder: (BuildContext, index) {
                                return HistoryRowView(index);
                              },
                            ),
                          ),
                          !_leaveController.isLoading.value
                              ? Container()
                              : Center(
                                  child: CircularProgressIndicator(
                                  color: ThemeManager.primaryColor,
                                ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget RequestRowView(int index) {
    if (isFirstTime) {
      if (_leaveRequestList[index]['id'] == widget.eventID) {
        _controller.animateTo(index.toDouble() * 100,
            duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
        Timer(Duration(seconds: 1), () {
          showDetailsDialog(context, index, true);
        });
      }
      isFirstTime = false;
    }
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Container(
            color: _leaveRequestList[index]['id'] == widget.eventID
                ? ThemeManager.colorGreen.withOpacity(0.2)
                : ThemeManager.colorGrey.withOpacity(0.2),
            // : ThemeManager.colorGrey.withOpacity(0.2),
            child: Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.brightness_1, color: Colors.grey, size: 10),
                SizedBox(width: 15),
                _leaveRequestList[index]['employe']!['profileImage'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.memory(
                          Uint8List.fromList(Base64Decoder().convert(
                              _leaveRequestList[index]['employe']
                                  ['profileImage'])),
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/profile.png',
                          height: 40,
                        ),
                      ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          _leaveRequestList[index]['employe']['firstName']
                              .toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 12)),
                      Text(
                        _leaveRequestList[index]['employe']['jobTitle']!,
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
                    _leaveRequestList[index]['leaveType']['leaveDescription']!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
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
                  '${DateFormat('dd MMM').format(DateTime.parse(_leaveRequestList[index]['startDateTime'].toString()).toLocal()).replaceAll("T00:00:00Z", '')} to ${DateFormat('dd MMM').format(DateTime.parse(_leaveRequestList[index]['endDateTime'].toString()).toLocal()).replaceAll("T00:00:00Z", '')}    ${_leaveRequestList[index]['totalDay']} Day    ${DateFormat('HH:mm a').format(DateTime.parse(_leaveRequestList[index]['startDateTime']!).toLocal()).toLowerCase()} to ${DateFormat('HH:mm a').format(DateTime.parse(_leaveRequestList[index]['endDateTime']!).toLocal()).toLowerCase()}    ${_leaveRequestList[index]['totalHour']} Hrs',
                  style: TextStyle(color: Colors.black, fontSize: 10),
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
                          border: Border.all(color: Colors.green),
                          color: ThemeManager.colorWhite,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        'take action',
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
                          color: ThemeManager.colorGrey,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        _leaveRequestList[index]['leaveStatus'].toString() ==
                                "1"
                            ? 'Pending'
                            : _leaveRequestList[index]['leaveStatus']
                                        .toString() ==
                                    "2"
                                ? "Approved"
                                : "Rejected",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: _leaveHistoryList[index]['leaveStatus'] == 3
          ? Color(0xffF56D91).withOpacity(0.2)
          : Colors.green.withOpacity(0.2),
      child: Column(
        children: [
          Container(
            color: ThemeManager.colorGrey.withOpacity(0.2),
            child: Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.brightness_1,
                    color: _leaveHistoryList[index]['leaveStatus'] == 3
                        ? Colors.red
                        : Colors.green,
                    size: 10),
                SizedBox(width: 15),
                _leaveHistoryList[index]['employe']['profileImage'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.memory(
                          Uint8List.fromList(Base64Decoder().convert(
                              _leaveHistoryList[index]['employe']
                                  ['profileImage'])),
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/profile.png',
                          height: 40,
                        ),
                      ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          _leaveHistoryList[index]['employe']['firstName']
                              .toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 12)),
                      Text(
                        _leaveHistoryList[index]['employe']['jobTitle']
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
                    _leaveHistoryList[index]['leaveType']['leaveDescription']
                        .toString(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
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
                  '${DateFormat('dd MMM').format(DateTime.parse(_leaveHistoryList[index]['startDateTime'].toString()).toLocal()).replaceAll("T00:00:00Z", '')} to ${DateFormat('dd MMM').format(DateTime.parse(_leaveHistoryList[index]['endDateTime'].toString()).toLocal()).replaceAll("T00:00:00Z", '')}    ${_leaveHistoryList[index]['totalDay']} Day    ${DateFormat('HH:mm a').format(DateTime.parse(_leaveHistoryList[index]['startDateTime']!).toLocal()).toLowerCase()} to ${DateFormat('HH:mm a').format(DateTime.parse(_leaveHistoryList[index]['endDateTime']!).toLocal()).toLowerCase()}    ${_leaveHistoryList[index]['totalHour']} Hrs',
                  style: TextStyle(color: Colors.black, fontSize: 10),
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
                          border: Border.all(color: Colors.green),
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
                        _leaveHistoryList[index]['leaveStatus'].toString() ==
                                "1"
                            ? 'Pending'
                            : _leaveHistoryList[index]['leaveStatus']
                                        .toString() ==
                                    "2"
                                ? "Approved"
                                : "Rejected",
                        style: TextStyle(
                            color: _leaveHistoryList[index]['leaveStatus']
                                        .toString() ==
                                    "3"
                                ? ThemeManager.colorRed
                                : ThemeManager.secondaryColor,
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
                                  _leaveRequestList[index]['employe']
                                              ['profileImage'] !=
                                          null
                                      ? Image.memory(
                                          Uint8List.fromList(Base64Decoder()
                                              .convert(_leaveRequestList[index]
                                                  ['employe']['profileImage'])),
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
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
                                            _leaveRequestList[index]['employe']
                                                ['firstName']!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12)),
                                        Text(
                                          _leaveRequestList[index]['employe']
                                              ['jobTitle']!,
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
                                      _leaveRequestList[index]['leaveType']
                                          ['leaveDescription']!,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w800,
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
                                      '${DateFormat('dd MMM').format(DateTime.parse(_leaveRequestList[index]['startDateTime'].toString()).toLocal()).replaceAll("T00:00:00Z", '')} to ${DateFormat('dd MMM').format(DateTime.parse(_leaveRequestList[index]['endDateTime'].toString()).toLocal()).replaceAll("T00:00:00Z", '')}    ${_leaveRequestList[index]['totalDay']} Day    ${DateFormat('HH:mm a').format(DateTime.parse(_leaveRequestList[index]['startDateTime']!).toLocal()).toLowerCase()} to ${DateFormat('HH:mm a').format(DateTime.parse(_leaveRequestList[index]['endDateTime']!).toLocal()).toLowerCase()}    ${_leaveRequestList[index]['totalHour']} Hrs',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10),
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
                                    _leaveRequestList[index]['leaveReason']!,
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
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      textInputAction: TextInputAction.go,
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
                                          if (_leaveRequestList[index]['id'] ==
                                              widget.eventID) {
                                            _notificationController
                                                .deleteNotification(
                                                    _leaveRequestList[index]
                                                        ['id']);
                                          }
                                          var data =
                                              '{"id":"${_leaveRequestList[index]['id']}","reviewerRemark": "${_commentTextEditingController.text.toString()}"}';
                                          _leaveController.DeclineRequest(
                                                  data, Approvecallback)
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
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
                                          if (_leaveRequestList[index]['id'] ==
                                              widget.eventID) {
                                            _notificationController
                                                .deleteNotification(
                                                    _leaveRequestList[index]
                                                        ['id']);
                                          }
                                          var data =
                                              '{"id":"${_leaveRequestList[index]['id']}","reviewerRemark": "${_commentTextEditingController.text.toString()}"}';
                                          _leaveController.ApproveRequest(
                                                  data, Approvecallback)
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
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
                            color: _leaveHistoryList[index]['leaveStatus'] == 3
                                ? Color(0xffF5C8CE)
                                : Color(0xffcdf6d6),
                            borderRadius: BorderRadius.circular(5)),
                        height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: ThemeManager.colorBlack,
                                  ),
                                )),
                            SizedBox(height: 5),
                            Container(
                              color: ThemeManager.colorGrey.withOpacity(0.2),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(Icons.brightness_1,
                                      color: _leaveHistoryList[index]
                                                  ['leaveStatus'] ==
                                              3
                                          ? Colors.red
                                          : Colors.green,
                                      size: 10),
                                  SizedBox(width: 15),
                                  _leaveHistoryList[index]['employe']
                                              ['profileImage'] !=
                                          null
                                      ? Image.memory(
                                          Uint8List.fromList(Base64Decoder()
                                              .convert(_leaveHistoryList[index]
                                                  ['employe']['profileImage'])),
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
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
                                            _leaveHistoryList[index]['employe']
                                                ['firstName']!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12)),
                                        Text(
                                          _leaveHistoryList[index]['employe']
                                              ['jobTitle']!,
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
                                      _leaveHistoryList[index]['leaveType']
                                          ['leaveDescription']!,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w800,
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
                                      '${DateFormat('dd MMM').format(DateTime.parse(_leaveHistoryList[index]['startDateTime'].toString()).toLocal()).replaceAll("T00:00:00Z", '')} to ${DateFormat('dd MMM').format(DateTime.parse(_leaveHistoryList[index]['endDateTime'].toString()).toLocal()).replaceAll("T00:00:00Z", '')}    ${_leaveHistoryList[index]['totalDay']} Day    ${DateFormat('HH:mm a').format(DateTime.parse(_leaveHistoryList[index]['startDateTime']!).toLocal()).toLowerCase()} to ${DateFormat('HH:mm a').format(DateTime.parse(_leaveHistoryList[index]['endDateTime']!).toLocal()).toLowerCase()}    ${_leaveHistoryList[index]['totalHour']} Hrs',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Reason',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                        color: ThemeManager.colorBlack)),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    _leaveHistoryList[index]['leaveReason']!,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                )),
                            SizedBox(height: 10),
                            Container(
                              height: 30,
                              width: 100,
                              margin: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: ThemeManager.colorWhite,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                _leaveHistoryList[index]['leaveStatus']
                                            .toString() ==
                                        "1"
                                    ? 'Pending'
                                    : _leaveHistoryList[index]['leaveStatus']
                                                .toString() ==
                                            "2"
                                        ? "Approved"
                                        : "Rejected",
                                style: TextStyle(
                                    color: _leaveHistoryList[index]
                                                    ['leaveStatus']
                                                .toString() ==
                                            "3"
                                        ? ThemeManager.colorRed
                                        : ThemeManager.secondaryColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12),
                              )),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Comment',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                        color: ThemeManager.colorBlack)),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    _leaveHistoryList[index]
                                            ['reviewerRemark'] ??
                                        '',
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                )),
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

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning.value =
            true; // Display a progress indicator at the bottom
      });
      _page.value += 1; // Increase _page by 1
      print(_page);
      _leaveController.GetTeamLeaveRequest(leaveHistorycallback, _page.value);
    } else {
      print('jhfhfhgfh');
    }
  }

  void _loadMoreHistory() async {
    if (_hasNextPageHistory == true &&
        _isFirstLoadRunningHistory == false &&
        _isLoadMoreRunningHistory == false &&
        _controllerHistory.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunningHistory.value =
            true; // Display a progress indicator at the bottom
      });
      _pageHistory.value += 1; // Increase _page by 1
      print(_pageHistory);
      _leaveController.GetTeamLeaveHistory(callback, _pageHistory);
    } else {
      print('jhfhfhgfh');
    }
  }
}
