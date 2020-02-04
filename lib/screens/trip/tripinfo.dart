import 'package:flutter/material.dart';

class TripInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _mockTrip["synopsis"].toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: LinearProgressIndicator(
                    value: double.parse(_mockTrip["progress"].toString()),
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_mockTrip["start_date"].toString()),
                    Text(_mockTrip["end_date"].toString()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(_mockTrip["description"].toString()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      "by ${_mockTrip["owner"]["first_name"]} ${_mockTrip["owner"]["last_name"]}"),
                  Text(_mockTrip["published_at_human_readable"].toString()),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Reports",
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.add,
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        for (var report in _mockReports)
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  report["date"].toString(),
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                subtitle: Text(
                  report["title"].toString(),
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                onTap: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed("/report");
                },
              ),
              const Divider(),
            ],
          ),
      ],
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

  final _mockReports = <Map<String, dynamic>>[
    {
      "id": 6,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "title": "The seventh report",
      "date": "27/12/2019",
      "description":
          "This is the first report of the trip, it describes the first day, including complete journey and arrival (The day of travel is one before the day of arrival but we regard it as one, because we didn't sleep and thus percieved it as one day). A quick summary of the day is: We first took the flight from DUS to AMS and waited for a very long time in AMS. There where plenty of things to do in the transit area. The second flight was way too long. Border was fine in LA. Devin picked us up at LAX, we got donuts, drove through LA, saw hollywood signs in the distance, went closer, went to griffith observatory and finally at the end of the day to Yorba Linda, our settlement for the next few days.",
      "visibility": "public",
      "published_at_human_readable": "18 minutes ago",
    },
    {
      "id": 5,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "title": "The sixth report",
      "date": "26/12/2019",
      "description":
          "This is the first report of the trip, it describes the first day, including complete journey and arrival (The day of travel is one before the day of arrival but we regard it as one, because we didn't sleep and thus percieved it as one day). A quick summary of the day is: We first took the flight from DUS to AMS and waited for a very long time in AMS. There where plenty of things to do in the transit area. The second flight was way too long. Border was fine in LA. Devin picked us up at LAX, we got donuts, drove through LA, saw hollywood signs in the distance, went closer, went to griffith observatory and finally at the end of the day to Yorba Linda, our settlement for the next few days.",
      "visibility": "public",
      "published_at_human_readable": "18 minutes ago",
    },
    {
      "id": 4,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "title": "The fourth report",
      "date": "25/12/2019",
      "description":
          "This is the first report of the trip, it describes the first day, including complete journey and arrival (The day of travel is one before the day of arrival but we regard it as one, because we didn't sleep and thus percieved it as one day). A quick summary of the day is: We first took the flight from DUS to AMS and waited for a very long time in AMS. There where plenty of things to do in the transit area. The second flight was way too long. Border was fine in LA. Devin picked us up at LAX, we got donuts, drove through LA, saw hollywood signs in the distance, went closer, went to griffith observatory and finally at the end of the day to Yorba Linda, our settlement for the next few days.",
      "visibility": "public",
      "published_at_human_readable": "18 minutes ago",
    },
    {
      "id": 3,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "title": "The third report",
      "date": "24/12/2019",
      "description":
          "This is the first report of the trip, it describes the first day, including complete journey and arrival (The day of travel is one before the day of arrival but we regard it as one, because we didn't sleep and thus percieved it as one day). A quick summary of the day is: We first took the flight from DUS to AMS and waited for a very long time in AMS. There where plenty of things to do in the transit area. The second flight was way too long. Border was fine in LA. Devin picked us up at LAX, we got donuts, drove through LA, saw hollywood signs in the distance, went closer, went to griffith observatory and finally at the end of the day to Yorba Linda, our settlement for the next few days.",
      "visibility": "public",
      "published_at_human_readable": "18 minutes ago",
    },
    {
      "id": 2,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "title": "The second report",
      "date": "23/12/2019",
      "description":
          "This is the first report of the trip, it describes the first day, including complete journey and arrival (The day of travel is one before the day of arrival but we regard it as one, because we didn't sleep and thus percieved it as one day). A quick summary of the day is: We first took the flight from DUS to AMS and waited for a very long time in AMS. There where plenty of things to do in the transit area. The second flight was way too long. Border was fine in LA. Devin picked us up at LAX, we got donuts, drove through LA, saw hollywood signs in the distance, went closer, went to griffith observatory and finally at the end of the day to Yorba Linda, our settlement for the next few days.",
      "visibility": "public",
      "published_at_human_readable": "18 minutes ago",
    },
    {
      "id": 1,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "title": "The first report",
      "date": "22/12/2019",
      "description":
          "This is the first report of the trip, it describes the first day, including complete journey and arrival (The day of travel is one before the day of arrival but we regard it as one, because we didn't sleep and thus percieved it as one day). A quick summary of the day is: We first took the flight from DUS to AMS and waited for a very long time in AMS. There where plenty of things to do in the transit area. The second flight was way too long. Border was fine in LA. Devin picked us up at LAX, we got donuts, drove through LA, saw hollywood signs in the distance, went closer, went to griffith observatory and finally at the end of the day to Yorba Linda, our settlement for the next few days.",
      "visibility": "public",
      "published_at_human_readable": "18 minutes ago",
    },
  ];
}
