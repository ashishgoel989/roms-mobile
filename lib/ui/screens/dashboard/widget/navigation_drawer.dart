import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:package_info/package_info.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rtl/utils/helper/pref_utils.dart';

import '../../../../utils/helper/primary_button.dart';
import '../../../../utils/helper/theme_manager.dart';
import '../../change_password/ChangePasswordScreen.dart';
import '../../login/login_screen.dart';
import '../../transfer_form/transfer_form_screen.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': const Locale('hi', 'IN')},
  ];

  late double screenHeight;
  late double screenWidth;
  GlobalKey btnKey2 = GlobalKey();
  var selectedValue;
  var selectedTime;
  var selectedReferred;
  GlobalKey menuKey = GlobalKey();
  var _selectedDestination = 0;
  String version = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(
              0xffFFF8E3), //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: Drawer(
            child: Column(
          children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: SlideAnimation(
                      child: widget,
                    ),
                  ),
              // Important: Remove any padding from the ListView.
              children: <Widget>[
                SizedBox(height: size.height * 0.045),
                /*   ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: ThemeManager.primaryText, width: 2)),
                        child: Image.asset(
                          'assets/images/aboutus.png',
                          color: ThemeManager.primaryText,
                          width: 15,
                        ),
                      ),
                    ),
                    title: Text(
                      'Transfer Form',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    selected: _selectedDestination == 0,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          PageTransition(
                              child: TransferFormScreen(),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 900),
                              reverseDuration:
                                  (const Duration(milliseconds: 900))));
                    }),*/
                ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: ThemeManager.primaryText, width: 2)),
                        child: Image.asset(
                          'assets/images/privacypolicy.png',
                          color: ThemeManager.primaryText,
                          width: 15,
                        ),
                      ),
                    ),
                    title: Text(
                      'Privacy Policies',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    selected: _selectedDestination == 1,
                    onTap: () {
                      Navigator.pop(context);
                      /*   Navigator.push(
                              context,
                              PageTransition(
                                  child: PrivacyPolicyScreen(),
                                  type: PageTransitionType.fade,
                                  duration:
                                      const Duration(milliseconds: 900),
                                  reverseDuration:
                                      (const Duration(milliseconds: 900))));*/
                    }),
                ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: ThemeManager.primaryText, width: 2)),
                        child: Image.asset(
                          'assets/images/tnc.png',
                          color: ThemeManager.primaryText,
                          width: 15,
                        ),
                      ),
                    ),
                    title: Text(
                      'Terms & Conditions',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    selected: _selectedDestination == 2,
                    onTap: () {
                      Navigator.pop(context);
                      /* Navigator.push(
                              context,
                              PageTransition(
                                  child: TermsConditionsScreen(),
                                  type: PageTransitionType.fade,
                                  duration:
                                      const Duration(milliseconds: 900),
                                  reverseDuration:
                                      (const Duration(milliseconds: 900))));*/
                    }),
                ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: ThemeManager.primaryText, width: 2)),
                        child: Image.asset(
                          'assets/images/notifications.png',
                          color: ThemeManager.primaryText,
                          width: 15,
                        ),
                      ),
                    ),
                    title: Text(
                      'Notifications',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    selected: _selectedDestination == 3,
                    onTap: () {
                      Navigator.pop(context);
                      /*         Navigator.push(
                              context,
                              PageTransition(
                                  child: NotificationScreen(),
                                  type: PageTransitionType.fade,
                                  duration:
                                      const Duration(milliseconds: 900),
                                  reverseDuration:
                                      (const Duration(milliseconds: 900))));*/
                    }),
                ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: ThemeManager.primaryText, width: 2)),
                        child: Image.asset(
                          'assets/images/support.png',
                          color: ThemeManager.primaryText,
                          width: 15,
                        ),
                      ),
                    ),
                    title: Text(
                      'Support',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    selected: _selectedDestination == 4,
                    onTap: () {
                      Navigator.pop(context);
                      /*Navigator.push(
                              context,
                              PageTransition(
                                  child: SupportScreen(),
                                  type: PageTransitionType.fade,
                                  duration:
                                  const Duration(milliseconds: 900),
                                  reverseDuration:
                                  (const Duration(milliseconds: 900))));*/
                    }),
                ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: ThemeManager.primaryText, width: 2)),
                        child: Image.asset(
                          'assets/images/changepassword.png',
                          color: ThemeManager.primaryText,
                          width: 15,
                        ),
                      ),
                    ),
                    title: Text(
                      'Change Password',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    selected: _selectedDestination == 7,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          PageTransition(
                              child: ChangePasswordScreen(),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 900),
                              reverseDuration:
                                  (const Duration(milliseconds: 900))));
                    }),
                ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: ThemeManager.primaryText, width: 2)),
                        child: Image.asset(
                          'assets/images/logout.png',
                          color: ThemeManager.primaryText,
                          width: 15,
                        ),
                      ),
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    selected: _selectedDestination == 8,
                    onTap: () {
                      Navigator.pop(context);
                      _showLogountDialog();
                    }),
                Text(
                  'Version : 0.0.1',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                )
              ]),
        )));
  }

  Future<void> _showLogountDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          buttonPadding: EdgeInsets.all(0),
          title: Center(
            child: Text('Logout',
                textScaleFactor: 1.0,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: ThemeManager.primaryText)),
          ),
          content: Text('Are you sure you want to log out from \nROMS?',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: ThemeManager.primaryText)),
          contentTextStyle: TextStyle(color: ThemeManager.primaryText),
          actions: <Widget>[
            Container(
              child: Column(
                children: [
                  Divider(
                    height: 3,
                    color: ThemeManager.primaryText,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                            child: Text('Cancel',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: ThemeManager.primaryText)),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        VerticalDivider(
                          width: 3,
                          color: ThemeManager.primaryText,
                        ),
                        FlatButton(
                          child: Text('Logout',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: ThemeManager.primaryText)),
                          onPressed: () {
                            if (PrefUtils.getRemember() == '1') {
                              String email = PrefUtils.getEmail();
                              String password = PrefUtils.getPassword();
                              PrefUtils.logout();
                              PrefUtils.setEmail(email);
                              PrefUtils.setPassword(password);
                              PrefUtils.setRemember('1');
                              print('remember ${PrefUtils.getRemember()}');
                              print('email ${PrefUtils.getEmail()}');
                            } else {
                              PrefUtils.logout();
                            }
                            Navigator.pushAndRemoveUntil(
                                context,
                                PageTransition(
                                    child: LoginScreen(),
                                    type: PageTransitionType.fade,
                                    duration:
                                    const Duration(milliseconds: 900),
                                    reverseDuration:
                                    (const Duration(milliseconds: 900))),
                                    (Route<dynamic> route) => false);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
