import 'dart:convert';

import 'package:TravelCompanion/models/report.dart';
import 'package:TravelCompanion/models/serializers.dart';
import 'package:TravelCompanion/models/trip.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'screens/lists/report_list.dart';
import 'screens/lists/trip_list.dart';
import 'theme/style.dart';

void main() => runApp(TravelCompanion());

class TravelCompanion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'TravelCompanion'),
      theme: theme,
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
  int _selectedNavBarIndex;

  @override
  void initState() {
    super.initState();

    _selectedNavBarIndex = 0;
    _trips = _getData();
  }

  Future<dynamic> _getData() {
    switch (_selectedNavBarIndex) {
      case 0:
        return getTrips();
      case 1:
        return getReports();
      default:
        throw Exception('Undefined page index');
    }
  }

  void _onNavbarItemTapped(int index) {
    setState(() {
      _selectedNavBarIndex = index;
    });
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car),
          title: Text("Trips"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder),
          title: Text("Reports"),
        ),
      ],
      currentIndex: _selectedNavBarIndex,
      selectedItemColor: Colors.black,
      onTap: _onNavbarItemTapped,
    );
  }

  Widget _createPage(dynamic data) {
    switch (_selectedNavBarIndex) {
      case 0:
        return TripList(data);
      case 1:
        return ReportList(data);
      default:
        throw Exception('Undefined page index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: _createBottomNavigationBar(),
      body: Center(
        child: FutureBuilder<dynamic>(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () {
                  final trips = _getData();

                  setState(() {
                    _trips = trips;
                  });

                  return trips;
                },
                child: _createPage(snapshot.data),
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
  final responseBody = await getResource('trips');
  return responseBody
      .map((dynamic map) =>
          standardSerializers.deserializeWith(Trip.serializer, map))
      .toList();
}

Future<dynamic> getReports() async {
  final responseBody = await getResource('reports');
  return responseBody
      .map((dynamic map) =>
          standardSerializers.deserializeWith(Report.serializer, map))
      .toList();
}

Future<dynamic> getResource(String url) async {
  final response = await http.get('http://127.0.0.1:8000/api/v1/$url');

  if (response.statusCode != 200) {
    handleError(response);
    return;
  }

  return json.decode(response.body);
}

void handleError(dynamic response) {
  throw Exception('Failed to load resource');
}
