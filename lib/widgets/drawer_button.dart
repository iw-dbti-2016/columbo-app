import 'package:flutter/material.dart';

class DrawerButton extends StatefulWidget {
  const DrawerButton({this.icon, this.label, this.onTap, this.index});

  final IconData icon;
  final String label;
  final Function onTap;
  final int index;

  @override
  _DrawerButtonState createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.index);
      },
      highlightColor: Colors.green[100],
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40.0),
        bottomRight: Radius.circular(40.0),
      ),
      child: ListTile(
        title: Text(widget.label),
        leading: Icon(
          widget.icon,
          color: Colors.black,
        ),
      ),
    );
  }
}
