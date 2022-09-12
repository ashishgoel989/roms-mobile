import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rtl/controller/notification_controller.dart';

import '../../../utils/helper/pref_utils.dart';
import '../leave/leavescreen.dart';
import '../leave/teamleavescreen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController _notificationController =
      Get.find<NotificationController>();

  @override
  void initState() {
    super.initState();
    _notificationController.GetNotification(callback);
  }

  callback(bool status, Map data) async {
    if (status == true) {
    } else {
      // ToastUtils.setToast(data['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Large
        child: Scaffold(
          backgroundColor: Color(0xffFFFFFF),
          appBar: AppBar(
            backgroundColor: Color(0xffFFFFFF),
            centerTitle: true,
            title: const Text(
              "NOTIFICATIONS",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          body: Obx(
            () => ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount:
                    _notificationController.notificationList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return Obx(
                    () => InkWell(
                      onTap: () {
                         _notificationController.deleteNotification(
                            _notificationController
                                .notificationList.value[index].eventId);
                        if (PrefUtils.getRole() == 'ROLE_EMPLOYEE') {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: LeaveScreen(1),
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 900),
                                  reverseDuration:
                                      (const Duration(milliseconds: 900))));
                        } else {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: TeamLeaveScreen(
                                      'Notification',
                                      _notificationController
                                          .notificationList.value[index].eventId
                                          .toString()),
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 900),
                                  reverseDuration:
                                      (const Duration(milliseconds: 900))));
                        }
                      },
                      child: Container(
                        color: Color(0xffF56D91).withOpacity(0.4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                              height: 1,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 8),
                                      child: Row(
                                        children: [
                                          ClipOval(
                                            child: /*_notificationController
                                                    .notificationList
                                                    .value[index]
                                                    .body
                                                    .profileImage
                                                    .toString()
                                                    .isNotEmpty
                                                ? Image.memory(
                                                    Uint8List.fromList(Base64Decoder()
                                                        .convert(_notificationController
                                                            .notificationList
                                                            .value[index]
                                                            .body
                                                            .profileImage.toString())),
                                                    height: 40,
                                                    width: 40,
                                                    fit: BoxFit.fill,
                                                  )
                                                :*/
                                                Image.asset(
                                              'assets/images/logo.jpg',
                                              height: 40,
                                              width: 40,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _notificationController
                                                      .notificationList
                                                      .value[index]
                                                      .message,
                                                  maxLines: 4,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  DateFormat(
                                                          'HH:mm aa   dd MMM yyyy')
                                                      .format(DateTime.fromMillisecondsSinceEpoch(int.parse(
                                                              _notificationController
                                                                  .notificationList
                                                                  .value[index]
                                                                  .body
                                                                  .time
                                                                  .toString()))
                                                          .toLocal()),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Icon(Icons.arrow_forward_ios),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Bounce(
                                    onPressed: () {
                                      _notificationController
                                          .deleteNotification(
                                              _notificationController
                                                  .notificationList
                                                  .value[index]
                                                  .eventId);
                                    },
                                    duration: Duration(milliseconds: 110),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Image.asset(
                                          'assets/images/delete.png'),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ));
  }
}
