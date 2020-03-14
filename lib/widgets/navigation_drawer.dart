import 'package:Columbo/services/secure_storage.dart';
import 'package:Columbo/widgets/columbo_logo.dart';
import 'package:Columbo/widgets/drawer_button.dart';
import 'package:Columbo/widgets/drawer_text.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool authenticatedUser = false;

  @override
  void initState() {
    isInStorage('token').then((value) => setState(() {
          authenticatedUser = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scrollbar(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 4, 8),
              child: ColumboLogo(),
            ),
            const Divider(),
            DrawerButton(
              label: 'Timeline',
              icon: Icons.home,
              route: '/home',
            ),
            const Divider(),
            const DrawerText("Entities"),
            DrawerButton(
              label: 'Trips',
              icon: Icons.directions_car,
              route: '/trips/list',
            ),
            DrawerButton(
              label: 'Reports',
              icon: Icons.folder_open,
              route: '/reports/list',
            ),
            DrawerButton(
              label: 'Sections',
              icon: Icons.format_align_left,
              route: '/sections/list',
            ),
            DrawerButton(
              label: 'Locations',
              icon: Icons.location_on,
              route: '/locations/list',
            ),
            DrawerButton(
              label: 'Points of Interest',
              icon: Icons.star_border,
              route: '/pois/list',
            ),
            const Divider(),
            const DrawerText("Account"),
            if (authenticatedUser)
              const ListTile(
                enabled: false,
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,
                ),
              ),
            if (authenticatedUser)
              const ListTile(
                enabled: false,
                title: Text('Profile'),
                leading: Icon(
                  Icons.account_circle,
                ),
              ),
            if (authenticatedUser)
              DrawerButton(
                label: 'Log out',
                icon: Icons.lock_outline,
                route: '/auth/login',
                onTapExtra: () {
                  removeFromStorage('token');
                },
              ),
            if (!authenticatedUser)
              DrawerButton(
                label: 'Log in',
                icon: Icons.lock_open,
                route: '/auth/login',
              ),
          ],
        ),
      ),
    );
  }
}
