import 'package:Columbo/errors/auth/auth_exception.dart';
import 'package:flutter/material.dart';

abstract class AuthorizationException extends AuthException {
  AuthorizationException([String message='']) : super(403, message);

  @override
  void handle(BuildContext context) {
    // TODO: implement handle
  }
}