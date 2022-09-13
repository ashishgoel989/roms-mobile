import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'helper/theme_manager.dart';

// ignore: avoid_classes_with_only_static_members
class Utils {
  static BuildContext? _loaderContext;
  static late BuildContext _loadingDialoContext;
  static bool _isLoaderShowing = false;
  static bool _isLoadingDialogShowing = false;
  static late Timer toastTimer;
  static late OverlayEntry _overlayEntry;
  static var notificationcount = 0.obs;


  static bool checkInternet() {
    var connectivityResult = (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }


//  Checks
  static bool isNotEmpty(String s) {
    return s != null && s.trim().isNotEmpty;
  }

  static bool isEmpty(String s) {
    return !isNotEmpty(s);
  }

  static bool isListNotEmpty(List<dynamic> list) {
    return list != null && list.isNotEmpty;
  }

  //  Views
  static void showToast1(BuildContext context, String message) {
    showCustomToast(context, message);
  }

  static void showSuccessMessage(BuildContext context, String message) {
    showCustomToast(context, message, bgColor: ThemeManager.colorGreen);
  }

  static void showNeutralMessage(BuildContext context, String message) {
    showCustomToast(context, message, bgColor: ThemeManager.colorGreen);
  }

  static void showErrorMessage(BuildContext context, String message) {
    showErrorToast(context, message, bgColor: ThemeManager.colorRed);
  }

  static void showValidationMessage(BuildContext context, String message) {
    print('Toast message : ' + message);
    showCustomToast(context, message);
  }

  static void showCustomToast(BuildContext context, String message,
      {Color bgColor = Colors.green}) {
    AwesomeDialog(
        context: context,
        width: double.infinity,
        animType: AnimType.TOPSLIDE,
        headerAnimationLoop: true,
        dialogType: DialogType.SUCCES,
        showCloseIcon: false,
        dialogBackgroundColor: Colors.white,
        title: 'success',
        buttonsTextStyle: TextStyle(color: ThemeManager.colorWhite),
        desc: message,
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        }).show();
  }

  static void showErrorToast(BuildContext context, String message,
      {Color bgColor = Colors.red}) {
    AwesomeDialog(
            context: context,
            width: double.infinity,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            headerAnimationLoop: true,
            showCloseIcon: false,
            dialogBackgroundColor: Colors.white,
            title: 'error',
            buttonsTextStyle: TextStyle(color: ThemeManager.colorWhite),
            desc: message,
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
        .show();
    /*  showToast(message,
        context: context,
        fullWidth: true,
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        animation: StyledToastAnimation.slideFromTopFade,
        reverseAnimation: StyledToastAnimation.slideToTopFade,
        position:
            const StyledToastPosition(align: Alignment.topCenter, offset: 0.0),
        startOffset: const Offset(0.0, -3.0),
        backgroundColor: AppColors.snackBarRed,
        reverseEndOffset: const Offset(0.0, -3.0),
        duration: const Duration(seconds: 3),
        animDuration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastOutSlowIn);*/
  }

  static void showLoader(BuildContext context) {
    if (!_isLoaderShowing) {
      _isLoaderShowing = true;
      _loaderContext ??= context;
      showDialog(
          context: _loaderContext!,
          barrierDismissible: false,
          builder: (_loaderContext) {
            return  SpinKitSpinningLines(
              size: 30,
              color: Theme.of(context).primaryColor,
            );
          });
    }
  }

  static void hideLoader() {
    if (_isLoaderShowing) {
      Navigator.pop(_loaderContext!);
      _loaderContext ??= null;
    }
  }

  static void showLoadingDialog(BuildContext context) {
    if (!_isLoadingDialogShowing) {
      _isLoadingDialogShowing = true;
      _loadingDialoContext = context;
      showDialog(
              context: _loadingDialoContext,
              barrierDismissible: false,
              builder: (context) {
                return SpinKitSpinningLines(
                  color: Theme.of(context).primaryColor,
                );
              })
          .then((value) => {
                _isLoadingDialogShowing = false,
                print('LoadingDialog hidden!')
              });
    }
  }

  /* static Future<File> compressAndGetFile(File file) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath =
        dir.absolute.path + "/" + DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 0,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }*/

  static void hideLoadingDialog() {
    if (_isLoadingDialogShowing) {
      Navigator.pop(_loadingDialoContext);
      _loadingDialoContext == null;
    }
  }

  static void hideKeyBoard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static ThemeData getAppThemeData() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        brightness: Brightness.light,
      ),
      canvasColor: Colors.transparent,
      brightness: Brightness.light,
    );
  }

  static DateTime convertDateFromString(String strDate) {
    DateTime date = DateTime.parse(strDate);
    // var formatter = new DateFormat('yyyy-MM-dd');
    return date;
  }
}
