import 'package:Columbo/models/user.dart';
import 'package:Columbo/services/auth.dart';
import 'package:Columbo/widgets/columbo_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ValidateEmail extends StatefulWidget {
  @override
  _ValidateEmailState createState() => _ValidateEmailState();
}

class _ValidateEmailState extends State<ValidateEmail> {
  bool requestResend = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          physics: const PageScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: Hero(
                  tag: 'logo',
                  child: ColumboLogo(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'You still have to validate your email address. Check '
                      'your email (don\'t forget to check the spam-folder) or '
                      'request to resend the verification email.',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  _verifyButton(context),
                  _resendButton(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          Provider.of<Auth>(context, listen: false)
                              .logout()
                              .then((_) => Navigator.pushReplacementNamed(
                                  context, '/auth/login'))
                              .catchError((e) => print('logout error: $e'));
                        },
                        child: const Text('Log out'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _verifyButton(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: (Provider.of<Auth>(context).loading && !requestResend)
            ? const SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.green[600],
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      requestResend = false;
                    });
                    Provider.of<Auth>(context, listen: false)
                        .fetchUser()
                        .then((User user) {
                      if (user != null && user.emailVerifiedAtObj != null) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(
                            content: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Your email is not verified yet.\n'
                                'Try again later.',
                              ),
                            ),
                            duration: Duration(seconds: 8),
                          ),
                        );
                      }
                    }).catchError((e) => print('Verifify error $e'));
                  },
                  child: const Text('Verify and continue'),
                ),
              ),
      );
    });
  }

  Widget _resendButton(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: (Provider.of<Auth>(context).loading && requestResend)
            ? const SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  color: Colors.grey[300],
                  onPressed: () {
                    setState(() {
                      requestResend = true;
                    });
                    Provider.of<Auth>(context, listen: false)
                        .resendEmailVerification()
                        .then((value) {
                      Scaffold.of(context).showSnackBar(
                        const SnackBar(
                          content: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'Your new verification email is on it\'s way!'),
                          ),
                          duration: Duration(seconds: 6),
                        ),
                      );
                    }).catchError((e) => print('resend error: $e'));
                  },
                  child: const Text('Resend email'),
                ),
              ),
      );
    });
  }
}
