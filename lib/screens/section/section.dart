import 'package:TravelCompanion/screens/location/location.dart';
import 'package:TravelCompanion/screens/payment/paymentlist.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class Section extends StatefulWidget {
  final Map<String, dynamic> _section;

  const Section(this._section) : super();

  @override
  _SectionState createState() => _SectionState();
}

class _SectionState extends State<Section> {
  var _bottomNavIndex = 0;
  final _pageCount = 3;

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
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              flexibleSpace: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(
                      widget._section["image"].toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 80.0,
                      color: Colors.black54,
                      child: const Text(""),
                    ),
                  ),
                ],
              ),
              expandedHeight: 400.0,
              title: const Text("Section Details"),
              pinned: true,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(150.0),
                child: Text(""),
              ),
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
              leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back)),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              widget._section["image_caption"].toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time,
                                        size: 25.0,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          "${widget._section["start_time"]} - ${widget._section["end_time"]}",
                                          style:
                                              const TextStyle(fontSize: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.wb_sunny,
                                          size: 25.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            "${widget._section["temperature"].toString()} °C",
                                            style:
                                                const TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (widget._section["is_draft"] as bool)
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Chip(
                                    label: Text(
                                      "DRAFT",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            widget._section["content"].toString(),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                                "by ${widget._section["owner"]["first_name"]} ${widget._section["owner"]["last_name"]}"),
                            Text(widget._section["published_at_human_readable"]
                                .toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 1:
        return Location(widget._section["locationable"] as Map<String, dynamic>);
      case 2:
        return PaymentList(_mockPayments);
    }

    return const Text("ERROR");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_bottomNavIndex != 2)
          ? null
          : AppBar(
              title: const Text("Section Details"),
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
            icon: Icon(Icons.place),
            title: const Text("Location"),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: const Text("Payments"),
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
      "name": "Dinner McDonalds",
      "benificiary": "McDonalds",
      "date": "26/12/2019",
      "comments": null,
      "total_amount": 14.54,
      "currency": "USD",
      "tax_percentage": 0.0,
      "tip_amount": 0,
      "payers": [
        {
          "personal_amount": 4.51,
          "payed": false,
          "user": {
            "first_name": "Dan",
            "middle_name": null,
            "last_name": "Doe",
            "username": "dandoe",
          },
        },
        {
          "personal_amount": 5.12,
          "payed": false,
          "user": {
            "first_name": "Jane",
            "middle_name": null,
            "last_name": "Doe",
            "username": "janedoe",
          },
        },
        {
          "personal_amount": 4.91,
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
      "name": "Entrance Zoo",
      "benificiary": "LA Zoo",
      "date": "25/12/2019",
      "comments": null,
      "total_amount": 60.00,
      "currency": "USD",
      "tax_percentage": 0.0,
      "tip_amount": 0,
      "payers": [
        {
          "personal_amount": 20.00,
          "payed": false,
          "user": {
            "first_name": "Dan",
            "middle_name": null,
            "last_name": "Doe",
            "username": "dandoe",
          },
        },
        {
          "personal_amount": 20.00,
          "payed": true,
          "user": {
            "first_name": "Jane",
            "middle_name": null,
            "last_name": "Doe",
            "username": "janedoe",
          },
        },
        {
          "personal_amount": 20.00,
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
      "name": "Ice Cream Airport",
      "benificiary": "Schiphol",
      "date": "22/12/2019",
      "comments": null,
      "total_amount": 9.00,
      "currency": "EUR",
      "tax_percentage": 0.0,
      "tip_amount": 0,
      "payers": [
        {
          "personal_amount": 3.00,
          "payed": false,
          "user": {
            "first_name": "Dan",
            "middle_name": null,
            "last_name": "Doe",
            "username": "dandoe",
          },
        },
        {
          "personal_amount": 3.00,
          "payed": true,
          "user": {
            "first_name": "Jane",
            "middle_name": null,
            "last_name": "Doe",
            "username": "janedoe",
          },
        },
        {
          "personal_amount": 3.00,
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
