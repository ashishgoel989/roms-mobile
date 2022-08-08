import 'dart:convert';


// ignore: avoid_classes_with_only_static_members
class PrefUtils {
  static String setUserToken(String token) {
    Prefs.prefs?.setString(SharedPrefsKeys.USER_TOKEN, token);
  }

  static String getUserToken() {
    final String value = Prefs.prefs?.getString(SharedPrefsKeys.USER_TOKEN);
    return value ?? '';
  }
  static String setFirebaseToken(String firebasetoken) {
    Prefs.prefs?.setString(SharedPrefsKeys.firebasetoken, firebasetoken);
  }

  static String getFirebaseToken() {
    final String value = Prefs.prefs?.getString(SharedPrefsKeys.firebasetoken);
    return value ?? '';
  }

  static void setFirstTimeLaunch(bool firstTimeLaunch) {
    Prefs.prefs?.setBool(SharedPrefsKeys.FIRST_TIME_LAUNCH, firstTimeLaunch);
  }

  static bool isFirstTimeLaunch() {
    final bool value =
        Prefs.prefs?.getBool(SharedPrefsKeys.FIRST_TIME_LAUNCH) ?? true;
    return value ?? true;
  }

  static bool isLoggedIn() {
    return Prefs.prefs?.getString(SharedPrefsKeys.USER_TOKEN) != null ?? false;
  }

/*
  static void saveUser(User user) {
    Prefs.prefs?.setString(SharedPrefsKeys.USER_DATA, json.encode(user));
  }

  static User getUser() {
    String userJson = Prefs.prefs?.getString(SharedPrefsKeys.USER_DATA);
    return User.fromJson(json.decode(userJson));
  }

*/

  static void setFcmTokenRegistered(bool isRegistered) {
    Prefs.prefs?.setBool(KPrefs.IS_FCM_TOKEN_REGISTERED, isRegistered) ?? false;
  }

  static bool getFcmTokenRegistered() {
    final bool value =
        Prefs.prefs?.getBool(KPrefs.IS_FCM_TOKEN_REGISTERED) ?? false;
    return value ?? false;
  }

  static String setID(String id) {
    Prefs.prefs?.setString("id", id);
  }

  static String getID() {
    final String value = Prefs.prefs?.getString("id");
    return value ?? '';
  }

  static String setActiveStatus(String activestatus) {
    Prefs.prefs?.setString("activestatus", activestatus);
  }

  static String getActiveStatus() {
    final String value = Prefs.prefs?.getString("activestatus");
    return value ?? '0';
  }

  static String setskillID(String skillid) {
    Prefs.prefs?.setString("skillid", skillid);
  }

  static String getskillID() {
    final String value = Prefs.prefs?.getString("skillid");
    return value ?? '0';
  }


  static String setFacilityID(String facilityid) {
    Prefs.prefs?.setString("facilityid", facilityid);
  }

  static String getFacilityID() {
    final String value = Prefs.prefs?.getString("facilityid");
    return value ?? '0';
  }

  static String setRoleID(String roleID) {
    Prefs.prefs?.setString("roleID", roleID);
  }

  static String getRoleID() {
    final String value = Prefs.prefs?.getString("roleID");
    return value ?? '0';
  }

  static String setFirstTimeloading(String firsttimeloading) {
    Prefs.prefs?.setString("firsttimeloading", firsttimeloading);
  }

  static String getFirstTimeloading() {
    final String value = Prefs.prefs?.getString("firsttimeloading");
    return value ?? '0';
  }


  static String setContractorID(String contractorID) {
    Prefs.prefs?.setString("contractorID", contractorID);
  }

  static String getContractorID() {
    final String value = Prefs.prefs?.getString("contractorID");
    return value ?? '0';
  }

  static String setRemember(String remember) {
    Prefs.prefs?.setString("remember", remember);
  }

  static String getRemember() {
    final String value = Prefs.prefs?.getString("remember");
    return value ?? '0';
  }

  static String setPassword(String password) {
    Prefs.prefs?.setString("password", password);
  }

  static String getPassword() {
    final String value = Prefs.prefs?.getString("password");
    return value ?? '';
  }

  static bool setTheme(bool theme) {
    Prefs.prefs?.setBool("theme", theme);
  }

  static bool getTheme() {
    final bool value = Prefs.prefs?.getBool("theme");
    return true;
  }

  static String setName(String name) {
    Prefs.prefs?.setString("name", name);
  }

  static String getName() {
    final String value = Prefs.prefs?.getString("name");
    return value ?? '';
  }

  static String setMobile(String mobile) {
    Prefs.prefs?.setString("mobile", mobile);
  }

  static String getMobile() {
    final String value = Prefs.prefs?.getString("mobile");
    return value ?? '';
  }

  static String setEmail(String email) {
    Prefs.prefs?.setString("email", email);
  }

  static String getEmail() {
    final String value = Prefs.prefs?.getString("email");
    return value ?? '';
  }

  static String setAddress(String address) {
    Prefs.prefs?.setString("address", address);
  }

  static String getAddress() {
    final String value = Prefs.prefs?.getString("address");
    return value ?? '';
  }

  static String setPincode(String pincode) {
    Prefs.prefs?.setString("pincode", pincode);
  }

  static String getPincode() {
    final String value = Prefs.prefs?.getString("pincode");
    return value ?? '';
  }

  static String setCustomerID(String customer_id) {
    Prefs.prefs?.setString("customer_id", customer_id);
  }

  static String getCustomerId() {
    final String value = Prefs.prefs?.getString("customer_id");
    return value ?? '';
  }
  static String logout() {
    Prefs.prefs?.clear();
  }
}
