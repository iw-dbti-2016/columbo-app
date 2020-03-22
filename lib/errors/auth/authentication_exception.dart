import 'package:Columbo/errors/auth/auth_exception.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationException extends AuthException {
  AuthenticationException([String message='']) : super(401, message);

  @override
  void handle(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/auth/login');
  }
}