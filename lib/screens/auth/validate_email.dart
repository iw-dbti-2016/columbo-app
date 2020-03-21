import 'package:Columbo/models/user.dart';
import 'package:Columbo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ValidateEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                'You have to validate your email address. Check your mail or resend the verification email.'),
            RaisedButton(
              onPressed: () {
                Provider.of<Auth>(context, listen: false)
                    .resendEmailVerification()
                    .then((value) => print(value))
                    .catchError((e) => print('resend error: $e'));
              },
              color: Colors.green[600],
              child: const Text('Resend email'),
            ),
            _verifyButton(context),
            RaisedButton(
              onPressed: () {
                Provider.of<Auth>(context, listen: false)
                    .signOut()
                    .then((_) =>
                        Navigator.pushReplacementNamed(context, '/auth/login'))
                    .catchError((e) => print('logout error: $e'));
              },
              child: const Text('Log out'),
            )
          ],
        ),
      ),
    );
  }

  Widget _verifyButton(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return RaisedButton(
        onPressed: () {
          Provider.of<Auth>(context, listen: false)
              .retrieveUser(forceReload: true)
              .then((User user) {
            if (user != null && user.emailVerifiedAtObj != null) {
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              Scaffold.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Your email is not yet verified. Try again later.'),
                ),
              );
            }
          }).catchError((e) => print('Verifify error $e'));
        },
        child: const Text('Verify and continue'),
      );
    });
  }
}
