import 'package:flutter/material.dart';

class TripList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        for (var mockTrip in _mockTripList)
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 6.0),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          mockTrip["name"].toString(),
                          style: const TextStyle(fontSize: 25.0),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(6.0, 6.0, 0.0, 0.0),
                        child: Text(
                          mockTrip["published_at_human_readable"].toString(),
                          style: TextStyle(
                              fontSize: 14.0, color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(mockTrip["synopsis"].toString()),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: LinearProgressIndicator(
                              value: double.parse(mockTrip["progress"].toString()),
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation(Colors.green),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                mockTrip["start_date"].toString(),
                              ),
                              Text(
                                mockTrip["end_date"].toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamed("/trip");
                  },
                ),
              ),
              const Divider(),
            ],
          ),
      ],
    );
  }

  final _mockTripList = <Map<String, dynamic>>[
    {
      "id": 5,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "name": "Fifth trip to Paris, the capital of France!",
      "synopsis":
          "Small trip to Paris. Paid in full by the company, otherwise I wouldn't go to Paris!",
      "description":
          "This is the description of our recent trip to LA and surrounding area.",
      "start_date": "25/12/2019",
      "end_date": "26/12/2019",
      "visibility": "public",
      "published_at_human_readable": "12 seconds ago",
      "progress": 0.9,
    },
    {
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
      "visibility": "public",
      "published_at_human_readable": "2 weeks ago",
      "progress": 0.8,
    },
    {
      "id": 2,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "name": "Second trip!",
      "synopsis": "Small trip to SF",
      "description":
          "This is the description of our recent trip to LA and surrounding area.",
      "start_date": "25/12/2019",
      "end_date": "26/12/2019",
      "visibility": "public",
      "published_at_human_readable": "6 months ago",
      "progress": 0.1,
    },
    {
      "id": 3,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "name": "Third trip!",
      "synopsis": "Small trip to SD",
      "description":
          "This is the description of our recent trip to LA and surrounding area.",
      "start_date": "22/02/2020",
      "end_date": "30/03/2020",
      "visibility": "public",
      "published_at_human_readable": "12 hours ago",
      "progress": 0.0,
    },
    {
      "id": 4,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "name": "Fourth trip!",
      "synopsis": "Small trip to LV",
      "description":
          "This is the description of our recent trip to LA and surrounding area.",
      "start_date": "22/04/2020",
      "end_date": "30/04/2020",
      "visibility": "public",
      "published_at_human_readable": "5 months ago",
      "progress": 0.0,
    },
    {
      "id": 6,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "name": "USA 2020",
      "synopsis": "Slightly longer trip to west-USA",
      "description":
          "Trip to western USA, visiting CA, NV, AZ?, UT, ID and OR. Road-trip.",
      "start_date": "30/06/2020",
      "end_date": "02/08/2020",
      "visibility": "public",
      "published_at_human_readable": "3 days ago",
      "progress": 0.0,
    }
  ];
}
