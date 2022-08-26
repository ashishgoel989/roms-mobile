import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rtl/ui/screens/dashboard/widget/navigation_drawer.dart';
import 'package:rtl/ui/screens/leave/leavescreen.dart';
import 'package:rtl/ui/screens/transfer_form/transfer_form_screen.dart';
import 'package:rtl/utils/helper/pref_utils.dart';

import '../../../utils/helper/primary_button.dart';
import '../../../utils/helper/theme_manager.dart';
import '../leave/teamleavescreen.dart';
import '../profile/profile_screen.dart';
import '../resignation_advice/resignation_advice_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  StateHomeScreen createState() => StateHomeScreen();
}

class StateHomeScreen extends State<HomeScreen> {
  List<Color> colorlist = [
    Colors.yellow.withOpacity(0.2),
    Colors.blueAccent.withOpacity(0.2),
    Colors.purpleAccent.withOpacity(0.2),
    Colors.orange.withOpacity(0.2),
    Colors.green.withOpacity(0.2),
    Colors.blueAccent.withOpacity(0.2),
    Colors.purpleAccent.withOpacity(0.2),
    Colors.orange.withOpacity(0.2),
    Colors.yellow.withOpacity(0.2),
  ];

  List<String> emojiList = [
    'assets/images/emoji-1.png',
    'assets/images/emoji-2.png',
    'assets/images/emoji-3.png',
    'assets/images/emoji-4.png',
    'assets/images/emoji-5.png',
    'assets/images/emoji-6.png',
    'assets/images/emoji-7.png',
    'assets/images/emoji-8.png',
  ];

  List<String> namelist = [
    'Recommendations',
    'New Release',
    'Trending',
    'Wellness',
    'Mindfulness',
  ];

  List<String> imagelist = [
    'assets/images/ad.png',
    'assets/images/j2.png',
    'assets/images/j3.png',
    'assets/images/j4.png',
    'assets/images/j5.png',
  ];
  var _selectedDestination = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late Size size;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        // showMoodDialog(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Large
      child: Container(
        color: Color(0xffFFF8E3),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          endDrawer: NavigationDrawer(),
          body: Column(
            children: [
              SizedBox(height: size.height * 0.045),
              Padding(
                padding: const EdgeInsets.only(right: 5.0, left: 15),
                child: Row(
                  children: [
                    Bounce(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: ProfileScreen(),
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 900),
                                reverseDuration:
                                    (const Duration(milliseconds: 900))));


                        /**/
                      },
                      duration: Duration(microseconds: 110),
                      child: Hero(
                        tag: 'profile',
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/profile.png',
                              height: 50,
                              width: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Hello, ${PrefUtils.getFirstName()}!',
                          style: TextStyle(
                              letterSpacing: 1,
                              color: ThemeManager.colorBlack,
                              fontWeight: FontWeight.w800,
                              fontSize: 20)),
                    ),
                    IconButton(
                      icon: Image.asset(
                        "assets/images/menu.png",
                        height: 20,
                        color: ThemeManager.colorBlack,
                      ),
                      onPressed: () =>
                          _scaffoldKey.currentState!.openEndDrawer(),
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 375),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 50.0,
                          child: SlideAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          /*  SizedBox(height: 30),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text('Hello, Mathew!',
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: ThemeManager.colorBlack,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20)),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text('Have a nice day!',
                                style: TextStyle(
                                    letterSpacing: .5,
                                    color: ThemeManager.colorBlack,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14)),
                          ),*/
                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text('My Tasks',
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: ThemeManager.colorBlack,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: SizedBox(
                              height: 230,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (BuildContext, index) {
                                  return rowMyFavouriteView(index);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Leaves',
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Bounce(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: LeaveScreen(0),
                                            type: PageTransitionType.fade,
                                            duration: const Duration(
                                                milliseconds: 900),
                                            reverseDuration: (const Duration(
                                                milliseconds: 900))));
                                  },
                                  duration: Duration(milliseconds: 110),
                                  child: Hero(
                                    tag: 'button',
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ThemeManager.primaryColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 28,
                                            right: 28,
                                            top: 8,
                                            bottom: 8),
                                        child: Text(
                                          'Apply',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Announcements',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                              width: double.infinity,
                              height: 40,
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 10),
                              padding: EdgeInsets.only(top: 10, left: 15),
                              decoration: BoxDecoration(
                                color: Color(0xffFEF5F4),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.1),
                                    width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                /*boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5.0, color: Colors.blue),
                                ],*/
                              ),
                              child: Text(
                                  'Welcome to the RTL digital transformation',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400))),
                          Container(
                              width: double.infinity,
                              height: 40,
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 15),
                              padding: EdgeInsets.only(top: 10, left: 15),
                              decoration: BoxDecoration(
                                color: Color(0xffFEF5F4),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.1),
                                    width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                /*  boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5.0, color: Colors.blue),
                                ],*/
                              ),
                              child: Text('Taking care of plants and people',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400))),
                          Container(
                              width: double.infinity,
                              height: 40,
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 15),
                              padding: EdgeInsets.only(top: 10, left: 15),
                              decoration: BoxDecoration(
                                color: Color(0xffFEF5F4),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.1),
                                    width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                /* boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5.0, color: Colors.blue),
                                ],*/
                              ),
                              child: Text(
                                  'RTL is committed to the local community',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400))),
                          Container(
                              width: double.infinity,
                              height: 40,
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 15),
                              padding: EdgeInsets.only(top: 10, left: 15),
                              decoration: BoxDecoration(
                                color: Color(0xffFEF5F4),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.1),
                                    width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                /* boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5.0, color: Colors.blue),
                                ],*/
                              ),
                              child: Text(
                                  'RTL aims for zero loss time injuries',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400))),
                          Container(
                              width: double.infinity,
                              height: 40,
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 15),
                              padding: EdgeInsets.only(top: 10, left: 15),
                              decoration: BoxDecoration(
                                color: Color(0xffFEF5F4),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.1),
                                    width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                /* boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5.0, color: Colors.blue),
                                ],*/
                              ),
                              child: Text('RTL is based in the Latrobe Valley',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400))),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowMyFavouriteView(int index) {
    return Bounce(
      duration: Duration(milliseconds: 110),
      onPressed: () {
        /*  Navigator.push(
            context,
            PageTransition(
                child: CapsuleDetailScreen(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 900),
                reverseDuration: (const Duration(milliseconds: 900))));*/
      },
      child: Container(
          height: 200,
          width: 160,
          margin: EdgeInsets.only(left: 5, top: 5),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cardbg.png'),
                fit: BoxFit.fill,
              ),
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/task.png', height: 25),
                  SizedBox(width: 15),
                  Text(
                    'Leave',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  )
                ],
              ),
              Spacer(),
              Bounce(
                onPressed: () {
                  if (PrefUtils.getRole() == 'ROLE_EMPLOYEE') {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: LeaveScreen(1),
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 900),
                            reverseDuration:
                                (const Duration(milliseconds: 900))));
                  } else {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: TeamLeaveScreen(),
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 900),
                            reverseDuration:
                                (const Duration(milliseconds: 900))));
                  }
                },
                duration: Duration(milliseconds: 110),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 18, right: 18, top: 8, bottom: 8),
                    child: Text(
                      PrefUtils.getRole() == 'ROLE_EMPLOYEE'
                          ? 'History'
                          : ' Review Requests',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Spacer(),
              /*   Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Progress',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 5),
              LinearPercentIndicator(
                width: 150.0,
                lineHeight: 5.0,
                percent: 0.5,
                backgroundColor: Colors.indigo,
                progressColor: Colors.white,
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '50%',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ),
              ),*/
              SizedBox(height: 20),
            ],
          ) /*Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 10),
            child: Text(
              'Manage\nAnxiety',
              style: TextStyle(
                  letterSpacing: .5,
                  color: ThemeManager.colorWhite,
                  fontWeight: FontWeight.w900,
                  fontSize: 16),
            ),
          ),
        ),*/
          ),
    );
  }

  void showMoodDialog(BuildContext context) {
    var selectedIndexcal;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Material(
                type: MaterialType.transparency,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage("assets/images/bg.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      height: size.height * 0.65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // height: 100,
                            width: 500,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Image.asset(
                              'assets/images/logo.jpg',
                              height: size.height * 0.1,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Mood Tracker",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: ThemeManager.primaryText),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: size.height * 0.2,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                shape: BoxShape.rectangle),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    "Select your Mood",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        letterSpacing: .5,
                                        fontWeight: FontWeight.w700,
                                        color: ThemeManager.primaryText),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.16,
                                  // width: 100,
                                  child: GridView.count(
                                    crossAxisCount: 4,
                                    childAspectRatio: 1,
                                    physics: BouncingScrollPhysics(),
                                    //rossAxisSpacing: 5,
                                    children: List.generate(8, (index) {
                                      var Index = index + 1;
                                      return InkWell(
                                        onTap: () {
                                          selectedIndexcal = index;
                                          setState(() {});
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5),
                                            selectedIndexcal == index
                                                ? Container(
                                                    height: 50,
                                                    width: 110,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                          style: BorderStyle
                                                              .solid),
                                                    ),
                                                    child: Image.asset(
                                                      emojiList[index],
                                                      height: 20,
                                                      width: 50,
                                                    ),
                                                  )
                                                : Container(
                                                    height: 40,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                          style: BorderStyle
                                                              .solid),
                                                    ),
                                                    child: Image.asset(
                                                      emojiList[index],
                                                      height: 30,
                                                      width: 70,
                                                    )),
                                            selectedIndexcal == index
                                                ? SizedBox(height: 0)
                                                : SizedBox(height: 10),
                                            Text(
                                              "Emoji",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Hero(
                              tag: 'I am feeling Angry',
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 30),
                                  child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ThemeManager.primaryColor,
                                            width: 1.0,
                                            style: BorderStyle.solid),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'I am feeling Angry'.toUpperCase(),
                                        style: TextStyle(
                                          color: ThemeManager.primaryText,
                                          letterSpacing: .5,
                                          fontFamily: 'Oxygen',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: PrimaryButton(
                                buttonText: 'Okay',
                                onButtonPressed: () {
                                  Navigator.pop(context);
                                  /*   Navigator.push(
                                      context,
                                      PageTransition(
                                          child: QuestionnaireScreen(),
                                          type: PageTransitionType.fade,
                                          duration:
                                          const Duration(milliseconds: 900),
                                          reverseDuration:
                                          (const Duration(milliseconds: 900))));*/
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
}
