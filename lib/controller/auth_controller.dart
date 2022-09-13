import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
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
import '../utils/constants/app_constants.dart';
import '../utils/myconnectivity.dart';
import 'GetxNetworkManager.dart';

class AuthController extends GetxController {
  final _isLoading = false.obs;

  get isLoading => _isLoading;
  final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();

  Future login(data, callback) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "content-type": "application/json",
    };

    if (_networkManager.connectionType != 0) {
      _isLoading.value = true;
      update();
      print(data);
      http.Response response = await http.post(
          Uri.parse(AppConstants.registration),
          body: jsonEncode(data),
          headers: headers);
      print(response.body.toString());
      Map? map;
      if (response.statusCode == 200) {
        map = jsonDecode(response.body);
        print(response.body);
        if (map!['token'] != '') {
          _isLoading.value = false;
          try {
            PrefUtils.setUserToken(map['token']);
            PrefUtils.setRole(map['role']);
            PrefUtils.setFirstName(map['userDetail']['firstName']);
            PrefUtils.setLastName(map['userDetail']['lastName']);
            PrefUtils.setUserID(map['userDetail']['id']);
            PrefUtils.setEmail(map['userDetail']['email']);
            PrefUtils.setjobTitle(map['userDetail']['jobTitle']);
            PrefUtils.setphone(map['userDetail']['phone']);
            PrefUtils.setBirthday(DateFormat('dd/MMM/yyyy')
                .format(DateTime.parse(map['userDetail']['birthdate'])));
            PrefUtils.setGender(map['userDetail']['gender']);
            PrefUtils.setemployeeNo(map['userDetail']['employeeNo']);
            PrefUtils.setProfileImage(map['userDetail']['profileImage'] != null
                ? map['userDetail']['profileImage']
                : '');
          } catch (e) {}
          addDevice();
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
        callback(false, '');
        _isLoading.value = false;
        update();
      }
    } else {
      Get.snackbar(AppConstants.title, AppConstants.message);
    }
  }

  Future addDevice() async {
    _isLoading.value = true;
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
      Map<String, String> headers = {
        "Authorization": 'Bearer ${PrefUtils.getUserToken()}',
        "content-type": "application/json",
      };
      var data =
          '{"appVersion": "${packageInfo.version}","emiNo": "","notificationDeviceToken": "${PrefUtils.getFirebaseToken()}","deviceId":""}';
      print(data);
      http.Response response = await http.post(
          Uri.parse(AppConstants.addDevice),
          body: data,
          headers: headers);
      print("add device " + response.body.toString());
      if (response != null && response.statusCode == 200) {
        _isLoading.value = false;
      } else {
        _isLoading.value = false;
        // callback(false, '', loginController);
        update();
      }
    });
  }

  Future changepassword(data, callback) async {
    if (_networkManager.connectionType != 0) {
      _isLoading.value = true;

      Map<String, String> headers = {
        "Authorization": 'Bearer ${PrefUtils.getUserToken()}',
        "content-type": "application/json",
      };
      http.Response response = await http.post(
          Uri.parse(AppConstants.change_password),
          body: data,
          headers: headers);
      if (response != null && response.statusCode == 200) {
        _isLoading.value = false;
        update();
        return jsonDecode(response.body)['status'];
      } else {
        _isLoading.value = false;
        update();
      }
    } else {
      Get.snackbar(AppConstants.title, AppConstants.message);
    }
  }

/*
  Future login(context, data, callback) async {
    _isLoading = true;
    update();
    print(data);
    http.Response response =
        await http.post(Uri.parse(AppConstants.login), body: jsonEncode(data));
    // ApiResponse apiResponse = await _authRepo.login(data);
    if (response != null && response.statusCode == 200) {
      Map map = jsonDecode(response.body);
      print(response.body);
      if (map['status'] == 0) {
        LoginModel loginModel = LoginModel.fromJson(jsonDecode(response.body));
        _isLoading = false;
        SharedPreferences pref = await SharedPreferences.getInstance();
        PrefUtils.setCustomerID(loginModel.user.fldId.toString());
        PrefUtils.setCompanyName(loginModel.user.fldCompanyName.toString());
        PrefUtils.setCompanyCode(loginModel.user.fldCompanyCode.toString());
        PrefUtils.setPlan(loginModel.user.planName.toString());
        PrefUtils.setMobile(loginModel.user.fldPhone.toString());
        PrefUtils.setProfile(loginModel.user.fldImage.toString());
        PrefUtils.setProfile(loginModel.user.fldImage.toString());
        PrefUtils.setVehicle(loginModel.user.fldVehicleCount.toString());
        PrefUtils.setABN(loginModel.user.fldVehicleCount.toString());
        PrefUtils.setDriver(loginModel.user.fldDriverCount.toString());
        PrefUtils.setName(loginModel.user.fldFirstName.toString() +
            " " +
            loginModel.user.fldLastName.toString());

        ToastUtils.setToast(loginModel.message);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false);

        update();
      } else {
        _isLoading = false;
        callback(
          false,
          map,
        );
        update();
      }
    } else {
      _isLoading = false;
      // callback(false, '', loginController);
      update();
    }
  }


  Future verifyOtp(data, email, callback) async {
    _isLoading = true;
    update();
    http.Response response = await http.post(
        Uri.parse(AppConstants.verifyOtpContractor),
        body: jsonEncode(data));
    if (response != null && response.statusCode == 200) {
      Map map = jsonDecode(response.body);
      print(map);
      if (map['status'].toString() == '0') {
        callback(true, map);
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        callback(
          false,
          map,
        );
        update();
      }
    } else {
      _isLoading = false;
      // callback(false, '', loginController);
      update();
    }
  }

  Future resetPassword(data, callback) async {
    _isLoading = true;
    update();
    http.Response response = await http
        .post(Uri.parse(AppConstants.resetPassword), body: jsonEncode(data));
    if (response != null && response.statusCode == 200) {
      Map map = jsonDecode(response.body);
      print(map);
      if (map['status'].toString() == '0') {
        callback(true, map);
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        callback(
          false,
          map,
        );
        update();
      }
    } else {
      _isLoading = false;
      // callback(false, '', loginController);
      update();
    }
  }*/
}
