import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtl/utils/helper/theme_manager.dart';

class LeaveScreen extends StatefulWidget {
  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> daylist = [
    'Yesterday',
    'Today',
    'Tomorrow',
    'Day After',
    'This Friday',
    'Next Monday',
  ];

  List<String> typelist = [
    'Sick',
    'Rostered Day Off',
    'Carer\'s',
    'Annual',
    'Without Pay',
    'Bereavement',
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Leaves',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        ),
      ),
      body: Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: TabBar(
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              indicatorColor: ThemeManager.primaryColor,
              indicatorWeight: 3,
              labelColor: ThemeManager.primaryColor,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              tabs: [
                Tab(
                  text: 'Apply Leave',
                ),
                Tab(
                  text: 'History',
                ),
              ],
            ),
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                Container(
                  color: Color(0xffD9EDFF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Container(
                        height: 40,
                        color: Colors.blue,
                        child: Row(
                          children: [
                            SizedBox(width: 12),
                            Image.asset(
                              'assets/images/calender.png',
                              height: 20,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Day',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: SizedBox(
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 20),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: daylist.length,
                                  itemBuilder: (BuildContext, index) {
                                    return dayrowView(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 20, bottom: 10),
                        child: Text(
                          'Date Range',
                          style: TextStyle(color: ThemeManager.colorBlack),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            '--/--/--',
                                            style: TextStyle(
                                                color: Colors.black12,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            '   to   ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '--/--/--',
                                              style: TextStyle(
                                                  color: Colors.black12,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/images/calender.png',
                                            color: Colors.black,
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        '0',
                                        style: TextStyle(color: Colors.black),
                                      ))),
                            ),
                            Text(
                              'Days',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 20, bottom: 10),
                        child: Text(
                          'Duration (Optional)',
                          style: TextStyle(color: ThemeManager.colorBlack),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            '--:--:--',
                                            style: TextStyle(
                                                color: Colors.black12,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            '   to   ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '--:--:--',
                                              style: TextStyle(
                                                  color: Colors.black12,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/images/wait.png',
                                            color: Colors.black,
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        '0',
                                        style: TextStyle(color: Colors.black),
                                      ))),
                            ),
                            Text(
                              'Hours',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Container(
                        height: 40,
                        color: Colors.blue,
                        child: Row(
                          children: [
                            SizedBox(width: 12),
                            Image.asset(
                              'assets/images/calender.png',
                              height: 20,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Type',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: SizedBox(
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 20),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: typelist.length,
                                  itemBuilder: (BuildContext, index) {
                                    return TyperowView(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Current Leave Balance',
                            style: TextStyle(color: Colors.black45),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 50,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'TBA',
                                style: TextStyle(color: Colors.black45),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                // second tab bar view widget
                Center(
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dayrowView(int index) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: Colors.purpleAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        daylist[index],
        style: TextStyle(color: Colors.deepPurple),
      )),
    );
  }

  Widget TyperowView(int index) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: Colors.purpleAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        typelist[index],
        style: TextStyle(color: Colors.deepPurple),
      )),
    );
  }
}
