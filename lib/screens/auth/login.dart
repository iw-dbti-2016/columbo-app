import 'package:Columbo/models/user.dart';
import 'package:Columbo/services/auth.dart';
import 'package:Columbo/services/validator.dart';
import 'package:Columbo/widgets/columbo_form_field.dart';
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
                    buildEmailInput(context),
                    buildPasswordField(context),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: Provider.of<Auth>(context).loading
                            ? const SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(),
                              )
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
                                        .login(_emailFieldController.text,
                                            _passwordFieldController.text)
                                        .then((User user) => user
                                                    .emailVerifiedAtObj ==
                                                null
                                            ? Navigator.pushReplacementNamed(
                                                context, '/auth/validate-email')
                                            : Navigator.pushReplacementNamed(
                                                context, '/home'))
                                        .catchError(
                                            (e) => print("login error: $e"));
                                  },
                                  child: const Text('Log in'),
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.grey[300],
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/auth/forgot-password');
                              },
                              child: const Text('Forgot password'),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: FlatButton(
                              color: Colors.grey[300],
                              onPressed: () {
                                Navigator.pushNamed(context, '/auth/register');
                              },
                              child: const Text('Register'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmailInput(BuildContext context) {
    return ColumboFormField(
      controller: _emailFieldController,
      validator: Provider.of<Validator>(context, listen: false).email,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.alternate_email),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget buildPasswordField(BuildContext context) {
    return ColumboFormField(
      controller: _passwordFieldController,
      validator: Provider.of<Validator>(context, listen: false).password,
      decoration: const InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock),
      ),
      obscureText: true,
    );
  }
}
