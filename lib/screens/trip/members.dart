import 'package:flutter/material.dart';

class Members extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Members",
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.person_add),
              ),
            ],
          ),
        ),
        const Divider(),
        for (var member in _mockMembers)
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  "${member["user"]["first_name"]} ${member["user"]["last_name"]}",
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text(member["role"].toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Visitors",
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.person_add),
              ),
            ],
          ),
        ),
        const Divider(),
        for (var visitor in _mockVisitors)
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                    "${visitor["user"]["first_name"]} ${visitor["user"]["last_name"]}",
                    style: const TextStyle(
                      fontSize: 20.0,
                    )),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation(Colors.green),
                          value: double.parse(visitor["progress"].toString()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(visitor["visit_start"].toString()),
                            Text(visitor["visit_end"].toString()),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
      ],
    );
  }

  final _mockMembers = <Map<String, dynamic>>[
    {
      "user": {
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "invitation_accepted": true,
      "role": "Administrator",
    },
    {
      "user": {
        "first_name": "Jane",
        "middle_name": null,
        "last_name": "Doe",
      },
      "invitation_accepted": true,
      "role": "Member",
    },
    {
      "user": {
        "first_name": "Joe",
        "middle_name": null,
        "last_name": "Doe",
      },
      "invitation_accepted": false,
      "role": "Watcher",
    },
  ];

  final _mockVisitors = <Map<String, dynamic>>[
    {
      "user": {
        "first_name": "Jade",
        "middle_name": null,
        "last_name": "Doe",
      },
      "invitation_accepted": true,
      "visit_start": "25/12/2019",
      "visit_end": "26/12/2019",
      "progress": 0.6,
    },
  ];
}
