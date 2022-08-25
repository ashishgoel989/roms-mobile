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

class TransferFormScreen extends StatefulWidget {
  TransferFormScreen();

  @override
  _TransferFormScreenState createState() => _TransferFormScreenState();
}

class _TransferFormScreenState extends State<TransferFormScreen>
    with SingleTickerProviderStateMixin {
  List<String> daylist = [
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
  var selectType = true;
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
                'Transfer/Change of Rate',
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
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Bounce(
                            duration: Duration(milliseconds: 110),
                            onPressed: () {
                              selectType = true;
                              setState(() {});
                            },
                            child: Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: selectType
                                      ? ThemeManager.primaryColor
                                      : Color(0xffFFDDCE),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    'Permanent Transfer',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black),
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          child: Bounce(
                            duration: Duration(milliseconds: 110),
                            onPressed: () {
                              selectType = false;
                              setState(() {});
                            },
                            child: Container(
                              height: 40,
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                color: selectType
                                    ? Color(0xffFFDDCE)
                                    : ThemeManager.primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                  child: Text(
                                'Temporary Transfer',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: ThemeManager.colorGrey),
                    Text(
                      'Name',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return namelist
                            .where((String name) => name
                                .toLowerCase()
                                .startsWith(
                                    textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (String option) => option,
                      fieldViewBuilder: (BuildContext context,
                          fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        /*if (isclear) {
                          fieldTextEditingController.text = '';
                          isclear = false;
                        } else {}*/
                        return Container(
                          height: 55,
                          padding: EdgeInsets.only(left: 8, top: 5),
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3))),
                          child: TextField(
                            controller: fieldTextEditingController,
                            focusNode: fieldFocusNode,
                            style: new TextStyle(
                                fontSize: 14.0,
                                // height: 2.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            decoration: const InputDecoration(
                              counter: Offstage(),
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(
                                  fontSize: 14.0, color: Colors.black),
                            ),
                          ),
                        );
                      },
                      onSelected: (String selection) {},
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<String> onSelected,
                          Iterable<String> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                  color: ThemeManager.colorWhite,
                                  border: Border.all(
                                      color: ThemeManager.colorGrey)),
                              child: ListView.builder(
                                padding: EdgeInsets.all(10.0),
                                itemCount: options.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  final String option =
                                      options.elementAt(index);
                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: ListTile(
                                      title: Text(option,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Employee Number - ',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'From',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ThemeManager.colorGrey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Classifications',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              )),
                        ),
                        Text('At', style: TextStyle(color: Colors.black)),
                        Expanded(
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ThemeManager.colorGrey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: Text(
                              'Location',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          'Rate',
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(width: 15),
                        Container(
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    hintText: '---',
                                    hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    border: InputBorder.none)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Supervisor',
                          style: TextStyle(color: Colors.black54, fontSize: 10),
                        ),
                        SizedBox(width: 20),
                        Text('---')
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    Text(
                      'To',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ThemeManager.colorGrey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Classifications',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              )),
                        ),
                        Text('At', style: TextStyle(color: Colors.black)),
                        Expanded(
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ThemeManager.colorGrey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: Text(
                              'Location',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          'Rate',
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(width: 15),
                        Container(
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    hintText: '---',
                                    hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    border: InputBorder.none)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Supervisor',
                          style: TextStyle(color: Colors.black54, fontSize: 10),
                        ),
                        SizedBox(width: 20),
                        Text('---')
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Row(
                        children: [
                          Text(
                            'Date Effective',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Bounce(
                                            duration:
                                                Duration(milliseconds: 110),
                                            onPressed: () {
                                              showDatePicker(
                                                fieldHintText: 'dd-mm-yyyy',
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      colorScheme:
                                                          ColorScheme.light(
                                                        primary: ThemeManager
                                                            .primaryColor,
                                                        onPrimary: Colors.white,
                                                        onSurface: ThemeManager
                                                            .colorBlack,
                                                        background:
                                                            Colors.white,
                                                        onBackground:
                                                            Colors.white,
                                                        onSecondary:
                                                            Colors.white,
                                                      ),
                                                      dialogBackgroundColor:
                                                          Colors.white,
                                                      textButtonTheme:
                                                          TextButtonThemeData(
                                                        style: TextButton
                                                            .styleFrom(
                                                          primary: ThemeManager
                                                              .primaryColor,
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
                                                selectDay = 8473657834;
                                                var tempdate =
                                                    DateTime.parse(convertdate);
                                                daycount = value!
                                                    .difference(tempdate)
                                                    .inDays;
                                                print(value
                                                    .difference(tempdate)
                                                    .inDays);
                                                if (daycount < 0) {
                                                  daycount = 0;
                                                  endDate = currentDate;
                                                  Utils.showErrorToast(context,
                                                      'Please select valid date');
                                                } else {
                                                  endDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(value);
                                                }
                                                setState(() {});
                                                // _leaveController.update();
                                              });
                                            },
                                            child: Text(
                                              DateFormat('dd/MM/yyyy').format(
                                                  DateTime.parse(endDate)),
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/calender.png',
                                          color: ThemeManager.colorBlack,
                                          height: 20,
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: SizedBox(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
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
                          Text('REQUEST SUPERVISOR',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: 15),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )));
  }

  Widget dayrowView(int index) {
    return Bounce(
      onPressed: () {
        selectDay = index;
        if (index == 3) {
          var friday = 5;
          var now = new DateTime.now();

          while (now.weekday != friday) {
            now = now.add(new Duration(days: 1));
          }
          print('Recent monday $now');
          currentDate = DateFormat('yyyy-MM-dd').format(now);
          print(currentDate);
          endDate = currentDate;
          print(endDate);
        } else if (index == 4) {
          var monday = 1;
          var now = new DateTime.now();
          while (now.weekday != monday) {
            now = now.add(new Duration(days: 1));
          }
          print('Recent monday $now');
          currentDate = DateFormat('yyyy-MM-dd').format(now);
          print(currentDate);
          endDate = currentDate;
          print(endDate);
        } else {
          currentDate = DateFormat('yyyy-MM-dd')
              .format(DateTime.now().add(Duration(days: selectDay - 1)));
          print(currentDate);
          endDate = currentDate;
          print(endDate);
        }
        setState(() {});
        //_leaveController.update();
      },
      duration: Duration(milliseconds: 110),
      child: Container(
        height: 70,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
            color: selectDay == index
                ? colorlist[index]
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
