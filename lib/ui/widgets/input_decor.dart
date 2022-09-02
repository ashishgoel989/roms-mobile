import 'package:flutter/material.dart';
import '../../utils/helper/theme_manager.dart';

class InputDecorE {
  InputDecoration editBoxBorderGrey(
      BuildContext context, IconData icon, String hintText, bool dark) {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      prefixIcon: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(
          icon,
          color: ThemeManager.primaryColor,
        ),
        onPressed: () {},
      ),
      hintText: hintText,
      counterText: '',
      counterStyle: const TextStyle(fontSize: 0),
      border: OutlineInputBorder(
          borderSide: BorderSide(
              color: dark
                  ? ThemeManager.darkLineColor
                  : ThemeManager.primaryColor),
          borderRadius: BorderRadius.circular(10.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: dark
                  ? ThemeManager.darkLineColor
                  : ThemeManager.primaryColor),
          borderRadius: BorderRadius.circular(10.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: dark
                  ? ThemeManager.darkLineColor
                  : ThemeManager.primaryColor),
          borderRadius: BorderRadius.circular(10.0)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: dark
                  ? ThemeManager.darkLineColor
                  : ThemeManager.primaryColor),
          borderRadius: BorderRadius.circular(10.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: dark
                  ? ThemeManager.darkLineColor
                  : ThemeManager.primaryColor),
          borderRadius: BorderRadius.circular(10.0)),
      hintStyle: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: ThemeManager.colorGrey),
    );
  }

  InputDecoration editBoxBorderGreyOnly(
      BuildContext context, String hintText, bool dark) {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      hintText: hintText,
      counterText: '',
      counterStyle: const TextStyle(fontSize: 0),
      border: OutlineInputBorder(
          borderSide: BorderSide(
              color: dark ? ThemeManager.primaryColor : ThemeManager.primaryColor),
          borderRadius: BorderRadius.circular(13.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: dark ? ThemeManager.primaryColor : ThemeManager.primaryColor),
          borderRadius: BorderRadius.circular(13.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: dark ? ThemeManager.primaryColor : ThemeManager.primaryColor),
          borderRadius: BorderRadius.circular(13.0)),
      hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor),
    );
  }

  InputDecoration editBoxFilledGrey(
      BuildContext context, String hintText, bool dark) {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      hintText: hintText,
      counterText: '',
      counterStyle: const TextStyle(fontSize: 0),
      filled: true,
      fillColor: ThemeManager.lightGrey,
      border: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  dark ? ThemeManager.darkLineColor : ThemeManager.lightGrey),
          borderRadius: BorderRadius.circular(5.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  dark ? ThemeManager.darkLineColor : ThemeManager.lightGrey),
          borderRadius: BorderRadius.circular(5.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  dark ? ThemeManager.darkLineColor : ThemeManager.lightGrey),
          borderRadius: BorderRadius.circular(5.0)),
      hintStyle: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: ThemeManager.colorBlack),
    );
  }
}
