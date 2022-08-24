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

class LeaveScreen extends StatefulWidget {
  int tabindex;

  LeaveScreen(this.tabindex);

  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen>
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

  int daycount = 1;

  String TypeID = '';

  String starttime = '--:--:--';
  String endtime = '--:--:--';

  @override
  void initState() {
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.tabindex);
    super.initState();
    _leaveController.GetLeaveType(leaveTypecallback);
    _leaveController.GetLeaveHistory(leaveHistorycallback);
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
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Large
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffFFF8E3),
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              'My Leaves',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
            ),
          ),
          body: GetBuilder<LeaveController>(
              init: _leaveController,
              builder: (_orderController) {
                return Column(
                  children: [
                    // give the tab bar a height [can change height to preferred height]
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
                            text: 'Apply Leave',
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
                          SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Container(
                              color: Color(0xffF8F8F8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15),
                                  Container(
                                    height: 40,
                                    child: Row(
                                      children: [
                                        SizedBox(width: 12),
                                        Image.asset(
                                          'assets/images/calender.png',
                                          height: 20,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'Day',
                                          style: TextStyle(
                                              letterSpacing: 1,
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: SizedBox(
                                        height: 80,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: daylist.length,
                                            itemBuilder: (BuildContext, index) {
                                              return dayrowView(index);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 0, bottom: 10),
                                    child: Text(
                                      'Date Range',
                                      style: TextStyle(
                                          color: ThemeManager.colorBlack),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Card(
                                                elevation: 1,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Bounce(
                                                        duration: Duration(
                                                            milliseconds: 110),
                                                        onPressed: () {
                                                          showDatePicker(
                                                            fieldHintText:
                                                                'dd-mm-yyyy',
                                                            builder: (context,
                                                                child) {
                                                              return Theme(
                                                                data: Theme.of(
                                                                        context)
                                                                    .copyWith(
                                                                  colorScheme:
                                                                      ColorScheme
                                                                          .light(
                                                                    primary:
                                                                        ThemeManager
                                                                            .primaryColor,
                                                                    onPrimary:
                                                                        Colors
                                                                            .white,
                                                                    onSurface:
                                                                        ThemeManager
                                                                            .colorBlack,
                                                                    background:
                                                                        Colors
                                                                            .white,
                                                                    onBackground:
                                                                        Colors
                                                                            .white,
                                                                    onSecondary:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                  dialogBackgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  textButtonTheme:
                                                                      TextButtonThemeData(
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      primary:
                                                                          ThemeManager
                                                                              .primaryColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: child!,
                                                              );
                                                            },
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime.now(),
                                                            lastDate: DateTime(
                                                                2030, 1),
                                                          ).then((value) => {
                                                                selectDay =
                                                                    8473657834,
                                                                currentDate =
                                                                    DateFormat(
                                                                            'yyyy-MM-dd')
                                                                        .format(
                                                                            value!),
                                                                convertdate =
                                                                    DateFormat(
                                                                            'yyyy-MM-dd')
                                                                        .format(
                                                                            value),
                                                                endDate =
                                                                    currentDate,
                                                                _leaveController
                                                                    .update()
                                                              });
                                                        },
                                                        child: Text(
                                                          currentDate,
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      Text(
                                                        '   to   ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      ),
                                                      Expanded(
                                                        child: Bounce(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  110),
                                                          onPressed: () {
                                                            showDatePicker(
                                                              fieldHintText:
                                                                  'dd-mm-yyyy',
                                                              builder: (context,
                                                                  child) {
                                                                return Theme(
                                                                  data: Theme.of(
                                                                          context)
                                                                      .copyWith(
                                                                    colorScheme:
                                                                        ColorScheme
                                                                            .light(
                                                                      primary:
                                                                          ThemeManager
                                                                              .primaryColor,
                                                                      onPrimary:
                                                                          Colors
                                                                              .white,
                                                                      onSurface:
                                                                          ThemeManager
                                                                              .colorBlack,
                                                                      background:
                                                                          Colors
                                                                              .white,
                                                                      onBackground:
                                                                          Colors
                                                                              .white,
                                                                      onSecondary:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                    dialogBackgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    textButtonTheme:
                                                                        TextButtonThemeData(
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        primary:
                                                                            ThemeManager.primaryColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: child!,
                                                                );
                                                              },
                                                              context: context,
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate:
                                                                  DateTime
                                                                      .now(),
                                                              lastDate:
                                                                  DateTime(
                                                                      2030, 1),
                                                            ).then((value) {
                                                              selectDay =
                                                                  8473657834;
                                                              var tempdate =
                                                                  DateTime.parse(
                                                                      convertdate);
                                                              daycount = value!
                                                                  .difference(
                                                                      tempdate)
                                                                  .inDays;

                                                              if (daycount ==
                                                                  0) {
                                                                daycount = 1;
                                                              }
                                                              print(value
                                                                  .difference(
                                                                      tempdate)
                                                                  .inDays);
                                                              if (daycount <
                                                                  0) {
                                                                daycount = 0;
                                                                endDate =
                                                                    currentDate;
                                                                Utils.showErrorToast(
                                                                    context,
                                                                    'Please select valid date');
                                                              } else {
                                                                endDate = DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        value);
                                                              }
                                                              _leaveController
                                                                  .update();
                                                            });
                                                          },
                                                          child: Text(
                                                            endDate,
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black45,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ),
                                                      Image.asset(
                                                        'assets/images/calender.png',
                                                        color: ThemeManager
                                                            .colorGrey,
                                                        height: 20,
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: Card(
                                              elevation: 1,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                    daycount.toString(),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ))),
                                        ),
                                        Text(
                                          'Days',
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                  daycount < 2
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  top: 20,
                                                  bottom: 10),
                                              child: Text(
                                                'Hours',
                                                style: TextStyle(
                                                    color: ThemeManager
                                                        .colorBlack),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 10),
                                              child: SizedBox(
                                                height: 55,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: hourlist.length,
                                                    itemBuilder:
                                                        (BuildContext, index) {
                                                      return Bounce(
                                                        onPressed: () {
                                                          selectDuration =
                                                              index;
                                                          selectedHours =
                                                              hourlist[index];
                                                          starttime = DateFormat(
                                                                  'kk:mm:ss')
                                                              .format(DateTime
                                                                  .now());
                                                          endtime = DateFormat(
                                                                  'kk:mm:ss')
                                                              .format(DateTime
                                                                      .now()
                                                                  .add(Duration(
                                                                      hours: int
                                                                          .parse(
                                                                              hourlist[index]))));
                                                          daycount = 0;
                                                          _leaveController
                                                              .update();
                                                        },
                                                        duration: Duration(
                                                            milliseconds: 110),
                                                        child: Container(
                                                          width: 70,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 5,
                                                                  left: 5),
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: selectDuration ==
                                                                      index
                                                                  ? colorlist[
                                                                      index]
                                                                  : colorlist[
                                                                          index]
                                                                      .withOpacity(
                                                                          0.2)),
                                                          child: Text(
                                                            hourlist[index] +
                                                                ' hr',
                                                            style: TextStyle(
                                                                color: selectDuration ==
                                                                        index
                                                                    ? Colors
                                                                        .white
                                                                    : colorlist[
                                                                        index]),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20.0, top: 0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Card(
                                                          elevation: 1,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Bounce(
                                                                  onPressed:
                                                                      () {
                                                                    DatePicker.showTime12hPicker(
                                                                        context,
                                                                        showTitleActions:
                                                                            true,
                                                                        onConfirm:
                                                                            (date) {
                                                                      starttime = DateFormat(
                                                                              'HH:mm:ss')
                                                                          .format(
                                                                              date);
                                                                      daycount =
                                                                          0;
                                                                      _leaveController
                                                                          .update();
                                                                      // _endTimeController.text = DateFormat.jm().format(date);
                                                                    },
                                                                        locale:
                                                                            LocaleType.en);
                                                                  },
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          110),
                                                                  child: Text(
                                                                    starttime,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black45,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '   to   ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                Expanded(
                                                                  child: Bounce(
                                                                    onPressed:
                                                                        () {
                                                                      if (starttime ==
                                                                          '--:--:--') {
                                                                        Utils.showErrorToast(
                                                                            context,
                                                                            'Please select start time');
                                                                      } else {
                                                                        DatePicker.showTimePicker(
                                                                            context,
                                                                            showTitleActions:
                                                                                true,
                                                                            onConfirm:
                                                                                (date) {
                                                                          var temp =
                                                                              DateFormat('HH:mm:ss').format(date);
                                                                          var format =
                                                                              DateFormat("HH:mm:ss");

                                                                          selectedHours = format
                                                                              .parse(temp)
                                                                              .difference(format.parse(starttime))
                                                                              .inHours
                                                                              .toString();
                                                                          daycount =
                                                                              0;

                                                                          if (int.parse(selectedHours) >
                                                                              8) {
                                                                            endtime =
                                                                                '';
                                                                            Utils.showErrorToast(context,
                                                                                'Durations should be less than 8 hrs');
                                                                          } else {
                                                                            endtime =
                                                                                temp;
                                                                            print(selectedHours);
                                                                          }
                                                                          _leaveController
                                                                              .update();
                                                                          // _endTimeController.text = DateFormat.jm().format(date);
                                                                        }, locale: LocaleType.en);
                                                                      }
                                                                    },
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            110),
                                                                    child: Text(
                                                                      endtime,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black45,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/wait.png',
                                                                  color: ThemeManager
                                                                      .colorGrey,
                                                                  height: 20,
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10),
                                                    child: Card(
                                                        elevation: 1,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Text(
                                                              selectedHours,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ))),
                                                  ),
                                                  Text(
                                                    'Hours',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                          ],
                                        )
                                      : Container(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    child: Row(
                                      children: [
                                        SizedBox(width: 12),
                                        Image.asset(
                                          'assets/images/shape.png',
                                          height: 20,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'Type',
                                          style: TextStyle(
                                              letterSpacing: 1,
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: SizedBox(
                                      height: 80,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: _leaveController
                                              .leavetypeList.length,
                                          itemBuilder: (BuildContext, index) {
                                            return TyperowView(index);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Current Leave Balance',
                                          style:
                                              TextStyle(color: Colors.black45),
                                        ),
                                        SizedBox(width: 15),
                                        Container(
                                          width: 50,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              'TBA',
                                              style: TextStyle(
                                                  color: Colors.black45),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  /*   Center(
                                      child: Text(
                                    'Manager : John dew',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  )),*/
                                  // SizedBox(height: 15),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: ThemeManager.colorGrey)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: TextFormField(
                                          controller:
                                              _commentTextEditingController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(
                                              color: ThemeManager.colorBlack,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                          decoration: InputDecoration(
                                              hintText: 'Comment',
                                              hintStyle: TextStyle(
                                                  color:
                                                      ThemeManager.colorBlack,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700),
                                              border: InputBorder.none)),
                                    ),
                                  ),
                                  Bounce(
                                    onPressed: () {
                                      if (TypeID.isEmpty) {
                                        Utils.showErrorMessage(context,
                                            'Please Select Leave Type');
                                      } else {
                                        var data =
                                            '{"leaveType": {"id": "$TypeID"},"strStartDateTime": "${currentDate} ${starttime == '--:--:--' ? '00:00:00' : starttime}","strEndDateTime": "${endDate} ${endtime == '--:--:--' ? '00:00:00' : endtime}","totalHour": $selectedHours,"totalDay": $daycount,"leaveReason": "${_commentTextEditingController.text.toString()}"}';
                                        _leaveController.requestLeave(
                                            data, callback);
                                      }
                                    },
                                    duration: Duration(milliseconds: 110),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Image.asset(
                                          'assets/images/rfa_bt.png',
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          // second tab bar view widget

                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  _leaveController.leavehistoryList.length,
                              itemBuilder: (BuildContext, index) {
                                return HistoryRowView(index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })),
    );
  }

  Widget dayrowView(int index) {
    return Bounce(
      onPressed: () {
        selectDay = index;
        currentDate = DateFormat('dd-MM-yyyy')
            .format(DateTime.now().add(Duration(days: selectDay - 1)));
        print(currentDate);
        endDate = currentDate;
        print(endDate);
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

  Widget TyperowView(int index) {
    return Bounce(
      onPressed: () {
        selectType = index;
        TypeID = _leaveController.leavetypeList[index].id.toString();
        print(TypeID);
        _leaveController.update();
      },
      duration: Duration(milliseconds: 110),
      child: Container(
        height: 60,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: selectType == index
                ? colorlist[index]
                : colorlist[index].withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Container(
              width: 50,
              padding: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(2)),
              child: Text(
                index == 0 || index == 2 ? 'Personal' : '',
                style: TextStyle(color: colorlist[index], fontSize: 8),
              ),
            ),
            Expanded(
              child: Center(
                  child: Text(
                _leaveController.leavetypeList[index].leaveDescription
                    .toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:
                        selectType == index ? Colors.white : colorlist[index],
                    fontSize: 10,
                    fontWeight: FontWeight.w700),
              )),
            ),
          ],
        ),
      ),
    );
  }

  getDifference(DateTime date1, DateTime date2) async {
    print('date1 $date1');
    print('date2 $date2');
    print("${date1.difference(date2).inDays}");
    return date1.difference(date2).inDays.toString();
  }

  Widget HistoryRowView(int index) {
    String day = DateTime.parse(
            _leaveController.leavehistoryList[index].endDateTime.toString())
        .difference(DateTime.parse(
            _leaveController.leavehistoryList[index].startDateTime.toString()))
        .inDays
        .toString();
    return Bounce(
      onPressed: () {},
      duration: Duration(milliseconds: 110),
      child: Container(
        height: 70,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: _leaveController.leavehistoryList[index].leaveStatus
                        .toString() ==
                    "1"
                ? Colors.grey.withOpacity(0.2)
                : _leaveController.leavehistoryList[index].leaveStatus
                            .toString() ==
                        "2"
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${DateFormat('dd MMM yyyy').format(DateTime.parse(_leaveController.leavehistoryList[index].applyDate.toString()))}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    _leaveController
                        .leavehistoryList[index].leaveType!.leaveDescription!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: /*selectType == index
                            ? Colors.white
                            : colorlist[index]*/
                            Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  _leaveController.leavehistoryList[index].leaveStatus
                              .toString() ==
                          "1"
                      ? _leaveController.leavehistoryList[index].approver !=
                              null
                          ? 'Pending with ${_leaveController.leavehistoryList[index].approver!.firstName}'
                          : 'Pending'
                      : _leaveController.leavehistoryList[index].leaveStatus
                                  .toString() ==
                              "2"
                          ? _leaveController.leavehistoryList[index].approver !=
                                  null
                              ? 'Approved by ${_leaveController.leavehistoryList[index].approver!.firstName}'
                              : "Approved"
                          : _leaveController.leavehistoryList[index].approver !=
                                  null
                              ? 'Rejected by ${_leaveController.leavehistoryList[index].approver!.firstName}'
                              : "Rejected",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color:
                          /*selectType == index ? Colors.white : colorlist[index]*/ Colors
                              .black,
                      fontSize: 10,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 15),
                Text(
                  '${DateFormat('dd MMM').format(DateTime.parse(_leaveController.leavehistoryList[index].startDateTime.toString())).replaceAll("T00:00:00Z", '')} to ${DateFormat('dd MMM').format(DateTime.parse(_leaveController.leavehistoryList[index].endDateTime.toString())).replaceAll("T00:00:00Z", '')}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors
                          .black /* selectType == index ? Colors.white : colorlist[index]*/,
                      fontSize: 10,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    _leaveController.leavehistoryList[index].totalDay
                            .toString() +
                        ' Days,   ' +
                        '${DateFormat('HH:mm a').format(DateTime.parse(_leaveController.leavehistoryList[index].startDateTime.toString())).toLowerCase()} to ${DateFormat('HH:mm a').format(DateTime.parse(_leaveController.leavehistoryList[index].endDateTime.toString())).toLowerCase()},     ' +
                        _leaveController.leavehistoryList[index].totalHour
                            .toString() +
                        ' hr',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(height: 5),
          ],
        ),
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
