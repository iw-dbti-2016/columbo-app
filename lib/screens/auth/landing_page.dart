import 'package:Columbo/models/user.dart';
import 'package:Columbo/screens/auth/login.dart';
import 'package:Columbo/screens/auth/validate_email.dart';
import 'package:Columbo/screens/timeline.dart';
import 'package:Columbo/services/auth.dart';
import 'package:Columbo/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<Auth>(context);

    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (_, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          if (user == null) {
            return Login();
          } else if (user.emailVerifiedAtObj == null) {
            return ValidateEmail();
          }

          return TimeLine();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
