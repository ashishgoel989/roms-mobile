import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreference {
  static const LANG_CODE = "language_code";
  static const IS_RTL = "is_rtl";
  static const DEFAULT_LANG = "en", DEFAULT_RTL = false;

  setLanguage(String value, bool rtl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LANG_CODE, value);
    prefs.setBool(IS_RTL, rtl);
  }

  Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(LANG_CODE) ?? DEFAULT_LANG;
  }

  Future<bool> isRTL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_RTL) ?? DEFAULT_RTL;
  }
}