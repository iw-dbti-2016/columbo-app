import 'package:flutter/material.dart';
import 'package:Columbo/widgets/columbo_logo.dart';
import 'package:Columbo/widgets/navigation_drawer.dart';

class ColumboScaffold extends StatefulWidget {
  const ColumboScaffold({@required this.child, Key key}) : super(key: key);

  final Widget child;

  @override
  _ColumboScaffoldState createState() => _ColumboScaffoldState();
}

class _ColumboScaffoldState extends State<ColumboScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ColumboLogo(),
        centerTitle: true,
      ),
      body: widget.child,
      drawer: NavigationDrawer(),
    );
  }
}
