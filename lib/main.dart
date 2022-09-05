import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rtl/provider/provider/theme_provider.dart';
import 'package:rtl/ui/screens/splash_screen.dart';
import 'package:rtl/utils/helper/pref_utils.dart';
import 'package:rtl/utils/helper/shared_preferences.dart';
import 'package:rtl/utils/helper/theme_manager.dart';
import 'package:rtl/utils/localization/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/store_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await Firebase.initializeApp();
  runApp(const RTLApp());
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
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print(message.data);
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        message.data['title'],
        message.data['msg'],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'logo',
          ),
        ),
      );
    });
  }


  Future<void> init() async {
    await Prefs.init();
  }

  Future onSelectNotification(String? payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
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
          darkTheme: ThemeManager.darkTheme,
          themeMode: Provider.of<DarkThemeProvider>(context).darkTheme
              ? ThemeMode.dark
              : ThemeMode.light,
          home: const SplashScreen(),
        );
      }),
    );
  }
}
