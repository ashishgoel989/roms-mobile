import 'package:flutter/material.dart';

import '../localization/language_model.dart';

class AppConstants {
  //static String base_url = 'https://13.234.56.70/';
  static String base_url = 'http://13.234.56.70:8080/';
  //static String base_url = 'http://13.236.181.82:8080/';
  static String registration = base_url + 'authenticate';
  static String leave_type = base_url + 'v1/leave/types';
  static String request_leave = base_url + 'v1/leave/request';
  static String history_leave = base_url + 'v1/leave/applied';
  static String team_leave_request =
      base_url + 'v1/leave/appliedToMe?leaveStatus=1';
  static String team_leave_history =
      base_url + 'v1/leave/appliedToMe?leaveStatus=0';
  static String approve_request = base_url + 'v1/leave/approve';
  static String decline_request = base_url + 'v1/leave/reject';
  static String appliedToMeHistory =
      base_url + 'v1/leave/appliedToMeHistory?&page=0&size=50';
  static String addDevice = base_url + 'v1/employee/adddevice';
  static String notification = base_url + 'v1/notification/load';
  static String delete_notification = base_url + 'v1/notification/delete';
  static String change_password = base_url + 'v1/password/change';
  static String approver = base_url + 'v1/leave/approver';

  //Pref Constant
  static String fcmToken = '';
  static String totalBalance = '';
}

class LanguageConstants {
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String index = 'index';
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: '',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: '',
        languageName: 'Hindi',
        countryCode: 'IN',
        languageCode: 'hi'),
  ];
}

class SharedPrefsKeys {
  static const TOKEN = 'TOKEN';
  static const USER_LOGGED_IN = 'USER_LOGGED_IN';
  static const USER_TOKEN = 'USER_TOKEN';
  static const role = 'role';
  static const firebasetoken = 'firebasetoken';
  static const firstname = 'firstname';
  static const lastname = 'lastname';
  static const userId = 'userId';
  static const email = 'email';
  static const phone = 'phone';
  static const birthday = 'birthday';
  static const gender = 'gender';
  static const employeeNo = 'employeeNo';
  static const jobTitle = 'jobTitle';
  static const profileimage = 'profileimage';
  static const FIRST_TIME_LAUNCH = 'first_time_launch';
  static const USER_DATA = "user_data";
  static const USER_LANGUAGE = 'user_language';
  static const password_remember = 'password_remember';
  static const password = 'password';
}
