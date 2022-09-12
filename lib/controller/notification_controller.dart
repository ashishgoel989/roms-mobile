import 'dart:convert';
import 'dart:developer';
import 'package:device_information/device_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:rtl/utils/helper/pref_utils.dart';
import 'package:rtl/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../data/model/NotificationResponser.dart';
import '../ui/screens/login/login_screen.dart';
import '../utils/constants/app_constants.dart';

class NotificationController extends GetxController {
  final _isLoading = false.obs;

  get isLoading => _isLoading;

  final _notificationList = [].obs;

  get notificationList => _notificationList.obs;

  Future GetNotification(callback) async {
    _isLoading.value = true;
    Map<String, String> headers = {
      "Authorization": 'Bearer ${PrefUtils.getUserToken()}',
    };
    print(headers);
    http.Response response =
        await http.get(Uri.parse(AppConstants.notification), headers: headers);
    if (response != null && response.statusCode == 200) {
      Map map = jsonDecode(response.body);
      if (map['token'] != '') {
        NotificationResponser teamLeaveRequestResponser =
            NotificationResponser.fromJson(jsonDecode(response.body));
        _notificationList.value = teamLeaveRequestResponser.data != null
            ? teamLeaveRequestResponser.data!
            : [];
        Utils.notificationcount.value = _notificationList.value.length;
        print(Utils.notificationcount.value);
        _isLoading.value = false;
        callback(true, map);
        update();
      } else {
        _isLoading.value = false;
        callback(
          false,
          map,
        );
        update();
      }
    } else {
      _isLoading.value = false;
      Get.off(LoginScreen());
      update();
    }
  }

  Future deleteNotification(String eventID) async {
    _isLoading.value = true;

      Map<String, String> headers = {
        "Authorization": 'Bearer ${PrefUtils.getUserToken()}',
        "content-type": "application/json",
      };
      var data = '{"eventId": "${eventID}"}';
      print(data);
      http.Response response = await http
          .post(Uri.parse(AppConstants.delete_notification), body:data,headers: headers);
      print("delete notification " + response.body.toString());
      if (response != null && response.statusCode == 200) {
        _isLoading.value = false;
        GetNotification(callback);
      } else {
        _isLoading.value = false;
        update();
      }
  }

  callback(bool status, Map data) async {
    if (status == true) {
    } else {
      // ToastUtils.setToast(data['message']);
    }
  }

}
