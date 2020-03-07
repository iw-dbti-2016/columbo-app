import 'package:flutter/material.dart';

class DrawerText extends StatefulWidget {
  const DrawerText(this._text);

  final String _text;

  @override
  _DrawerTextState createState() => _DrawerTextState();
}

class _DrawerTextState extends State<DrawerText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 4, 8),
      child: Text(
        widget._text.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.normal,
          letterSpacing: 1,
          fontSize: 17,
        ),
      ),
    );
  }
}
