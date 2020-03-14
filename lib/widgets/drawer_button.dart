import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({this.icon, this.label, this.route, this.onTapExtra});

  final IconData icon;
  final String label;
  final String route;
  final Function onTapExtra;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTapExtra != null) {
          onTapExtra();
        }
        Navigator.pushReplacementNamed(context, route);
      },
      highlightColor: Colors.green[100],
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40.0),
        bottomRight: Radius.circular(40.0),
      ),
      child: ListTile(
        title: Text(label),
        leading: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}
