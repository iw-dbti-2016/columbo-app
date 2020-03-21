import 'package:Columbo/models/user.dart';
import 'package:Columbo/services/auth.dart';
import 'package:Columbo/widgets/columbo_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  @override
  void dispose() {
    _emailFieldController.dispose();
    _passwordFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      keyboardType: TextInputType.emailAddress,
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
                  Center(
                    child: Provider.of<Auth>(context).loading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: FlatButton(
                              color: Colors.green[600],
                              textColor: Colors.white,
                              onPressed: () async {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }

                                Provider.of<Auth>(context, listen: false)
                                    .signInWithEmailAndPassword(
                                        _emailFieldController.text,
                                        _passwordFieldController.text)
                                    .then((User user) =>
                                        user.emailVerifiedAtObj == null
                                            ? Navigator.pushReplacementNamed(
                                                context, '/auth/validate-email')
                                            : Navigator.pushReplacementNamed(
                                                context, '/home'))
                                    .catchError((e) => print("login error $e"));
                              },
                              child: const Text('Log in'),
                            ),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
