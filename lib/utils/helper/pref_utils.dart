import 'package:rtl/utils/helper/shared_preferences.dart';

import '../constants/app_constants.dart';

class PrefUtils {
  static String? setUserToken(String token) {
    Prefs.prefs!.setString(SharedPrefsKeys.USER_TOKEN, token);
  }

  static String getUserToken() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.USER_TOKEN);
    return value ?? '';
  }
  static String? setFirebaseToken(String firebasetoken) {
    Prefs.prefs!.setString(SharedPrefsKeys.firebasetoken, firebasetoken);
  }

  static String getFirebaseToken() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.firebasetoken);
    return value ?? '';
  }

  static String? setFirstName(String firstname) {
    Prefs.prefs!.setString(SharedPrefsKeys.firstname, firstname);
  }

  static String getFirstName() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.firstname);
    return value ?? '';
  }

  static String? setUserID(String userId) {
    Prefs.prefs!.setString(SharedPrefsKeys.userId, userId);
  }

  static String getuserID() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.userId);
    return value ?? '';
  }


  static String? logout() {
    Prefs.prefs!.clear();
  }
}
