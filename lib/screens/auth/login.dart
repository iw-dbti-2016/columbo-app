import 'dart:convert';

import 'package:Columbo/models/user.dart';
import 'package:Columbo/services/network.dart';
import 'package:Columbo/services/secure_storage.dart';
import 'package:Columbo/widgets/columbo_logo.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  void loadHome() {
    isInStorage('user').then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    _emailFieldController.dispose();
    _passwordFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loadHome();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: ColumboLogo(),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: TextFormField(
                      controller: _emailFieldController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'An email is required';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'email',
                        labelStyle: TextStyle(
                          color: Colors.green[600],
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      controller: _passwordFieldController,
                      decoration: InputDecoration(
                        labelText: 'password',
                        labelStyle: TextStyle(
                          color: Colors.green[600],
                          fontSize: 22,
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                      color: Colors.green[600],
                      textColor: Colors.white,
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }

                        final data = <String, String>{
                          "email": _emailFieldController.text,
                          "password": _passwordFieldController.text,
                        };

                        final User response = await post(
                          'auth/login',
                          body: json.encode(data),
                          serializer: User.serializer,
                        ) as User;

                        writeToStorage('token', '${response.tokenType} ${response.token}');

                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text('Log in'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      OutlineButton(
                        color: Colors.white,
                        highlightedBorderColor: Colors.green[600],
                        onPressed: () {
                          Navigator.pushNamed(context, '/auth/forgot-password');
                        },
                        child: const Text('Forgot password'),
                      ),
                      OutlineButton(
                        color: Colors.white,
                        highlightedBorderColor: Colors.green[600],
                        onPressed: () {
                          Navigator.pushNamed(context, '/auth/register');
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text('Visit'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
