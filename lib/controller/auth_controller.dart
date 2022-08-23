import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtl/utils/helper/pref_utils.dart';
import 'package:rtl/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/constants/app_constants.dart';

class AuthController extends GetxController {
  bool _isLoading = false;
  String driverscount = "0";
  String vehiclecount = "0";
  String ordercount = "0";

  get isLoading => _isLoading;

  Future login(data, callback) async {
    _isLoading = true;
    update();
    print(data);
    Map<String, String> headers = {
      "Accept": "application/json",
      "content-type": "application/json",
    };

    http.Response response = await http.post(
        Uri.parse(AppConstants.registration),
        body: jsonEncode(data),
        headers: headers);
    print(response.body.toString());
    Map? map;
    if (response != null && response.statusCode == 200) {
      map = jsonDecode(response.body);
      print(response.body);
      if (map!['token'] != '') {
        callback(true, map);
        _isLoading = false;
        PrefUtils.setUserToken(map['token']);
        PrefUtils.setRole(map['role']);
        PrefUtils.setFirstName(map['userDetail']['firstName']);
        PrefUtils.setUserID(map['userDetail']['id']);
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
      callback(false,'');
      _isLoading = false;
      update();
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

  Future forgotpassword(data, callback) async {
    _isLoading = true;
    update();
    http.Response response = await http.post(
        Uri.parse(AppConstants.contractor_password_help),
        body: jsonEncode(data));
    if (response != null && response.statusCode == 200) {
      Map map = jsonDecode(response.body);
      print(map);
      if (map['status'].toString() == '0') {
        print('true');

        callback(true, map);
        _isLoading = false;
        update();
      } else {
        print(false);
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
