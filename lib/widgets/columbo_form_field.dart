import 'package:flutter/material.dart';

class ColumboFormField extends StatelessWidget {
  const ColumboFormField(
      {@required this.controller,
      @required this.validator,
      @required this.decoration,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.textInputAction = TextInputAction.done});

  final TextEditingController controller;
  final String Function(String) validator;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Social distancing!
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration:
            decoration.applyDefaults(Theme.of(context).inputDecorationTheme),
        keyboardType: keyboardType,
        obscureText: obscureText,
        textInputAction: textInputAction,

        // DEFAULTS

        cursorColor: Colors.green[600],
        cursorRadius: const Radius.circular(2),
        cursorWidth: 2,
        showCursor: true,
      ),
    );
  }
}
