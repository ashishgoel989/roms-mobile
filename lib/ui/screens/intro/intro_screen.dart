import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../utils/helper/theme_manager.dart';
import '../login/login_screen.dart';

class Introscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return OnBoardingPage();
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  late double screenHeight;
  late double screenWidth;

  void _onIntroEnd(context) {}

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            title: '',
            body: '',
            image: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/intro_one.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: null /* add child content here */,
            ),
            decoration: pageDecoration.copyWith(
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                fullScreen: true,
                imageFlex: 1,
                pageColor: Colors.transparent),
          ),
          PageViewModel(
            title: '',
            body: '',
            image: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/intro_two.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: null /* add child content here */,
            ),
            decoration: pageDecoration.copyWith(
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                fullScreen: true,
                imageFlex: 1,
                pageColor: Colors.transparent),
          ),
          PageViewModel(
            title: '',
            body: '',
            image: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/intro_three.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: null /* add child content here */,
            ),
            decoration: pageDecoration.copyWith(
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                fullScreen: true,
                imageFlex: 1,
                pageColor: Colors.transparent),
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context),
        // You can override onSkip callback
        showSkipButton: true,
        globalBackgroundColor: Colors.white,
        skip: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: LoginScreen(),
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 900),
                    reverseDuration: (const Duration(milliseconds: 900))),
                (Route<dynamic> route) => false);
          },
          child: Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor),
            child: Center(
              child: Text(
                'Skip',
                style: TextStyle(
                    color: ThemeManager.colorWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        next: Icon(
          Icons.arrow_forward,
          color: Theme.of(context).primaryColor,
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.only(left: 5, right: 5),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFA19C9C),
          activeSize: Size(20.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        done: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: LoginScreen(),
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 900),
                    reverseDuration: (const Duration(milliseconds: 900))),
                (Route<dynamic> route) => false);
          },
          child: Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor),
            child: Center(
              child: Text('Done',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ThemeManager.colorWhite,
                      fontSize: 14)),
            ),
          ),
        ),
      ),
    );
  }
}
