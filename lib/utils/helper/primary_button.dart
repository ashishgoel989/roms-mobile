import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:rtl/utils/helper/theme_manager.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {required this.buttonText, required this.onButtonPressed});

  final String buttonText;
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(milliseconds: 110),
      onPressed: () {
        onButtonPressed();
      },
      child: Stack(children: [
        Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: ThemeManager.primaryText,
              border: Border.all(color: ThemeManager.primaryText),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15.0,
                  color: ThemeManager.primaryColor
                ),
              ],
            ),
            child: Center(
              child: Text(buttonText,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            )),
      ]),
    );
  }
}
