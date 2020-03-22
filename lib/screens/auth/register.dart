import 'package:Columbo/services/auth.dart';
import 'package:Columbo/services/validator.dart';
import 'package:Columbo/widgets/columbo_form_field.dart';
import 'package:Columbo/widgets/columbo_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _firstNameFieldController = TextEditingController();
  final _lastNameFieldController = TextEditingController();
  final _usernameFieldController = TextEditingController();
  final _passwordConfirmationFieldController = TextEditingController();

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
                      controller: _firstNameFieldController,
                      validator: Provider.of<Validator>(context, listen: false)
                          .firstName,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    ColumboFormField(
                      controller: _lastNameFieldController,
                      validator: Provider.of<Validator>(context, listen: false)
                          .lastName,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                    ),
                    ColumboFormField(
                      controller: _usernameFieldController,
                      validator: Provider.of<Validator>(context, listen: false)
                          .username,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
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
                    ColumboFormField(
                      controller: _passwordFieldController,
                      validator: Provider.of<Validator>(context, listen: false)
                          .password,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                    ),
                    ColumboFormField(
                      controller: _passwordConfirmationFieldController,
                      validator: Provider.of<Validator>(context, listen: false)
                          .password,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.verified_user),
                      ),
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Provider.of<Auth>(context).loading
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
                                  if (!_formKey.currentState.validate()) {
                                    return;
                                  }

                                  Provider.of<Auth>(context, listen: false)
                                      .register(
                                          _emailFieldController.text,
                                          _passwordFieldController.text,
                                          _passwordConfirmationFieldController
                                              .text,
                                          _usernameFieldController.text,
                                          _firstNameFieldController.text,
                                          _lastNameFieldController.text)
                                      .then((_) =>
                                          Navigator.pushReplacementNamed(
                                              context, '/auth/validate-email'))
                                      .catchError(
                                          (e) => print('register error: $e'));
                                },
                                child: const Text('Register'),
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
