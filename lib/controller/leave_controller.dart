import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtl/data/model/LeaveTypeResponser.dart';
import 'package:rtl/data/model/TeamLeaderRequestResponser.dart';
import 'package:rtl/ui/screens/login/login_screen.dart';
import 'package:rtl/utils/helper/pref_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../data/model/LeaveHistoryResponser.dart';
import '../utils/constants/app_constants.dart';
import '../utils/utils.dart';
import 'GetxNetworkManager.dart';

class LeaveController extends GetxController {
  final _isLoading = false.obs;

  get isLoading => _isLoading;
  List<Data> _leavetypeList = [];

  List<Data> get leavetypeList => _leavetypeList;

  List<DataHistory> _leavehistoryList = [];

  List<DataHistory> get leavehistoryList => _leavehistoryList;

  List<DataTeamRequest> _teamleaveRequestList = [];

  List<DataTeamRequest> get teamLeaveRequestList => _teamleaveRequestList;

  List<DataTeamRequest> _teamleaveHistoryList = [];

  List<DataTeamRequest> get teamLeaveHistoryList => _teamleaveHistoryList;
  final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();


  Future GetLeaveType(callback) async {
    if(_networkManager.connectionType != 0) {
      _isLoading.value = true;
      Map<String, String> headers = {
        "Authorization": 'Bearer ${PrefUtils.getUserToken()}',
      };
      print(headers);
      http.Response response =
      await http.get(Uri.parse(AppConstants.leave_type), headers: headers);
      print('response : ' + response.body.toString());
      if (response != null && response.statusCode == 200) {
        Map map = jsonDecode(response.body);
        print(response.body);
        if (map['token'] != '') {
          LeaveTypeResponser leaveTypeResponser =
          LeaveTypeResponser.fromJson(jsonDecode(response.body));
          callback(true, map);
          _leavetypeList = leaveTypeResponser.data!;
          //_isLoading.value = false;
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
    else{
      Get.snackbar(AppConstants.title, AppConstants.message);
    }
  }

  Future GetLeaveHistory(callback, page) async {
    if(_networkManager.connectionType != 0){
    _isLoading.value = true;
    Map<String, String> headers = {
      "Authorization": 'Bearer ${PrefUtils.getUserToken()}',
    };
    print(headers);
    http.Response response = await http.get(
        Uri.parse('${AppConstants.history_leave}?page=$page&size=10'),
        headers: headers);
    print(
        'request url  : ' + '${AppConstants.history_leave}?page=$page&size=10');
    print('response : ' + response.body.toString());
    if (response != null && response.statusCode == 200) {
      Map map = jsonDecode(response.body);
      print(response.body);
      if (map['token'] != '') {
        LeaveHistoryResponser leaveHistoryResponser =
            LeaveHistoryResponser.fromJson(jsonDecode(response.body));
        callback(true, map);
        _leavehistoryList = leaveHistoryResponser.data!;
        _isLoading.value = false;
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
    }}else{
      Get.snackbar(AppConstants.title, AppConstants.message);
    }
  }

  Future GetTeamLeaveRequest(callback,page) async {
    if(_networkManager.connectionType != 0) {
      _isLoading.value = true;
      Map<String, String> headers = {
        "Authorization": 'Bearer ${PrefUtils.getUserToken()}',
      };
      print(headers);
      http.Response response = await http
          .get(
          Uri.parse('${AppConstants.team_leave_request}&page=$page&size=10'),
          headers: headers);
      print('response : ' + response.body.toString());
      if (response.statusCode == 200) {
        Map map = jsonDecode(response.body);
        print(response.body);
        if (map['token'] != '') {
          TeamLeaveRequestResponser teamLeaveRequestResponser =
          TeamLeaveRequestResponser.fromJson(jsonDecode(response.body));
          callback(true, map);
          _teamleaveRequestList = teamLeaveRequestResponser.data!;
          _isLoading.value = false;
          update();
        } else {
          _isLoading.value = false;
          callback(false, map);
          update();
        }
      } else {
        _isLoading.value = false;
        Get.off(LoginScreen());
        update();
      }
    }else{
      Get.snackbar(AppConstants.title, AppConstants.message);
    }
  }

  Future GetTeamLeaveHistory(callback,page) async {
    if(_networkManager.connectionType != 0) {
      _isLoading.value = true;
      Map<String, String> headers = {
        "Authorization": 'Bearer ${PrefUtils.getUserToken()}',
      };
      print(headers);
      http.Response response = await http
          .get(
          Uri.parse('${AppConstants.team_leave_history}&page=$page&size=10'),
          headers: headers);
      print('response : ' + response.body.toString());
      if (response != null && response.statusCode == 200) {
        Map map = jsonDecode(response.body);
        print(response.body);
        if (map['token'] != '') {
          TeamLeaveRequestResponser teamLeaveRequestResponser =
          TeamLeaveRequestResponser.fromJson(jsonDecode(response.body));
          callback(true, map);
          _teamleaveHistoryList = teamLeaveRequestResponser.data!
              .where((element) =>
          element.leaveStatus == 2 || element.leaveStatus == 3)
              .toList();
          _isLoading.value = false;
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
    }else{
      Get.snackbar(AppConstants.title, AppConstants.message);
    }
  }

  Future requestLeave(data, callback) async {
    if(_networkManager.connectionType != 0) {
      _isLoading.value = true;
      Map<String, String> headers = {
        "Authorization": 'Bearer ${PrefUtils.getUserToken()}',
        "content-type": "application/json",
      };

      print(headers);
      print(data);
      http.Response response = await http.post(
          Uri.parse(AppConstants.request_leave),
          headers: headers,
          body: data);
      print('response : ' + response.body.toString());
      if (response != null && response.statusCode == 200) {
        Map map = jsonDecode(response.body);
        print(response.body);
        if (map['token'] != '') {
          callback(true, map);
          _isLoading.value = false;
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
        update();
      }
    }else{
      Get.snackbar(AppConstants.title, AppConstants.message);
    }
  }

  Future ApproveRequest(data, callback) async {
    if(_networkManager.connectionType != 0) {
      _isLoading.value = true;
      Map<String, String> headers = {
        "Authorization": 'Bearer ${PrefUtils.getUserToken()}',
        "content-type": "application/json",
      };
      print(headers);
      print(data);
      http.Response response = await http.post(
          Uri.parse(AppConstants.approve_request),
          headers: headers,
          body: data);
      print('response : ' + response.body.toString());
      if (response != null && response.statusCode == 200) {
        Map map = jsonDecode(response.body);
        print(response.body);
        if (map['token'] != '') {
          callback(true, map);
          _isLoading.value = false;
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
        update();
      }
    }else{
      Get.snackbar(AppConstants.title, AppConstants.message);
    }
  }

  Future DeclineRequest(data, callback) async {
    if(_networkManager.connectionType != 0) {
      _isLoading.value = true;
      Map<String, String> headers = {
        "Authorization": 'Bearer ${PrefUtils.getUserToken()}',
        "content-type": "application/json",
      };
      print(headers);
      print(data);
      http.Response response = await http.post(
          Uri.parse(AppConstants.decline_request),
          headers: headers,
          body: data);
      print('response : ' + response.body.toString());
      if (response != null && response.statusCode == 200) {
        Map map = jsonDecode(response.body);
        print(response.body);
        if (map['token'] != '') {
          callback(true, map);
          _isLoading.value = false;
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
        update();
      }
    }else{
      Get.snackbar(AppConstants.title, AppConstants.message);

    }
  }

  Future GetManagerName( callback) async {
    if(_networkManager.connectionType != 0) {
      _isLoading.value = true;
      Map<String, String> headers = {
        "Authorization": 'Bearer ${PrefUtils.getUserToken()}',
        "content-type": "application/json",
      };
      print(headers);
      http.Response response = await http.get(
        Uri.parse(AppConstants.approver),
        headers: headers,
      );
      print('manager response : ' + response.body.toString());
      if (response != null && response.statusCode == 200) {
        Map map = jsonDecode(response.body);
        print(response.body);
        callback(true, map);
        _isLoading.value = false;
        update();
      } else {
        callback(false);
        _isLoading.value = false;
        update();
      }
    }else{
      Get.snackbar(AppConstants.title, AppConstants.message);
    }
  }
}
