import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:rtl/provider/provider/theme_provider.dart';
import 'package:rtl/ui/screens/leave/leavescreen.dart';
import 'package:rtl/ui/screens/leave/teamleavescreen.dart';
import 'package:rtl/ui/screens/splash_screen.dart';
import 'package:rtl/utils/helper/pref_utils.dart';
import 'package:rtl/utils/helper/shared_preferences.dart';
import 'package:rtl/utils/helper/theme_manager.dart';
import 'package:rtl/utils/localization/app_localization.dart';
import 'package:rtl/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/notification_controller.dart';
import 'data/store_binding.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  Prefs.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.lightTheme,
      darkTheme: ThemeManager.lightTheme,
      home: RTLApp()));
}

Locale? globalLocale;

class RTLApp extends StatefulWidget {
  const RTLApp({Key? key}) : super(key: key);

  @override
  State<RTLApp> createState() => _RTLAppState();
}

class _RTLAppState extends State<RTLApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late AndroidNotificationChannel channel;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String messageTitle = "Empty";
  String notificationAlert = "alert";

  RemoteMessage? notificationdata;
  NotificationController _notificationController =
      Get.put(NotificationController());

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  @override
  void initState() {
    super.initState();
    init();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/logo');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    messaging.getToken().then((token) {
      print("token>>>>>>>" + token!);
      PrefUtils.setFirebaseToken(token);
      print("token>>>>>>>" + PrefUtils.getFirebaseToken());
// Print the Token in Console
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      notificationdata = message;
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print(message.data);
      Utils.notificationcount = Utils.notificationcount++;
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        message.data['title'],
        message.data['title'],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: 'logo',
          ),
        ),
      );
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        _notificationController
            .deleteNotification(notificationdata!.data['eventId']);

        if (message.data['notificationType'] == 'leave_request') {
          Navigator.push(
              context,
              PageTransition(
                  child: TeamLeaveScreen(
                      'Notification', notificationdata!.data['eventId']),
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 900),
                  reverseDuration: (const Duration(milliseconds: 900))));
        } else {
          Navigator.push(
              context,
              PageTransition(
                  child: LeaveScreen(1),
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 900),
                  reverseDuration: (const Duration(milliseconds: 900))));
        } // do// message things
      }
      if (message != null) {
        flutterLocalNotificationsPlugin.show(
          message.notification.hashCode,
          message.data['title'],
          message.data['title'],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'logo',
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _notificationController
          .deleteNotification(notificationdata!.data['eventId']);
      if (message.data['notificationType'] == 'leave_request') {
        Navigator.push(
            context,
            PageTransition(
                child: TeamLeaveScreen(
                    'Notification', notificationdata!.data['eventId']),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 900),
                reverseDuration: (const Duration(milliseconds: 900))));
      } else {
        Navigator.push(
            context,
            PageTransition(
                child: LeaveScreen(1),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 900),
                reverseDuration: (const Duration(milliseconds: 900))));
      }
    });
    if (notificationdata != null) {
      flutterLocalNotificationsPlugin.show(
        notificationdata!.notification.hashCode,
        notificationdata!.data['title'],
        notificationdata!.data['title'],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: 'logo',
          ),
        ),
      );
    }
  }

  Future<void> init() async {
    await Prefs.init();
  }

  Future onSelectNotification(String? payload) async {
    print("payload : " + payload!);
    _notificationController
        .deleteNotification(notificationdata!.data['eventId']);
    if (notificationdata!.data['notificationType'] == 'leave_request') {
      Navigator.push(
          context,
          PageTransition(
              child: TeamLeaveScreen(
                  'Notification', notificationdata!.data['eventId']),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 900),
              reverseDuration: (const Duration(milliseconds: 900))));
    } else {
      Navigator.push(
          context,
          PageTransition(
              child: LeaveScreen(1),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 900),
              reverseDuration: (const Duration(milliseconds: 900))));
    }

    /*showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );*/
  }

  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    var androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel_ID', 'channel name',
            importance: Importance.max,
            playSound: true,
            // sound: 'sound',
            showProgress: true,
            ticker: title);

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
      ],
      child: Builder(builder: (context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.lightTheme,
          initialBinding: StoreBinding(),
          darkTheme: ThemeManager.lightTheme,
          themeMode: Provider.of<DarkThemeProvider>(context).darkTheme
              ? ThemeMode.light
              : ThemeMode.light,
          home: const SplashScreen(),
        );
      }),
    );
  }
}
