import 'package:Columbo/screens/login/login.dart';
import 'package:Columbo/screens/registration/registration.dart';
import 'package:Columbo/screens/report/report.dart';
import 'package:Columbo/screens/section/section.dart';
import 'package:Columbo/screens/trip/trip.dart';

import 'package:flutter/material.dart';

/// This file should hold only one map with all the routes

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  Widget screen;

  switch (settings.name.toString()) {
    case "/login":
      screen = Login();
      break;
    case "/registration":
      screen = Registration();
      break;
    case "/trip":
      screen = Trip();
      break;
    case "/report":
      screen = Report();
      break;
    case "/section":
      screen = Section(settings.arguments as Map<String, dynamic>);
      break;
  }

  return MaterialPageRoute(
    builder: (context) {
      return screen;
    },
  );
}

//final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
//  '/login': (context) => Login(),
//  '/registration': (context) => Registration(),
//  '/report': (context) => Report(),
//  '/section': (context, section) => Section(section),
//};
