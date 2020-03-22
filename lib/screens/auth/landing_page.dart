import 'package:Columbo/models/user.dart';
import 'package:Columbo/screens/auth/login.dart';
import 'package:Columbo/screens/auth/validate_email.dart';
import 'package:Columbo/screens/timeline.dart';
import 'package:Columbo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage(this.context) : super();

  final BuildContext context;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Future<User> authUser;

  @override
  void initState() {
    authUser = Provider.of<Auth>(widget.context, listen: false)
        .getUser(indicateLoading: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authUser,
      builder: (_, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
