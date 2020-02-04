import 'package:flutter/material.dart';

class Drafts extends StatefulWidget {
  @override
  _DraftsState createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey[400],
        controller: _tabController,
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.short_text),
            text: "Sections",
          ),
          Tab(
            icon: Icon(Icons.place),
            text: "Locations",
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: <Widget>[
              for (var sectionDraft in _mockSectionDrafts)
                Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(sectionDraft["content"].toString()),
                    ),
                    const Divider(),
                  ],
                ),
            ],
          ),
          ListView(
            children: <Widget>[
              for (var locationDraft in _mockLocationDrafts)
                Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(locationDraft["name"].toString()),
                    ),
                    const Divider(),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  final _mockLocationDrafts = <Map<String, dynamic>>[
    {
      "name": "Location 1",
      "info":
          "Just some info about this location. This might be a very long explanation.",
    },
    {
      "name": "Location 2",
      "info":
          "Another info section, this time about this location. This might be a very long explanation.",
    },
    {
      "name": "Location 3",
      "info":
          "The information of the third location-draft. Hold on! This might be a very long explanation.",
    },
  ];

  final _mockSectionDrafts = <Map<String, dynamic>>[
    {
      "content": "A lot of content already written in this draft of a section!",
      "locationable": {
        "name": "Hollywood Sign",
        "is_draft": false,
      },
      "start_time": "12:00",
      "end_time": "14:00",
      "temperature": 25.00,
      "image": "assets/img/sections/hollywood-sign.jpg",
      "image_caption": "The Hollywood Sign, again",
    },
    {
      "content": "A lot of content already written in this draft of a section!",
      "locationable": {
        "name": "Sleeping location #451",
        "is_draft": true,
      },
      "start_time": "12:00",
      "end_time": "14:00",
      "temperature": 25.00,
      "image": null,
      "image_caption": null,
    },
  ];
}
