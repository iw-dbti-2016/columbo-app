import 'package:Columbo/widgets/columbo_logo.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
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
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.green[600],
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.green[600],
                          ),
                        ),
                        labelText: 'email',
                        labelStyle: TextStyle(
                          color: Colors.green[600],
                          fontSize: 22,
                        ),
                        hintText: 'email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.green[600],
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.green[600],
                          ),
                        ),
                        labelText: 'password',
                        labelStyle: TextStyle(
                          color: Colors.green[600],
                          fontSize: 22,
                        ),
                        hintText: 'password',
                      ),
                      obscureText: true,
                    ),
                  ),
                  const Text(
                      'This login doesn\'t actually work, just click the button to move on.'),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                      color: Colors.green[600],
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text('Log in'),
                    ),
                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
