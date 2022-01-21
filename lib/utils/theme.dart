import 'package:flutter/material.dart';

import './constants.dart';

ThemeData basicTheme() => ThemeData(
  brightness: Brightness.dark,
  primaryColor: kPrimaryColor,
  backgroundColor: kBackgroundColor,
  textTheme: TextTheme(
    headline6: const TextStyle(
      fontFamily: fontNameTitle,
      fontSize: mediumTextSize,
      color: Colors.purple,
    ),
    headline4: TextStyle(
      fontFamily: fontNameDefault,
      fontSize: mediumTextSize,
      fontWeight: FontWeight.w800,
      color: kSecondaryColor,
    ),
    bodyText1: const TextStyle(
      fontFamily: fontNameDefault,
      fontSize: bodyTextSize,
      color: Colors.green,
    ),
  ),

  iconTheme: const IconThemeData(
    // color: Colors.red,
    size: 32.0,
    color: Colors.white,
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF89FFE7),
    foregroundColor: Color(0xFF1A2F39),
  ),


  buttonTheme: const ButtonThemeData(
    height: 60,
    buttonColor: Colors.deepPurple,
    textTheme: ButtonTextTheme.accent,
  ),

  // bottomAppBarColor: Colors.deepPurple,
  // cardColor: Colors.orange.shade100,
  // scaffoldBackgroundColor: Colors.yellow,
);