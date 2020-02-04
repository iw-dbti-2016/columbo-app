import 'package:TravelCompanion/screens/payment/paymentlist.dart';
import 'package:TravelCompanion/screens/plan/planlist.dart';
import 'package:TravelCompanion/screens/trip/members.dart';
import 'package:TravelCompanion/screens/trip/tripinfo.dart';

import 'package:flutter/material.dart';

class Trip extends StatefulWidget {
  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
  var _bottomNavIndex = 0;
  final _pageCount = 4;

  Widget _selectPage() {
    return Stack(
      children: List<Widget>.generate(_pageCount, (int index) {
        return IgnorePointer(
          ignoring: index != _bottomNavIndex,
          child: Opacity(
            opacity: _bottomNavIndex == index ? 1.0 : 0.0,
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
        return TripInfo();
      case 1:
        return PlanList();
      case 2:
        return PaymentList(_mockPayments);
      case 3:
        return Members();
    }

    return const Text("ERROR");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_mockTrip["name"].toString()),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(Icons.edit),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: _selectPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: const Text("Info"),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: const Text("Plans"),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: const Text("Payments"),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            title: const Text("Members"),
            backgroundColor: Colors.black,
          ),
        ],
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }

  final _mockTrip = <String, dynamic>{
    "id": 1,
    "owner": <String, dynamic>{
      "first_name": "John",
      "middle_name": null,
      "last_name": "Doe",
    },
    "name": "First trip!",
    "synopsis": "Small trip to LA",
    "description":
        "This is the description of our recent trip to LA and surrounding area.",
    "start_date": "22/12/2019",
    "end_date": "30/12/2019",
    "progress": 0.6,
    "visibility": "public",
    "published_at_human_readable": "2 hours ago",
  };

  final _mockPayments = <Map<String, dynamic>>[
    {
      "id": 1,
      "uuid": "klsdjflsdf-sdlfkjs-lsjdf-lkdjfmlkjqds",
      "trip_id": 1,
      "section_id": null,
      "payer": {
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
        "username": "johndoe",
      },
      "name": "Rentalcar",
      "benificiary": "AutoEurope",
      "date": "01/01/2020",
      "comments": "Prone to change if we find cheaper price",
      "total_amount": 1648.54,
      "currency": "EUR",
      "tax_percentage": 0.0,
      "tip_amount": 0,
      "payers": [
        {
          "personal_amount": 549.51,
          "payed": false,
          "user": {
            "first_name": "Dan",
            "middle_name": null,
            "last_name": "Doe",
            "username": "dandoe",
          },
        },
        {
          "personal_amount": 549.51,
          "payed": false,
          "user": {
            "first_name": "Jane",
            "middle_name": null,
            "last_name": "Doe",
            "username": "janedoe",
          },
        },
        {
          "personal_amount": 549.52,
          "payed": true,
          "user": {
            "first_name": "John",
            "middle_name": null,
            "last_name": "Doe",
            "username": "johndoe",
          },
        },
      ],
      "isExpanded": false,
    },
    {
      "id": 2,
      "uuid": "klsdjflsdf-sdlfkjs-lsjdf-lkdjfmlkjqds",
      "trip_id": 1,
      "section_id": null,
      "payer": {
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
        "username": "johndoe",
      },
      "name": "Plane Tickets",
      "benificiary": "Kayak",
      "date": "20/11/2019",
      "comments": null,
      "total_amount": 463.24,
      "currency": "EUR",
      "tax_percentage": 0.0,
      "tip_amount": 0,
      "payers": [
        {
          "personal_amount": 145.15,
          "payed": false,
          "user": {
            "first_name": "Dan",
            "middle_name": null,
            "last_name": "Doe",
            "username": "dandoe",
          },
        },
        {
          "personal_amount": 186.44,
          "payed": true,
          "user": {
            "first_name": "Jane",
            "middle_name": null,
            "last_name": "Doe",
            "username": "janedoe",
          },
        },
        {
          "personal_amount": 131.65,
          "payed": true,
          "user": {
            "first_name": "John",
            "middle_name": null,
            "last_name": "Doe",
            "username": "johndoe",
          },
        },
      ],
      "isExpanded": true,
    },
  ];
}
