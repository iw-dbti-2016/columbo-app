import 'package:Columbo/errors/auth/auth_exception.dart';
import 'package:flutter/material.dart';

abstract class ValidationException extends AuthException {
  ValidationException([String message='']) : super(422, message);

  @override
  void handle(BuildContext context) {
    // TODO: implement handle
  }
}