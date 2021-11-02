import 'package:data_buffer/services/theme_service.dart';
import 'package:data_buffer/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeTheme {
  UserService userService = UserService();
  ThemeService themeService = ThemeService();
  ChangeTheme() {}

  change() async {
    final prefs = await SharedPreferences.getInstance();
    userService.gender = prefs.getString("gender");
    if (userService.gender == "Male") {
      themeService.myColor1 = 0xFF015098;
      themeService.myColor2 = 0xFF3196E0;
      themeService.myColor3 = 0xFF1974BD;
    } else if (userService.gender == "Female") {
      themeService.myColor1 = 0xFF97036D;
      themeService.myColor2 = 0xFFC654C1;
      themeService.myColor3 = 0xFFAF2C98;
    }
  }
}
