import 'package:Columbo/services/auth.dart';
import 'package:Columbo/services/validator.dart';
import 'package:Columbo/widgets/columbo_form_field.dart';
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    ColumboFormField(
                      controller: _emailFieldController,
                      validator:
                          Provider.of<Validator>(context, listen: false).email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: Provider.of<Auth>(context).loading
                            ? const SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator())
                            : SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: RaisedButton(
                                  color: Colors.green[600],
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (!_formKey.currentState.validate()) {
                                      return;
                                    }

                                    Provider.of<Auth>(context, listen: false)
                                        .sendPasswordResetEmail(
                                            _emailFieldController.text)
                                        .then((_) =>
                                            Navigator.pushReplacementNamed(
                                                context, '/auth/login'))
                                        .catchError((e) =>
                                            print("ForgotPW Exception: $e"));
                                  },
                                  child: const Text('Request password reset'),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
