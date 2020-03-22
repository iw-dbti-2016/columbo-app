
import 'package:flutter/material.dart';

abstract class AuthException implements Exception {
  int statusCode;
  String message;

  AuthException(this.statusCode, [this.message='']);

  void handle(BuildContext context);
}