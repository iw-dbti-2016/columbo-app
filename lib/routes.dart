import 'package:Columbo/screens/auth/landing_page.dart';
import 'package:Columbo/screens/lists/location_list.dart';
import 'package:Columbo/screens/lists/poi_list.dart';
import 'package:Columbo/screens/lists/report_list.dart';
import 'package:Columbo/screens/lists/section_list.dart';

/// This file should holds a map with all the routes
import 'package:Columbo/screens/lists/trip_list.dart';
import 'package:Columbo/screens/profile/profile.dart';

import 'package:flutter/material.dart';

import 'package:Columbo/screens/auth/forgot_password.dart';
import 'package:Columbo/screens/auth/login.dart';
import 'package:Columbo/screens/auth/register.dart';
import 'package:Columbo/screens/auth/validate_email.dart';
import 'package:Columbo/screens/timeline.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/home': (context) => TimeLine(),

  // AUTH
  '/landing' : (context) => LandingPage(context),
  '/auth/login': (context) => Login(),
  '/auth/register': (context) => Register(),
  '/auth/forgot-password': (context) => ForgotPassword(),
  '/auth/validate-email': (context) => ValidateEmail(),

  // PROFILE
  '/profile': (context) => Profile(),

  // TRIPS
  '/trips/list': (context) => const TripList(),

  // REPORTS
  '/reports/list': (context) => const ReportList(),

  // SECTIONS
  '/sections/list': (context) => const SectionList(),

  // LOCATIONS
  '/locations/list': (context) => const LocationList(),

  // POIS
  '/pois/list': (context) => const PoiList(),
};
