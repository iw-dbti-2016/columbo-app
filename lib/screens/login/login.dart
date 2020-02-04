import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(
                "",
                width: 58.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Email'),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Password'),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
