import 'package:chat/theme/palette.dart';
import 'package:flutter/material.dart';

ThemeData themeData = ThemeData.dark(
  useMaterial3: true,
).copyWith(
  scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    color: Palette.appBarColor,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  tabBarTheme: const TabBarTheme(
    indicatorColor: Palette.tabColor,
    labelColor: Palette.tabColor,
    unselectedLabelColor: Colors.white,
    labelStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
);
