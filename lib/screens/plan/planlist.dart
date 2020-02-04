import 'package:flutter/material.dart';

class PlanList extends StatefulWidget {
  // TODO, IN PROGRESS, PENDING, DONE
  @override
  _PlanListState createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  Color _getStatusColor(String status) {
    switch (status) {
      case "TODO":
        return Colors.red;
      case "IN PROGRESS":
        return Colors.orange;
      case "PENDING":
        return Colors.orange;
      case "DONE":
        return Colors.green;
    }

    return Colors.grey[100];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _mockPlans[index]["isExpanded"] =
                !(_mockPlans[index]["isExpanded"].toString().toLowerCase() ==
                    "true");
          });
        },
        children: <ExpansionPanel>[
          for (var plan in _mockPlans)
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: plan["isExpanded"].toString().toLowerCase() == "true",
              headerBuilder: (BuildContext context, bool bool) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          plan["date"].toString(),
                          style: const TextStyle(fontSize: 30.0),
                        ),
                        if (plan["wifi_available"].toString().toLowerCase() ==
                            "true")
                          Icon(
                            Icons.network_wifi,
                            color: Colors.green,
                          ),
                        if (plan["wifi_available"].toString().toLowerCase() !=
                            "true")
                          Icon(
                            Icons.signal_wifi_off,
                            color: Colors.red,
                          ),
                      ],
                    ),
                  ),
                );
              },
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Icon(
                                  Icons.hotel,
                                  size: 30.0,
                                ),
                              ),
                              Text(
                                plan["sleeping_location"].toString(),
                                style: const TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          Chip(
                            label: Text(plan["status_sleep"].toString()),
                            backgroundColor: _getStatusColor(
                                plan["status_sleep"].toString()),
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(
                              Icons.drive_eta,
                              size: 30.0,
                            ),
                          ),
                          Text(
                            "${plan["driving_distance_km"]} km",
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(
                              Icons.attach_money,
                              size: 30.0,
                            ),
                          ),
                          Text(
                            plan["estimated_price"].toString(),
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(
                              Icons.place,
                              size: 30.0,
                            ),
                          ),
                          Flexible(
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: -6.0,
                              children: <Widget>[
                                for (var location in plan["locationables"])
                                  Chip(
                                    label: Text(location["name"].toString()),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Icon(
                                    Icons.short_text,
                                    size: 30.0,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    plan["program"].toString(),
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Chip(
                              label: Text(plan["status_activities"].toString()),
                              backgroundColor: _getStatusColor(
                                  plan["status_activities"].toString()),
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 36.0,
                      child: const Text(""),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  final _mockPlans = <Map<String, dynamic>>[
    {
      "date": "25/12/2019",
      "program":
          "Just another program and a lot of text to consider in the design, pretty annoying...",
      "driving_distance_km": 450,
      "wifi_available": true,
      "sleeping_location": "Camping in abcVillage",
      "estimated_price": 25.0,
      "currency": "USD",
      "status_sleep": "DONE",
      "status_activities": "IN PROGRESS",
      "locationables": [
        {
          "name": "Location A",
        },
        {
          "name": "Location B",
        },
        {
          "name": "Location C",
        },
      ],
      "isExpanded": false,
    },
    {
      "date": "26/12/2019",
      "program":
          "Again, a lot of text in this field. This day represents a day full of activities where we stay at the same location. Suddenly, no Wifi anymore.",
      "driving_distance_km": 50,
      "wifi_available": false,
      "sleeping_location": "Camping in abcVillage",
      "estimated_price": 50.0,
      "currency": "USD",
      "status_sleep": "DONE",
      "status_activities": "PENDING",
      "locationables": [
        {
          "name": "Location R",
        },
      ],
      "isExpanded": false,
    },
    {
      "date": "27/12/2019",
      "program":
          "A full day of driving towards the next location, not much to spend, no wifi.",
      "driving_distance_km": 680,
      "wifi_available": false,
      "sleeping_location": "Camping in efgVillage",
      "estimated_price": 15.0,
      "currency": "USD",
      "status_sleep": "TODO",
      "status_activities": "DONE",
      "locationables": [
        {
          "name": "Location A",
        },
        {
          "name": "Location R",
        },
        {
          "name": "Location L",
        },
        {
          "name": "Location A",
        },
        {
          "name": "Location R",
        },
        {
          "name": "Location P",
        },
        {
          "name": "Location S",
        },
        {
          "name": "Location N",
        },
        {
          "name": "Location V",
        },
      ],
      "isExpanded": true,
    }
  ];
}
