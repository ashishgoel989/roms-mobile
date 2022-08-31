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

  static String? setRole(String role) {
    Prefs.prefs!.setString(SharedPrefsKeys.role, role);
  }

  static String getRole() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.role);
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

  static String? setLastName(String lastname) {
    Prefs.prefs!.setString(SharedPrefsKeys.lastname, lastname);
  }

  static String getLastName() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.lastname);
    return value ?? '';
  }

  static String? setUserID(String userId) {
    Prefs.prefs!.setString(SharedPrefsKeys.userId, userId);
  }

  static String getuserID() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.userId);
    return value ?? '';
  }

  static String? setEmail(String email) {
    Prefs.prefs!.setString(SharedPrefsKeys.email, email);
  }

  static String getEmail() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.email);
    return value ?? '';
  }

  static String? setphone(String phone) {
    Prefs.prefs!.setString(SharedPrefsKeys.phone, phone);
  }

  static String getphone() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.phone);
    return value ?? '';
  }

  static String? setBirthday(String birthday) {
    Prefs.prefs!.setString(SharedPrefsKeys.birthday, birthday);
  }

  static String getBirthday() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.birthday);
    return value ?? '';
  }

  static String? setGender(String gender) {
    Prefs.prefs!.setString(SharedPrefsKeys.gender, gender);
  }

  static String getGender() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.gender);
    return value ?? '';
  }

  static String? setemployeeNo(String employeeNo) {
    Prefs.prefs!.setString(SharedPrefsKeys.employeeNo, employeeNo);
  }

  static String getemployeeNo() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.employeeNo);
    return value ?? '';
  }

  static String? setjobTitle(String jobTitle) {
    Prefs.prefs!.setString(SharedPrefsKeys.jobTitle, jobTitle);
  }

  static String getjobTitle() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.jobTitle);
    return value ?? '';
  }


  static String? setProfileImage(String profileimage) {
    Prefs.prefs!.setString(SharedPrefsKeys.profileimage, profileimage);
  }

  static String getProfileImage() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.profileimage);
    return value ?? '';
  }


  static String? logout() {
    Prefs.prefs!.clear();
  }
}
