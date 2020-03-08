import 'package:Columbo/routes.dart';

import 'package:Columbo/theme/style.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() => runApp(Columbo());

class Columbo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set color of the status bar and icons (android + iOS)
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routes: routes,
      initialRoute: '/auth/login',
    );
  }
}
