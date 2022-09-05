import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Large
        child: Scaffold(
            backgroundColor: Color(0xffFFF8E3),
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent),
              backgroundColor: Color(0xffFFF8E3),
              centerTitle: true,
              title: const Text(
                "NOTIFICATIONS",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            body: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/profile.png',
                                height: 40,
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Matt Doman is having his birthday today.',
                                    maxLines: 4,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '02 Sept at 10:00 am',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      )
                    ],
                  );
                })));
  }
}
