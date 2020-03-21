import 'package:Columbo/services/auth.dart';
import 'package:Columbo/widgets/columbo_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailFieldController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Container(
                    child: Provider.of<Auth>(context).loading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: () {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }

                                Provider.of<Auth>(context, listen: false)
                                    .sendPasswordResetEmail(
                                        _emailFieldController.text)
                                    .then((_) => Navigator.pushReplacementNamed(
                                        context, '/auth/login'))
                                    .catchError(
                                        (e) => print("ForgotPW Exception: $e"));
                              },
                              child: const Text('Request password reset'),
                            ),
                          ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
