import 'package:flutter/material.dart';

class DrawerText extends StatelessWidget {
  const DrawerText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 4, 8),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.normal,
          letterSpacing: 1,
          fontSize: 17,
        ),
      ),
    );
  }
}
