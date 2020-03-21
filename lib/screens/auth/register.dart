import 'package:Columbo/services/auth.dart';
import 'package:Columbo/widgets/columbo_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _firstNameFieldController = TextEditingController();
  final _lastNameFieldController = TextEditingController();
  final _usernameFieldController = TextEditingController();
  final _passwordConfirmationFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (Provider.of<Auth>(context).authenticated) {
      if (Provider.of<Auth>(context).user.emailVerifiedAtObj == null) {
        Navigator.pushReplacementNamed(context, '/auth/validate-email');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: ColumboLogo(),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _firstNameFieldController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    TextFormField(
                      controller: _lastNameFieldController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                    ),
                    TextFormField(
                      controller: _usernameFieldController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    TextFormField(
                      controller: _emailFieldController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      controller: _passwordFieldController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    TextFormField(
                      controller: _passwordConfirmationFieldController,
                      decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            color: Colors.green,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.green,
                          ))),
                      obscureText: true,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }

                          Provider.of<Auth>(context, listen: false)
                              .createUserWithEmailAndPassword(
                                  _emailFieldController.text,
                                  _passwordFieldController.text,
                                  _passwordConfirmationFieldController.text,
                                  _usernameFieldController.text,
                                  _firstNameFieldController.text,
                                  _lastNameFieldController.text)
                              .then((_) => Navigator.pushReplacementNamed(
                                  context, '/auth/validate-email'))
                              .catchError((e) => print('register error: $e'));
                        },
                        child: const Text('Register'),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
