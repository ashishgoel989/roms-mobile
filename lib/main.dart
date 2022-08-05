import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rtl/provider/provider/theme_provider.dart';
import 'package:rtl/ui/screens/splash_screen.dart';
import 'package:rtl/utils/helper/theme_manager.dart';
import 'package:rtl/utils/localization/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const RTLApp());
}

Locale? globalLocale;

class RTLApp extends StatefulWidget {
  const RTLApp({Key? key}) : super(key: key);

  @override
  State<RTLApp> createState() => _RTLAppState();
}

class _RTLAppState extends State<RTLApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.lightTheme,
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
