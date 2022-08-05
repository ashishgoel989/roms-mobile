import 'package:flutter/material.dart';

import '../localization/language_model.dart';

class AppConstants {
  static String base_url = '';
  static String registration = base_url + '/api/v2.0/user/signup';

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
