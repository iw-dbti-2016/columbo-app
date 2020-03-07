import 'dart:convert';

import 'package:Columbo/models/report.dart';
import 'package:Columbo/models/section.dart';
import 'package:Columbo/models/serializers.dart';
import 'package:Columbo/models/trip.dart';
import 'package:Columbo/models/location.dart';
import 'package:Columbo/models/poi.dart';

import 'package:Columbo/widgets/columbo_logo.dart';
import 'package:Columbo/widgets/drawer_text.dart';
import 'package:Columbo/widgets/drawer_button.dart';

import 'package:Columbo/screens/lists/location_list.dart';
import 'package:Columbo/screens/lists/poi_list.dart';
import 'package:Columbo/screens/lists/report_list.dart';
import 'package:Columbo/screens/lists/section_list.dart';
import 'package:Columbo/screens/lists/trip_list.dart';

import 'package:Columbo/theme/style.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() => runApp(Columbo());

class Columbo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set color of the status bar and icons (android + iOS)
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
        backgroundColor: Colors.white,
        toolbarOpacity: 1,
        title: ColumboLogo(),
        centerTitle: true,
      ),
      body: Center(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refreshList,
          child: _createPage(), //snapshot.data),
        ),
      ),
      drawer: _createDrawer(),
    );
  }

  Widget _createDrawer() {
    return Drawer(
      child: Scrollbar(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 4, 8),
              child: ColumboLogo(),
            ),
            const Divider(),
            const ListTile(
              enabled: false,
              title: Text('Timeline'),
              leading: Icon(
                Icons.home,
              ),
            ),
            const Divider(),
            const DrawerText("Entities"),
            DrawerButton(
              index: 0,
              label: 'Trips',
              icon: Icons.directions_car,
              onTap: _onDrawerButtonTapped,
            ),
            DrawerButton(
              index: 1,
              label: 'Reports',
              icon: Icons.folder_open,
              onTap: _onDrawerButtonTapped,
            ),
            DrawerButton(
              index: 2,
              label: 'Sections',
              icon: Icons.format_align_left,
              onTap: _onDrawerButtonTapped,
            ),
            DrawerButton(
              index: 3,
              label: 'Locations',
              icon: Icons.location_on,
              onTap: _onDrawerButtonTapped,
            ),
            DrawerButton(
              index: 4,
              label: 'Points of Interest',
              icon: Icons.star_border,
              onTap: _onDrawerButtonTapped,
            ),
            const Divider(),
            const DrawerText("Account"),
            const ListTile(
              enabled: false,
              title: Text('Settings'),
              leading: Icon(
                Icons.settings,
              ),
            ),
            const ListTile(
              enabled: false,
              title: Text('Profile'),
              leading: Icon(
                Icons.account_circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDrawerButtonTapped(int index) {
    setState(() {
      _listData = null;
      _selectedNavBarIndex = index;
    });

    _refreshList();
    Navigator.pop(context);
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
        return getResourceList('trips', Trip.serializer);
      case 1:
        return getResourceList('reports', Report.serializer);
      case 2:
        return getResourceList('sections', Section.serializer);
      case 3:
        return getResourceList('locations', Location.serializer);
      case 4:
        return getResourceList('pois', Poi.serializer);
      default:
        throw Exception('Undefined page index');
    }
  }
}

Future<dynamic> getResourceList(String url, Serializer serializer) async {
  final response = await http.get('http://127.0.0.1:8000/api/v1/$url');

  if (response.statusCode != 200) {
    handleError(response);
    return;
  }

  return json
      .decode(response.body)
      .map(
          (dynamic map) => standardSerializers.deserializeWith(serializer, map))
      .toList();
}

void handleError(dynamic response) {
  throw Exception('Failed to load resource');
}
