import 'package:flutter/material.dart';

/// This file should hold the central theme of the complete application

final ThemeData theme = ThemeData(
  primaryColor: Colors.white,

  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 40,
      color: Colors.black,
      letterSpacing: 2,
      fontWeight: FontWeight.w300,
    ),
    headline2: TextStyle(
      fontSize: 25,
      color: Colors.black,
      letterSpacing: 1,
      fontWeight: FontWeight.w300,
    ),
    // ...
    headline6: TextStyle(
      fontSize: 14,
      color: Colors.grey[500],
      fontWeight: FontWeight.w300,
    ),
    bodyText1: TextStyle(
      fontSize: 20,
      color: Colors.black,
      height: 1.2,
      fontWeight: FontWeight.w300,
    ),
  ),
);