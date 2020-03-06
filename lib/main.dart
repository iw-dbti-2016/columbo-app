import 'dart:convert';

import 'package:TravelCompanion/models/serializers.dart';
import 'package:TravelCompanion/models/trip.dart';
import 'package:TravelCompanion/screens/drafts/drafts.dart';
import 'package:TravelCompanion/screens/feed/feed.dart';
import 'package:TravelCompanion/screens/profile/profile.dart';
import 'package:TravelCompanion/screens/trip/triplist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme/style.dart';

void main() => runApp(TravelCompanion());

class TravelCompanion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'TravelCompanion'),
      theme: theme,
//      initialRoute: '/trip',
//      onGenerateRoute: onGenerateRoutes,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<dynamic> _trips;

  @override
  void initState() {
    super.initState();

    _trips = getTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<dynamic>(
          future: getTrips(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () {
                  setState(() {
                    _trips = getTrips();
                  });

                  return;
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    for (Trip item in snapshot.data)
                      Column(
                        children: [
                          ListTile(
                            title: Text(item.name),
                            contentPadding: const EdgeInsets.all(5.0),
                            key: Key(item.id.toString()),
                            leading: Icon(Icons.directions_car),
                            subtitle: Column(
                              children: <Widget>[
                                Text(item.description),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(item.startDate),
                                    Text(item.endDate),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          _trips = getTrips();
                        });
                      },
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("ERROR"),
                  IconButton(
                    iconSize: 32,
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      setState(() {
                        _trips = getTrips();
                      });
                    },
                  )
                ],
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<dynamic> getTrips() async {
  final response = await http.get('http://127.0.0.1:8000/api/v1/trips');

  if (response.statusCode == 200) {
    final decoded = json.decode(response.body);

    return decoded
        .map((dynamic map) =>
            standardSerializers.deserializeWith(Trip.serializer, map))
        .toList();
  } else {
    throw Exception('Failed to load trips');
  }
}

//class MyHomePage extends StatefulWidget {
//  const MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  var _activeIndex = 0;
//  final _pageCount = 4;
//
//  Widget _selectPage() {
//    return Stack(
//      children: List<Widget>.generate(_pageCount, (int index) {
//        return IgnorePointer(
//          ignoring: index != _activeIndex,
//          child: Opacity(
//            opacity: _activeIndex == index ? 1.0 : 0.0,
//            child: Navigator(
//              onGenerateRoute: (RouteSettings settings) {
//                return MaterialPageRoute(
//                  builder: (_) => _page(index),
//                  settings: settings,
//                );
//              },
//            ),
//          ),
//        );
//      }),
//    );
//  }
//
//  Widget _page(int index) {
//    switch (index) {
//      case 0:
//        return Feed();
//      case 1:
//        return TripList();
//      case 2:
//        return Drafts();
//      case 3:
//        return Profile();
//    }
//
//    return const Text("ERROR");
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: _selectPage(),
//
//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _activeIndex,
//        backgroundColor: Colors.black,
//        type: BottomNavigationBarType.fixed,
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home),
//            title: const Text("Feed"),
//            backgroundColor: Colors.black,
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.list),
//            title: const Text("Trips"),
//            backgroundColor: Colors.black,
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.layers),
//            title: const Text("Drafts"),
//            backgroundColor: Colors.black,
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.person),
//            title: const Text("Profile"),
//            backgroundColor: Colors.black,
//          ),
//        ],
//        showSelectedLabels: true,
//        showUnselectedLabels: false,
//        unselectedItemColor: Colors.grey[600],
//        selectedItemColor: Colors.white,
//        onTap: (index) {
//          setState(() {
//            _activeIndex = index;
//          });
//        },
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
