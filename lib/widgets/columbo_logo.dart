import 'package:flutter/material.dart';

class ColumboLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Text(
          'Columbo'.toUpperCase(),
          style: TextStyle(
            color: Colors.green[600],
            fontSize: 34,
            fontWeight: FontWeight.w300,
            letterSpacing: 3,
          ),
        ),
        const Text(
          '.world',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
