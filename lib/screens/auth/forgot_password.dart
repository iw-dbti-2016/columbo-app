import 'package:Columbo/widgets/columbo_logo.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
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
            const Text('Forgot password'),
          ],
        ),
      ),
    );
  }
}
