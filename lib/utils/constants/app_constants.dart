import 'package:flutter/material.dart';

import '../localization/language_model.dart';

class AppConstants {
  static String base_url = '';
  static String registration = base_url + 'authenticate';

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
  static const firebasetoken = 'firebasetoken';
  static const FIRST_TIME_LAUNCH = 'first_time_launch';
  static const USER_DATA = "user_data";
  static const USER_LANGUAGE = 'user_language';
}