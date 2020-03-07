import 'dart:convert';

import 'package:Columbo/models/report.dart';
import 'package:Columbo/models/section.dart';
import 'package:Columbo/models/serializers.dart';
import 'package:Columbo/models/trip.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'models/location.dart';
import 'models/poi.dart';
import 'screens/lists/location_list.dart';
import 'screens/lists/poi_list.dart';
import 'screens/lists/report_list.dart';
import 'screens/lists/section_list.dart';
import 'screens/lists/trip_list.dart';
import 'theme/style.dart';

void main() => runApp(Columbo());

class Columbo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'Columbo'),
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  dynamic _listData;
  int _selectedNavBarIndex;

  @override
  void initState() {
    super.initState();

    _selectedNavBarIndex = 0;
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: _createBottomNavigationBar(),
      body: Center(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refreshList,
          child: _createPage(), //snapshot.data),
        ),
      ),
      drawer: Drawer(
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'TravelCompanion',
                    style: TextStyle(
                      color: Colors.green[600],
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const Divider(),
                const ListTile(
                  enabled: false,
                  title: Text('Timeline'),
                  leading: Icon(
                    Icons.home,
//                color: Colors.black,
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    setState(() {
                      _listData = null;
                      _selectedNavBarIndex = 0;
                    });
                    _refreshList();
                    Navigator.pop(context);
                  },
                  highlightColor: Colors.green[100],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  child: const ListTile(
                    title: Text('Trips'),
                    leading: Icon(
                      Icons.directions_car,
                      color: Colors.black,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _listData = null;
                      _selectedNavBarIndex = 1;
                    });
                    _refreshList();
                    Navigator.pop(context);
                  },
                  highlightColor: Colors.green[100],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  child: const ListTile(
                    title: Text('Reports'),
                    leading: Icon(
                      Icons.folder_open,
                      color: Colors.black,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _listData = null;
                      _selectedNavBarIndex = 2;
                    });
                    _refreshList();
                    Navigator.pop(context);
                  },
                  highlightColor: Colors.green[100],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  child: const ListTile(
                    title: Text('Sections'),
                    leading: Icon(
                      Icons.format_align_left,
                      color: Colors.black,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _listData = null;
                      _selectedNavBarIndex = 3;
                    });
                    _refreshList();
                    Navigator.pop(context);
                  },
                  highlightColor: Colors.green[100],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  child: const ListTile(
                    title: Text('Locations'),
                    leading: Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _listData = null;
                      _selectedNavBarIndex = 4;
                    });
                    _refreshList();
                    Navigator.pop(context);
                  },
                  highlightColor: Colors.green[100],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  child: const ListTile(
                    title: Text('Points of Interest'),
                    leading: Icon(
                      Icons.star_border,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Divider(),
                const ListTile(
                  enabled: false,
                  title: Text('Settings'),
                  leading: Icon(
                    Icons.settings,
//                color: Colors.black,
                  ),
                ),
                const ListTile(
                  enabled: false,
                  title: Text('Profile'),
                  leading: Icon(
                    Icons.account_circle,
//                color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      fixedColor: Colors.black,
      unselectedItemColor: Colors.black,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car),
          title: Text("Trips"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder_open),
          title: Text("Reports"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_align_left),
          title: Text('Sections'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          title: Text('Locations'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border),
          title: Text('POIs'),
        ),
      ],
      currentIndex: _selectedNavBarIndex,
//      selectedItemColor: Colors.black,
      onTap: _onNavbarItemTapped,
    );
  }

  void _onNavbarItemTapped(int index) {
    setState(() {
      _listData = null;
      _selectedNavBarIndex = index;
    });
    _refreshList();
  }

  Future<void> _refreshList() async {
    return _getData().then((listData) => setState(() {
          _listData = listData;
        }));
  }

  Widget _createPage() {
    switch (_selectedNavBarIndex) {
      case 0:
        return TripList(_listData);
      case 1:
        return ReportList(_listData);
      case 2:
        return SectionList(_listData);
      case 3:
        return LocationList(_listData);
      case 4:
        return PoiList(_listData);
      default:
        throw Exception('Undefined page index');
    }
  }

  Future<dynamic> _getData() {
    switch (_selectedNavBarIndex) {
      case 0:
        return getTrips();
      case 1:
        return getReports();
      case 2:
        return getSections();
      case 3:
        return getLocations();
      case 4:
        return getPois();
      default:
        throw Exception('Undefined page index');
    }
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

Future<dynamic> getSections() async {
  final responseBody = await getResource('sections');
  return responseBody
      .map((dynamic map) =>
          standardSerializers.deserializeWith(Section.serializer, map))
      .toList();
}

Future<dynamic> getLocations() async {
  final responseBody = await getResource('locations');
  return responseBody
      .map((dynamic map) =>
          standardSerializers.deserializeWith(Location.serializer, map))
      .toList();
}

Future<dynamic> getPois() async {
  final responseBody = await getResource('pois');
  return responseBody
      .map((dynamic map) =>
          standardSerializers.deserializeWith(Poi.serializer, map))
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
