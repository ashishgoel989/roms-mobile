import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import '../../../utils/helper/theme_manager.dart';
import 'home_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _pagedata;
  static int _SelectedItem = 0;
  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;
  int _selectedDestination = 0;

  @override
  void initState() {
    super.initState();

    _pagedata = [
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(child: _pagedata[_SelectedItem]),
        bottomNavigationBar: SnakeNavigationBar.color(
          backgroundColor: Colors.transparent,
          behaviour: SnakeBarBehaviour.pinned,
          snakeShape: SnakeShape.circle,
          shape: null,
          // padding: EdgeInsets.fromLTRB(10, 0, 0, 0),

          snakeViewColor: ThemeManager.primaryText,
          selectedItemColor: ThemeManager.colorWhite,
          unselectedItemColor: Colors.black,

          //snakeViewGradient: selectedGradient,
          // /selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
          //unselectedItemGradient: unselectedGradient,

          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,

          currentIndex: _SelectedItem,
          onTap: (setValue) {
            setState(() {
              _SelectedItem = setValue;
            });
          },
          //onTap: (index) => setState(() => _selectedItemPosition = index),
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/home.png"),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/doc.png"),
                ),
                label: 'Chat'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/bell.png"),
                ),
                label: 'Community'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/search.png"),
                ),
                label: 'Journal'),
          ],
        ),
      ),
    );
  }
}
