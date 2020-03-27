import 'package:Columbo/routes.dart';
import 'package:Columbo/services/auth.dart';
import 'package:Columbo/services/validator.dart';

import 'package:Columbo/theme/style.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        Provider(create: (_) => Validator()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          routes: routes,
          initialRoute: '/landing',
        ),
    );
  }
}
