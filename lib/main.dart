import 'package:TravelCompanion/screens/drafts/drafts.dart';
import 'package:TravelCompanion/screens/feed/feed.dart';
import 'package:TravelCompanion/screens/profile/profile.dart';
import 'package:TravelCompanion/screens/trip/triplist.dart';

import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme/style.dart';


void main() => runApp(TravelCompanion());

class TravelCompanion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'TravelCompanion'),
      theme: theme,
      initialRoute: '/trip',
      onGenerateRoute: onGenerateRoutes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _activeIndex = 0;
  final _pageCount = 4;

  Widget _selectPage() {
    return Stack(
      children: List<Widget>.generate(_pageCount, (int index) {
        return IgnorePointer(
          ignoring: index != _activeIndex,
          child: Opacity(
            opacity: _activeIndex == index ? 1.0 : 0.0,
            child: Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder: (_) => _page(index),
                  settings: settings,
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _page(int index) {
    switch (index) {
      case 0:
        return Feed();
      case 1:
        return TripList();
      case 2:
        return Drafts();
      case 3:
        return Profile();
    }

    return const Text("ERROR");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _selectPage(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activeIndex,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: const Text("Feed"),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: const Text("Trips"),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            title: const Text("Drafts"),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: const Text("Profile"),
            backgroundColor: Colors.black,
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            _activeIndex = index;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
