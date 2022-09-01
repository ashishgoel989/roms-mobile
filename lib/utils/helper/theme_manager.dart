import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'device_type.dart';

class ThemeManager {
  //Colors we used here for the entire application
  static Color primaryColor = Color(0xffEF6D35);
  static Color primaryText = Color(0xffEF6D35);
  static Color secondaryColor = Color(0xff00900D);
  static Color lineColor = Color(0xffdedede);
  static Color bgColor = Color(0xffffffff);
  static Color lightPrimaryColor = Color(0xff67698e);
  static Color iconColor = Color(0xff323232);
  static Color placeholder = Color(0xfff0f0f0);
  static Color shimmerHighlight = Color(0xffe3e3e3);
  static Color shimmerShape = Color(0xffd6d6d6);
  static Color colorBlack = const Color(0xff000000);
  static Color colorWhite = const Color(0xffffffff);
  static Color colorGrey = const Color(0xFFc7c7c7);
  static Color cardBG = const Color(0xffFFEDED);
  static Color cardBG1 = const Color(0xffFFF5E1);
  static Color colorBlue = const Color(0xff2b5fe7);
  static Color colorGreen = const Color(0xff0c6302);
  static Color colorRed = const Color(0xffD73105);

  // Dark Color
  static Color darkBgColor = Color(0xff121212);
  static Color darkIconColor = Color(0xe6ffffff);
  static Color elevationColor = Color(0xff272727);
  static Color darkPrimaryText = Color(0xe6ffffff);
  static Color darkSecondaryText = Color(0xb3ffffff);
  static Color darkLineColor = Color(0xff4f4f4f);
  static Color darkPlaceholder = Color(0xff373737);
  static Color darkShimmerHighlight = Color(0xff505050);
  static Color darkShimmerShape = Color(0xff5d5d5d);

  static Color darkGreen = Color(0xffcdf6d6);
  static Color lightGreen = Color(0xffe0fcf4);
  static Color darkPink = Color(0xfff5c8ce);
  static Color lightPink = Color(0xfffae3f0);
  static Color darkGrey = Color(0xffdedede);
  static Color lightGrey = Color(0xfff0f0f0);
  static Color darkRed = Color(0xfff15858);
  static Color chatInitiate = Color(0xffFADDDD);
  static Color orange = Color(0xffec9c70);
  static Color markerColor = Color(0x4d8e64ec);

  static Color processLite = Color(0xfffaeadd);
  static Color processColor = Color(0xfff49320);
  static Color completeLite = Color(0xffe5f6fc);
  static Color completeColor = Color(0xff1fb0df);
  static Color cancelLite = Color(0xfffcd2d5);
  static Color cancelColor = Color(0xffd6343c);


  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'lato',
    backgroundColor: primaryColor,
    primaryColor: primaryColor,
    accentColor: primaryColor,
    scaffoldBackgroundColor: bgColor,
    buttonColor: primaryColor,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    appBarTheme:  AppBarTheme(
      backgroundColor: ThemeManager.primaryColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xffFFF8E3), // Status bar
        statusBarBrightness: Brightness.light,//status bar brigtness
        statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
      ),
     // systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),

    textTheme: txtTheme,

  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'lato',
    backgroundColor: darkBgColor,
    primaryColor: primaryColor,
    accentColor: primaryColor,
    scaffoldBackgroundColor: darkBgColor,
    buttonColor: darkGreen,

    appBarTheme: AppBarTheme(
      backgroundColor: darkBgColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ThemeManager.darkBgColor, // Status bar
        statusBarBrightness: Brightness.dark,//status bar brigtness
        statusBarIconBrightness: Brightness.light, //status barIcon Brightness
      ),
     // systemOverlayStyle: SystemUiOverlayStyle.light,
    ),

    textTheme: darkTxtTheme,
  );

  static TextTheme txtTheme = TextTheme(
    bodyText1: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 16.0 : 14.0, color: ThemeManager.primaryText, fontWeight: FontWeight.w500),
    bodyText2: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 16.0 : 14.0, color: ThemeManager.secondaryColor, fontWeight: FontWeight.w500),
    caption: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 15.5 : 13.5, color: ThemeManager.primaryText, fontWeight: FontWeight.w500),
    subtitle1: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 16.0 : 14.0, color: ThemeManager.primaryText, fontWeight: FontWeight.w700),
    subtitle2: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 14.0 : 12.0, color: ThemeManager.secondaryColor, fontWeight: FontWeight.w500),
    button: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 16.0 : 14.0, color: Colors.white, fontWeight: FontWeight.w500),
    headline1: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 19.0 : 17.0, color: ThemeManager.primaryText, fontWeight: FontWeight.w500),
    headline2: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 23.0 : 21.0, color: ThemeManager.primaryText, fontWeight: FontWeight.w500),
    headline3: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 18.0 : 16.0, color: ThemeManager.primaryText, fontWeight: FontWeight.w500),
    headline4: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 20.0 : 18.0, color: ThemeManager.primaryText, fontWeight: FontWeight.w100),
    headline5: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 16.0 : 14.0, color: ThemeManager.primaryColor, fontWeight: FontWeight.w500),
  );

  static TextTheme darkTxtTheme = TextTheme(
    bodyText1: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 16.0 : 14.0, color: ThemeManager.darkPrimaryText, fontWeight: FontWeight.w500),
    bodyText2: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 16.0 : 14.0, color: ThemeManager.darkSecondaryText, fontWeight: FontWeight.w500),
    caption: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 15.5 : 13.5, color: ThemeManager.darkPrimaryText, fontWeight: FontWeight.w500),
    subtitle1: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 16.0 : 14.0, color: ThemeManager.darkPrimaryText, fontWeight: FontWeight.w700),
    subtitle2: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 14.0 : 12.0, color: ThemeManager.darkSecondaryText, fontWeight: FontWeight.w500),
    button: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 16.0 : 14.0, color: Colors.white, fontWeight: FontWeight.w500),
    headline1: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 19.0 : 17.0, color: ThemeManager.darkPrimaryText, fontWeight: FontWeight.w500),
    headline2: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 23.0 : 21.0, color: ThemeManager.darkPrimaryText, fontWeight: FontWeight.w500),
    headline3: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 18.0 : 16.0, color: ThemeManager.darkPrimaryText, fontWeight: FontWeight.w500),
    headline4: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 20.0 : 18.0, color: ThemeManager.darkPrimaryText, fontWeight: FontWeight.w100),
    headline5: TextStyle(fontSize: getDeviceType() == DeviceType.Tablet ? 16.0 : 14.0, color: ThemeManager.primaryColor, fontWeight: FontWeight.w500),
  );

  // Primary button color
  static ButtonStyle primaryButtonStyle(BuildContext context, double radius, double padding){
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.fromLTRB(padding,5,padding,5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius)),
      primary: Theme.of(context).primaryColor,
      elevation: 0,
    );
  }

  static ButtonStyle secondaryButtonStyle(BuildContext context, double radius, double padding){
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.fromLTRB(padding,5,padding,5),
      side: BorderSide(width: 1, color: lightGrey),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius)),
      primary: Colors.white,
      elevation: 0,
    );
  }

  static ButtonStyle secondaryDarkButtonStyle(BuildContext context, double radius, double padding){
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.all(padding),
      side: BorderSide(width: 1, color: darkPlaceholder),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius)),
      primary: darkPlaceholder,
      elevation: 0,
    );
  }

  static ButtonStyle cancelButtonStyle(BuildContext context, double radius, double padding){
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.all(padding),
      side: BorderSide(width: 1, color: darkRed),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius)),
      primary: darkRed,
      elevation: 0,
    );
  }
}
