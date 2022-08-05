import 'package:flutter/material.dart';

import '../../utils/helper/theme_preference.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  DarkThemeProvider(){
    // Fetch Theme records from shared preference
    fetchTheme();
  }

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

  fetchTheme() async {
    _darkTheme = await darkThemePreference.getTheme();
    notifyListeners();
  }
}