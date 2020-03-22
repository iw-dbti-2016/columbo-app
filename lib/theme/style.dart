import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  primaryColor: Colors.green[600],

  textSelectionColor: Colors.green[300],
  textSelectionHandleColor: Colors.green[400],

  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.grey[900],
    contentTextStyle: TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 3,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[200],

    // TEXT STYLES

    labelStyle: TextStyle(
      color: Colors.grey[900],
      fontSize: 24,
      fontWeight: FontWeight.w300,
      letterSpacing: 1.2,
    ),
//    prefixStyle: TextStyle(
//      color: Colors.grey[800],
//      fontSize: 20,
//    ),

    helperStyle: TextStyle(
      fontSize: 18,
      color: Colors.grey[900],
      fontWeight: FontWeight.w300,
    ),
    errorStyle: TextStyle(
      fontSize: 18,
      color: Colors.red,
      fontWeight: FontWeight.w300,
    ),

    // BORDER STYLES

    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: Colors.grey[300],
        style: BorderStyle.solid,
        width: 2,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: Colors.grey[300],
        style: BorderStyle.solid,
        width: 2,
      ),
    ),
    errorBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: Colors.red,
        style: BorderStyle.solid,
        width: 2,
      ),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: Colors.red,
        style: BorderStyle.solid,
        width: 3,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: Colors.grey[400],
        style: BorderStyle.solid,
        width: 3,
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: Colors.grey[200],
      ),
    ),
  ),

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
    button: TextStyle(
      fontSize: 22,
      color: Colors.black,
      fontWeight: FontWeight.w300,
    ),
  ),
);

/// This file should hold the central theme of the complete application
