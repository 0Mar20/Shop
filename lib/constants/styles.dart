import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: Colors.white,
      elevation: 0.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20.0,
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
    ),
  ),
  fontFamily: 'Janna'
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: IconThemeData(color: Colors.white)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20.0,
    type: BottomNavigationBarType.fixed,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
    fontSize: 18.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  ),
    fontFamily: 'Janna'
);
