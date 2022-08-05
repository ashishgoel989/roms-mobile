import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';



class AppLocalization {
   //AppLocalization();

  //final Locale locale;

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  late Map<String, String> _localizedValues;

  Future<void> load() async {

    SharedPreferences? sharedPreferences = await SharedPreferences.getInstance();
    Locale locale = Locale(sharedPreferences.getString(LanguageConstants.languageCode) ?? LanguageConstants.languages[0].languageCode!,
          sharedPreferences.getString(LanguageConstants.countryCode) ?? LanguageConstants.languages[0].countryCode);
    String jsonStringValues = await rootBundle.loadString('assets/language/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    load();
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate = _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    List<String> _languageString = [];
    for (var language in LanguageConstants.languages) {
      _languageString.add(language.languageCode!);
    }
    return _languageString.contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization =  AppLocalization();
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
