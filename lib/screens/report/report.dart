import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
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

  void _openSection(BuildContext context, section) {
    Navigator.of(context).pushNamed("/section", arguments: section);
  }

  ExpansionPanel _makePlanPanel() => ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: _mockPlan["isExpanded"] as bool,
        headerBuilder: (BuildContext context, bool bool) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _mockPlan["date"].toString(),
                    style: const TextStyle(fontSize: 30.0),
                  ),
                  if (_mockPlan["wifi_available"].toString().toLowerCase() ==
                      "true")
                    Icon(
                      Icons.network_wifi,
                      color: Colors.green,
                    ),
                  if (_mockPlan["wifi_available"].toString().toLowerCase() !=
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
              const Text(
                "PLANNING",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
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
                          _mockPlan["sleeping_location"].toString(),
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    Chip(
                      label: Text(_mockPlan["status_sleep"].toString()),
                      backgroundColor:
                          _getStatusColor(_mockPlan["status_sleep"].toString()),
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
                      "${_mockPlan["driving_distance_km"]} km",
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
                      _mockPlan["estimated_price"].toString(),
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
                          for (var location in _mockPlan["locationables"])
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
                              _mockPlan["program"].toString(),
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
                        label: Text(_mockPlan["status_activities"].toString()),
                        backgroundColor: _getStatusColor(
                            _mockPlan["status_activities"].toString()),
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
      );

  @override
  Widget build(BuildContext context) {
    final tileList = <Widget>[];

    for (final section in _mockSections) {
      tileList.add(
        InkWell(
          onTap: () {
            _openSection(context, section);
          },
          child: Container(
            padding: (_mockSections.last != section)
                ? const EdgeInsets.only(left: 20.0)
                : const EdgeInsets.symmetric(horizontal: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    section['image'].toString(),
                    height: 300.0,
                    fit: BoxFit.cover,
                    width: 300.0,
                  ),
                  if (section["is_draft"].toString().toLowerCase() == "true")
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(5.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 12.0,
                          ),
                          color: Colors.red,
                          child: Text(
                            "DRAFT",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_mockReport['title'].toString()),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(Icons.edit),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _mockPlan["isExpanded"] =
                    !(_mockPlan["isExpanded"].toString().toLowerCase() ==
                        "true");
              });
            },
            children: <ExpansionPanel>[
              _makePlanPanel(),
            ],
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 0.0),
            title: Text(
              _mockReport['description'].toString(),
              textAlign: TextAlign.justify,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text("By "),
                      Text(
                        "${_mockReport['owner']['first_name']} ${_mockReport['owner']['last_name']}",
                        style: TextStyle(
                          color: Colors.blue[600],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    _mockReport['published_at_human_readable'].toString(),
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Sections",
                  style: TextStyle(
                    fontSize: 35.0,
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
          ListTile(
            contentPadding: const EdgeInsets.only(bottom: 14.0),
            title: Container(
              height: 300.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: tileList,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final _mockPlan = <String, dynamic>{
    "date": "22/12/2019",
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
        "name": "McDonalds",
      },
      {
        "name": "Hollywood Sign",
      },
      {
        "name": "Yorba Linda",
      },
    ],
    "isExpanded": false,
  };

  final _mockReport = <String, dynamic>{
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
  };

  final _mockSections = <Map<String, dynamic>>[
    {
      "id": 1,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "is_draft": false,
      "content": "This is the first section",
      "image": "assets/img/sections/plane.jpg",
      "image_caption": "View from the plane",
      "start_time": "00:00",
      "end_time": "13:00",
      "temperature": null,
      "visibility": "public",
      "published_at_human_readable": "18 minutes ago",
      "locationable": {
        "id": 45,
        "owner": {          /// NOT FOR POI
          "first_name": "John",
          "middle_name": null,
          "last_name": "Doe",
          "username": "johndoe",
        },
        "is_draft": true,  /// NOT FOR POI
        "coordinates": {
          "coordinates": [12.547854, -45.587795],
        },
        "map_zoom": 8.0,
        "name": "Nice location",
        "info": "Just another nice location on the globe. This is the first location of the trip, it describes the first day, including complete journey and arrival (The day of travel is one before the day of arrival but we regard it as one, because we didn't sleep and thus percieved it as one day). A quick summary of the day is: We first took the flight from DUS to AMS and waited for a very long time in AMS. There where plenty of things to do in the transit area. The second flight was way too long. Border was fine in LA. Devin picked us up at LAX, we got donuts, drove through LA, saw hollywood signs in the distance, went closer, went to griffith observatory and finally at the end of the day to Yorba Linda, our settlement for the next few days.",
        "visibility": "friends",                      /// NOT FOR POI
        "published_at_human_readable": "15 days ago", /// NOT FOR POI
      },
    },
    {
      "id": 2,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "is_draft": false,
      "content": "This is the second section",
      "image": "assets/img/sections/lax.jpg",
      "image_caption": "LAX Airport",
      "start_time": "13:00",
      "end_time": "14:30",
      "temperature": 25.00,
      "visibility": "public",
      "published_at_human_readable": "16 minutes ago",
      "locationable": {
        "id": 45,
        "owner": {          /// NOT FOR POI
          "first_name": "John",
          "middle_name": null,
          "last_name": "Doe",
          "username": "johndoe",
        },
        "is_draft": false,  /// NOT FOR POI
        "coordinates": {
          "coordinates": [12.547854, -45.587795],
        },
        "map_zoom": 8.0,
        "name": "Nice location",
        "info": "Just another nice location on the globe.",
        "visibility": "friends",                      /// NOT FOR POI
        "published_at_human_readable": "15 days ago", /// NOT FOR POI
      },
    },
    {
      "id": 3,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "is_draft": false,
      "content": "This is the third section",
      "image": "assets/img/sections/donut.jpg",
      "image_caption": "Randy's Donuts",
      "start_time": "14:45",
      "end_time": "15:00",
      "temperature": 23.00,
      "visibility": "public",
      "published_at_human_readable": "14 minutes ago",
      "locationable": {
        "id": 45,
        "owner": {          /// NOT FOR POI
          "first_name": "John",
          "middle_name": null,
          "last_name": "Doe",
          "username": "johndoe",
        },
        "is_draft": false,  /// NOT FOR POI
        "coordinates": {
          "coordinates": [12.547854, -45.587795],
        },
        "map_zoom": 8.0,
        "name": "Nice location",
        "info": "Just another nice location on the globe.",
        "visibility": "friends",                      /// NOT FOR POI
        "published_at_human_readable": "15 days ago", /// NOT FOR POI
      },
    },
    {
      "id": 4,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "is_draft": true,
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maiores, eum veritatis! Facilis, ipsum rem. Veritatis libero dolorem ex vitae ipsam doloribus blanditiis ratione aliquid. Totam fugiat enim porro ratione eos libero eum, deleniti beatae ut aspernatur, ipsam nisi, repellat rem nam fugit sunt iusto nemo tempora perspiciatis ullam magni? Numquam perspiciatis alias fugiat laudantium libero totam incidunt quidem eveniet similique error illum id, laboriosam delectus maiores officia exercitationem. Nobis ut explicabo id recusandae aspernatur deserunt nesciunt doloremque fuga quam pariatur hic, culpa consequatur quia rem quae saepe, alias ratione. Magni cumque nemo ipsam. Magni molestiae nam repellendus mollitia ea placeat, eos quam quidem cupiditate libero facilis perferendis, cum atque, repudiandae dolorum! Perferendis minus assumenda, sapiente quidem suscipit, cum reprehenderit ut esse ab facilis repudiandae cumque sunt illum cupiditate a consectetur incidunt, accusantium asperiores nulla repellat ratione quos rem! Reiciendis non sit pariatur voluptas officiis ipsum labore, alias incidunt optio architecto mollitia atque tempora, placeat! Ea saepe modi, ex. Eius praesentium saepe, officia itaque repellat labore dolore unde quo fuga tempore quam totam, nostrum quibusdam deleniti nam, quod odio velit nemo! Porro numquam deleniti, quae officia, doloribus assumenda facilis consequuntur iusto voluptatum quis odio dignissimos itaque fugit inventore ut dolor impedit veniam consequatur illo commodi repudiandae voluptate praesentium. Consequatur aliquam voluptates ullam quod officiis? Eum necessitatibus fuga, illo nisi, molestias laborum excepturi commodi nam facilis. Ab ipsum ut amet neque repudiandae asperiores non incidunt, similique eveniet maxime natus perspiciatis quia aliquid excepturi cum iste praesentium, in vero sunt quis. Nemo quisquam consequuntur commodi amet, autem ipsam, at dicta aliquid, iste nulla totam quia minus illum modi beatae, perferendis quam ipsum. Sit maiores alias amet quod dolorem laboriosam, blanditiis facilis molestias voluptate nam libero quo facere. Amet aliquam maiores, quasi aspernatur tenetur asperiores voluptates a, perferendis quas ut dolore voluptatibus quod illum similique pariatur id! Mollitia doloremque maiores magni aliquam earum nihil neque adipisci cumque expedita quam deserunt odio impedit, esse repellendus iure ducimus, quos sequi, incidunt, similique cum velit asperiores. Asperiores laboriosam quidem fugiat odit saepe doloribus reprehenderit laborum consequuntur, cum. Perspiciatis et sapiente molestias explicabo repellat mollitia accusamus, enim deleniti illo vel eum ab soluta dolorem minus voluptatibus quisquam quis sed facere debitis adipisci, consequatur. Aspernatur quidem, fuga quis dolorem nesciunt sapiente quam, tempora tempore labore, in optio vel vero facere commodi rem. Blanditiis expedita iusto accusantium praesentium dolorem nesciunt beatae at earum sequi dolore facilis fugiat nihil odit tempora numquam est cupiditate doloribus pariatur illum aliquam cum, repudiandae veniam. Quibusdam rerum iure, id doloremque nihil ipsam soluta ex mollitia cum, illum sapiente debitis enim nobis ullam molestias natus sequi. Ad, doloribus, quas. Quis id, tempora eveniet sequi modi in exercitationem! Inventore, eaque vel ipsum nostrum vero dolore, temporibus ea ipsam iure. Cumque in error suscipit deleniti harum alias omnis maiores perferendis amet animi magni voluptates, inventore dolorem ducimus magnam, cum dolore repellendus doloremque maxime, tenetur dolores voluptate? Et qui necessitatibus est expedita nisi facere optio repudiandae impedit sunt sequi ipsa, praesentium obcaecati libero explicabo, eum, officia odio numquam animi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maiores, eum veritatis! Facilis, ipsum rem. Veritatis libero dolorem ex vitae ipsam doloribus blanditiis ratione aliquid. Totam fugiat enim porro ratione eos libero eum, deleniti beatae ut aspernatur, ipsam nisi, repellat rem nam fugit sunt iusto nemo tempora perspiciatis ullam magni? Numquam perspiciatis alias fugiat laudantium libero totam incidunt quidem eveniet similique error illum id, laboriosam delectus maiores officia exercitationem. Nobis ut explicabo id recusandae aspernatur deserunt nesciunt doloremque fuga quam pariatur hic, culpa consequatur quia rem quae saepe, alias ratione. Magni cumque nemo ipsam. Magni molestiae nam repellendus mollitia ea placeat, eos quam quidem cupiditate libero facilis perferendis, cum atque, repudiandae dolorum! Perferendis minus assumenda, sapiente quidem suscipit, cum reprehenderit ut esse ab facilis repudiandae cumque sunt illum cupiditate a consectetur incidunt, accusantium asperiores nulla repellat ratione quos rem! Reiciendis non sit pariatur voluptas officiis ipsum labore, alias incidunt optio architecto mollitia atque tempora, placeat! Ea saepe modi, ex. Eius praesentium saepe, officia itaque repellat labore dolore unde quo fuga tempore quam totam, nostrum quibusdam deleniti nam, quod odio velit nemo! Porro numquam deleniti, quae officia, doloribus assumenda facilis consequuntur iusto voluptatum quis odio dignissimos itaque fugit inventore ut dolor impedit veniam consequatur illo commodi repudiandae voluptate praesentium. Consequatur aliquam voluptates ullam quod officiis? Eum necessitatibus fuga, illo nisi, molestias laborum excepturi commodi nam facilis. Ab ipsum ut amet neque repudiandae asperiores non incidunt, similique eveniet maxime natus perspiciatis quia aliquid excepturi cum iste praesentium, in vero sunt quis. Nemo quisquam consequuntur commodi amet, autem ipsam, at dicta aliquid, iste nulla totam quia minus illum modi beatae, perferendis quam ipsum. Sit maiores alias amet quod dolorem laboriosam, blanditiis facilis molestias voluptate nam libero quo facere. Amet aliquam maiores, quasi aspernatur tenetur asperiores voluptates a, perferendis quas ut dolore voluptatibus quod illum similique pariatur id! Mollitia doloremque maiores magni aliquam earum nihil neque adipisci cumque expedita quam deserunt odio impedit, esse repellendus iure ducimus, quos sequi, incidunt, similique cum velit asperiores. Asperiores laboriosam quidem fugiat odit saepe doloribus reprehenderit laborum consequuntur, cum. Perspiciatis et sapiente molestias explicabo repellat mollitia accusamus, enim deleniti illo vel eum ab soluta dolorem minus voluptatibus quisquam quis sed facere debitis adipisci, consequatur. Aspernatur quidem, fuga quis dolorem nesciunt sapiente quam, tempora tempore labore, in optio vel vero facere commodi rem. Blanditiis expedita iusto accusantium praesentium dolorem nesciunt beatae at earum sequi dolore facilis fugiat nihil odit tempora numquam est cupiditate doloribus pariatur illum aliquam cum, repudiandae veniam. Quibusdam rerum iure, id doloremque nihil ipsam soluta ex mollitia cum, illum sapiente debitis enim nobis ullam molestias natus sequi. Ad, doloribus, quas. Quis id, tempora eveniet sequi modi in exercitationem! Inventore, eaque vel ipsum nostrum vero dolore, temporibus ea ipsam iure. Cumque in error suscipit deleniti harum alias omnis maiores perferendis amet animi magni voluptates, inventore dolorem ducimus magnam, cum dolore repellendus doloremque maxime, tenetur dolores voluptate? Et qui necessitatibus est expedita nisi facere optio repudiandae impedit sunt sequi ipsa, praesentium obcaecati libero explicabo, eum, officia odio numquam animi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maiores, eum veritatis! Facilis, ipsum rem. Veritatis libero dolorem ex vitae ipsam doloribus blanditiis ratione aliquid. Totam fugiat enim porro ratione eos libero eum, deleniti beatae ut aspernatur, ipsam nisi, repellat rem nam fugit sunt iusto nemo tempora perspiciatis ullam magni? Numquam perspiciatis alias fugiat laudantium libero totam incidunt quidem eveniet similique error illum id, laboriosam delectus maiores officia exercitationem. Nobis ut explicabo id recusandae aspernatur deserunt nesciunt doloremque fuga quam pariatur hic, culpa consequatur quia rem quae saepe, alias ratione. Magni cumque nemo ipsam. Magni molestiae nam repellendus mollitia ea placeat, eos quam quidem cupiditate libero facilis perferendis, cum atque, repudiandae dolorum! Perferendis minus assumenda, sapiente quidem suscipit, cum reprehenderit ut esse ab facilis repudiandae cumque sunt illum cupiditate a consectetur incidunt, accusantium asperiores nulla repellat ratione quos rem! Reiciendis non sit pariatur voluptas officiis ipsum labore, alias incidunt optio architecto mollitia atque tempora, placeat! Ea saepe modi, ex. Eius praesentium saepe, officia itaque repellat labore dolore unde quo fuga tempore quam totam, nostrum quibusdam deleniti nam, quod odio velit nemo! Porro numquam deleniti, quae officia, doloribus assumenda facilis consequuntur iusto voluptatum quis odio dignissimos itaque fugit inventore ut dolor impedit veniam consequatur illo commodi repudiandae voluptate praesentium. Consequatur aliquam voluptates ullam quod officiis? Eum necessitatibus fuga, illo nisi, molestias laborum excepturi commodi nam facilis. Ab ipsum ut amet neque repudiandae asperiores non incidunt, similique eveniet maxime natus perspiciatis quia aliquid excepturi cum iste praesentium, in vero sunt quis. Nemo quisquam consequuntur commodi amet, autem ipsam, at dicta aliquid, iste nulla totam quia minus illum modi beatae, perferendis quam ipsum. Sit maiores alias amet quod dolorem laboriosam, blanditiis facilis molestias voluptate nam libero quo facere. Amet aliquam maiores, quasi aspernatur tenetur asperiores voluptates a, perferendis quas ut dolore voluptatibus quod illum similique pariatur id! Mollitia doloremque maiores magni aliquam earum nihil neque adipisci cumque expedita quam deserunt odio impedit, esse repellendus iure ducimus, quos sequi, incidunt, similique cum velit asperiores. Asperiores laboriosam quidem fugiat odit saepe doloribus reprehenderit laborum consequuntur, cum. Perspiciatis et sapiente molestias explicabo repellat mollitia accusamus, enim deleniti illo vel eum ab soluta dolorem minus voluptatibus quisquam quis sed facere debitis adipisci, consequatur. Aspernatur quidem, fuga quis dolorem nesciunt sapiente quam, tempora tempore labore, in optio vel vero facere commodi rem. Blanditiis expedita iusto accusantium praesentium dolorem nesciunt beatae at earum sequi dolore facilis fugiat nihil odit tempora numquam est cupiditate doloribus pariatur illum aliquam cum, repudiandae veniam. Quibusdam rerum iure, id doloremque nihil ipsam soluta ex mollitia cum, illum sapiente debitis enim nobis ullam molestias natus sequi. Ad, doloribus, quas. Quis id, tempora eveniet sequi modi in exercitationem! Inventore, eaque vel ipsum nostrum vero dolore, temporibus ea ipsam iure. Cumque in error suscipit deleniti harum alias omnis maiores perferendis amet animi magni voluptates, inventore dolorem ducimus magnam, cum dolore repellendus doloremque maxime, tenetur dolores voluptate? Et qui necessitatibus est expedita nisi facere optio repudiandae impedit sunt sequi ipsa, praesentium obcaecati libero explicabo, eum, officia odio numquam animi.",
      "image": "assets/img/sections/hollywood-sign.jpg",
      "image_caption": "The famous Hollywood Sign",
      "start_time": "15.45",
      "end_time": "16:00",
      "temperature": 24.50,
      "visibility": "public",
      "published_at_human_readable": "6 minutes ago",
      "locationable": {
        "id": 45,
        "owner": {          /// NOT FOR POI
          "first_name": "John",
          "middle_name": null,
          "last_name": "Doe",
          "username": "johndoe",
        },
        "is_draft": false,  /// NOT FOR POI
        "coordinates": {
          "coordinates": [12.547854, -45.587795],
        },
        "map_zoom": 8.0,
        "name": "Nice location",
        "info": "Just another nice location on the globe.",
        "visibility": "friends",                      /// NOT FOR POI
        "published_at_human_readable": "15 days ago", /// NOT FOR POI
      },
    },
    {
      "id": 5,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "is_draft": false,
      "content": "This is the fifth section",
      "image": "assets/img/sections/griffith.jpg",
      "image_caption": "Griffith Observatory",
      "start_time": "17:00",
      "end_time": "18:00",
      "temperature": 23.50,
      "visibility": "public",
      "published_at_human_readable": "3 minutes ago",
      "locationable": {
        "id": 45,
        "owner": {          /// NOT FOR POI
          "first_name": "John",
          "middle_name": null,
          "last_name": "Doe",
          "username": "johndoe",
        },
        "is_draft": false,  /// NOT FOR POI
        "coordinates": {
          "coordinates": [12.547854, -45.587795],
        },
        "map_zoom": 8.0,
        "name": "Nice location",
        "info": "Just another nice location on the globe.",
        "visibility": "friends",                      /// NOT FOR POI
        "published_at_human_readable": "15 days ago", /// NOT FOR POI
      },
    },
    {
      "id": 6,
      "owner": <String, dynamic>{
        "first_name": "John",
        "middle_name": null,
        "last_name": "Doe",
      },
      "is_draft": true,
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maiores, eum veritatis! Facilis, ipsum rem. Veritatis libero dolorem ex vitae ipsam doloribus blanditiis ratione aliquid. Totam fugiat enim porro ratione eos libero eum, deleniti beatae ut aspernatur, ipsam nisi, repellat rem nam fugit sunt iusto nemo tempora perspiciatis ullam magni? Numquam perspiciatis alias fugiat laudantium libero totam incidunt quidem eveniet similique error illum id, laboriosam delectus maiores officia exercitationem. Nobis ut explicabo id recusandae aspernatur deserunt nesciunt doloremque fuga quam pariatur hic, culpa consequatur quia rem quae saepe, alias ratione. Magni cumque nemo ipsam. Magni molestiae nam repellendus mollitia ea placeat, eos quam quidem cupiditate libero facilis perferendis, cum atque, repudiandae dolorum! Perferendis minus assumenda, sapiente quidem suscipit, cum reprehenderit ut esse ab facilis repudiandae cumque sunt illum cupiditate a consectetur incidunt, accusantium asperiores nulla repellat ratione quos rem! Reiciendis non sit pariatur voluptas officiis ipsum labore, alias incidunt optio architecto mollitia atque tempora, placeat! Ea saepe modi, ex. Eius praesentium saepe, officia itaque repellat labore dolore unde quo fuga tempore quam totam, nostrum quibusdam deleniti nam, quod odio velit nemo! Porro numquam deleniti, quae officia, doloribus assumenda facilis consequuntur iusto voluptatum quis odio dignissimos itaque fugit inventore ut dolor impedit veniam consequatur illo commodi repudiandae voluptate praesentium. Consequatur aliquam voluptates ullam quod officiis? Eum necessitatibus fuga, illo nisi, molestias laborum excepturi commodi nam facilis. Ab ipsum ut amet neque repudiandae asperiores non incidunt, similique eveniet maxime natus perspiciatis quia aliquid excepturi cum iste praesentium, in vero sunt quis. Nemo quisquam consequuntur commodi amet, autem ipsam, at dicta aliquid, iste nulla totam quia minus illum modi beatae, perferendis quam ipsum. Sit maiores alias amet quod dolorem laboriosam, blanditiis facilis molestias voluptate nam libero quo facere. Amet aliquam maiores, quasi aspernatur tenetur asperiores voluptates a, perferendis quas ut dolore voluptatibus quod illum similique pariatur id! Mollitia doloremque maiores magni aliquam earum nihil neque adipisci cumque expedita quam deserunt odio impedit, esse repellendus iure ducimus, quos sequi, incidunt, similique cum velit asperiores. Asperiores laboriosam quidem fugiat odit saepe doloribus reprehenderit laborum consequuntur, cum. Perspiciatis et sapiente molestias explicabo repellat mollitia accusamus, enim deleniti illo vel eum ab soluta dolorem minus voluptatibus quisquam quis sed facere debitis adipisci, consequatur. Aspernatur quidem, fuga quis dolorem nesciunt sapiente quam, tempora tempore labore, in optio vel vero facere commodi rem. Blanditiis expedita iusto accusantium praesentium dolorem nesciunt beatae at earum sequi dolore facilis fugiat nihil odit tempora numquam est cupiditate doloribus pariatur illum aliquam cum, repudiandae veniam. Quibusdam rerum iure, id doloremque nihil ipsam soluta ex mollitia cum, illum sapiente debitis enim nobis ullam molestias natus sequi. Ad, doloribus, quas. Quis id, tempora eveniet sequi modi in exercitationem! Inventore, eaque vel ipsum nostrum vero dolore, temporibus ea ipsam iure. Cumque in error suscipit deleniti harum alias omnis maiores perferendis amet animi magni voluptates, inventore dolorem ducimus magnam, cum dolore repellendus doloremque maxime, tenetur dolores voluptate? Et qui necessitatibus est expedita nisi facere optio repudiandae impedit sunt sequi ipsa, praesentium obcaecati libero explicabo, eum, officia odio numquam animi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maiores, eum veritatis! Facilis, ipsum rem. Veritatis libero dolorem ex vitae ipsam doloribus blanditiis ratione aliquid. Totam fugiat enim porro ratione eos libero eum, deleniti beatae ut aspernatur, ipsam nisi, repellat rem nam fugit sunt iusto nemo tempora perspiciatis ullam magni? Numquam perspiciatis alias fugiat laudantium libero totam incidunt quidem eveniet similique error illum id, laboriosam delectus maiores officia exercitationem. Nobis ut explicabo id recusandae aspernatur deserunt nesciunt doloremque fuga quam pariatur hic, culpa consequatur quia rem quae saepe, alias ratione. Magni cumque nemo ipsam. Magni molestiae nam repellendus mollitia ea placeat, eos quam quidem cupiditate libero facilis perferendis, cum atque, repudiandae dolorum! Perferendis minus assumenda, sapiente quidem suscipit, cum reprehenderit ut esse ab facilis repudiandae cumque sunt illum cupiditate a consectetur incidunt, accusantium asperiores nulla repellat ratione quos rem! Reiciendis non sit pariatur voluptas officiis ipsum labore, alias incidunt optio architecto mollitia atque tempora, placeat! Ea saepe modi, ex. Eius praesentium saepe, officia itaque repellat labore dolore unde quo fuga tempore quam totam, nostrum quibusdam deleniti nam, quod odio velit nemo! Porro numquam deleniti, quae officia, doloribus assumenda facilis consequuntur iusto voluptatum quis odio dignissimos itaque fugit inventore ut dolor impedit veniam consequatur illo commodi repudiandae voluptate praesentium. Consequatur aliquam voluptates ullam quod officiis? Eum necessitatibus fuga, illo nisi, molestias laborum excepturi commodi nam facilis. Ab ipsum ut amet neque repudiandae asperiores non incidunt, similique eveniet maxime natus perspiciatis quia aliquid excepturi cum iste praesentium, in vero sunt quis. Nemo quisquam consequuntur commodi amet, autem ipsam, at dicta aliquid, iste nulla totam quia minus illum modi beatae, perferendis quam ipsum. Sit maiores alias amet quod dolorem laboriosam, blanditiis facilis molestias voluptate nam libero quo facere. Amet aliquam maiores, quasi aspernatur tenetur asperiores voluptates a, perferendis quas ut dolore voluptatibus quod illum similique pariatur id! Mollitia doloremque maiores magni aliquam earum nihil neque adipisci cumque expedita quam deserunt odio impedit, esse repellendus iure ducimus, quos sequi, incidunt, similique cum velit asperiores. Asperiores laboriosam quidem fugiat odit saepe doloribus reprehenderit laborum consequuntur, cum. Perspiciatis et sapiente molestias explicabo repellat mollitia accusamus, enim deleniti illo vel eum ab soluta dolorem minus voluptatibus quisquam quis sed facere debitis adipisci, consequatur. Aspernatur quidem, fuga quis dolorem nesciunt sapiente quam, tempora tempore labore, in optio vel vero facere commodi rem. Blanditiis expedita iusto accusantium praesentium dolorem nesciunt beatae at earum sequi dolore facilis fugiat nihil odit tempora numquam est cupiditate doloribus pariatur illum aliquam cum, repudiandae veniam. Quibusdam rerum iure, id doloremque nihil ipsam soluta ex mollitia cum, illum sapiente debitis enim nobis ullam molestias natus sequi. Ad, doloribus, quas. Quis id, tempora eveniet sequi modi in exercitationem! Inventore, eaque vel ipsum nostrum vero dolore, temporibus ea ipsam iure. Cumque in error suscipit deleniti harum alias omnis maiores perferendis amet animi magni voluptates, inventore dolorem ducimus magnam, cum dolore repellendus doloremque maxime, tenetur dolores voluptate? Et qui necessitatibus est expedita nisi facere optio repudiandae impedit sunt sequi ipsa, praesentium obcaecati libero explicabo, eum, officia odio numquam animi. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maiores, eum veritatis! Facilis, ipsum rem. Veritatis libero dolorem ex vitae ipsam doloribus blanditiis ratione aliquid. Totam fugiat enim porro ratione eos libero eum, deleniti beatae ut aspernatur, ipsam nisi, repellat rem nam fugit sunt iusto nemo tempora perspiciatis ullam magni? Numquam perspiciatis alias fugiat laudantium libero totam incidunt quidem eveniet similique error illum id, laboriosam delectus maiores officia exercitationem. Nobis ut explicabo id recusandae aspernatur deserunt nesciunt doloremque fuga quam pariatur hic, culpa consequatur quia rem quae saepe, alias ratione. Magni cumque nemo ipsam. Magni molestiae nam repellendus mollitia ea placeat, eos quam quidem cupiditate libero facilis perferendis, cum atque, repudiandae dolorum! Perferendis minus assumenda, sapiente quidem suscipit, cum reprehenderit ut esse ab facilis repudiandae cumque sunt illum cupiditate a consectetur incidunt, accusantium asperiores nulla repellat ratione quos rem! Reiciendis non sit pariatur voluptas officiis ipsum labore, alias incidunt optio architecto mollitia atque tempora, placeat! Ea saepe modi, ex. Eius praesentium saepe, officia itaque repellat labore dolore unde quo fuga tempore quam totam, nostrum quibusdam deleniti nam, quod odio velit nemo! Porro numquam deleniti, quae officia, doloribus assumenda facilis consequuntur iusto voluptatum quis odio dignissimos itaque fugit inventore ut dolor impedit veniam consequatur illo commodi repudiandae voluptate praesentium. Consequatur aliquam voluptates ullam quod officiis? Eum necessitatibus fuga, illo nisi, molestias laborum excepturi commodi nam facilis. Ab ipsum ut amet neque repudiandae asperiores non incidunt, similique eveniet maxime natus perspiciatis quia aliquid excepturi cum iste praesentium, in vero sunt quis. Nemo quisquam consequuntur commodi amet, autem ipsam, at dicta aliquid, iste nulla totam quia minus illum modi beatae, perferendis quam ipsum. Sit maiores alias amet quod dolorem laboriosam, blanditiis facilis molestias voluptate nam libero quo facere. Amet aliquam maiores, quasi aspernatur tenetur asperiores voluptates a, perferendis quas ut dolore voluptatibus quod illum similique pariatur id! Mollitia doloremque maiores magni aliquam earum nihil neque adipisci cumque expedita quam deserunt odio impedit, esse repellendus iure ducimus, quos sequi, incidunt, similique cum velit asperiores. Asperiores laboriosam quidem fugiat odit saepe doloribus reprehenderit laborum consequuntur, cum. Perspiciatis et sapiente molestias explicabo repellat mollitia accusamus, enim deleniti illo vel eum ab soluta dolorem minus voluptatibus quisquam quis sed facere debitis adipisci, consequatur. Aspernatur quidem, fuga quis dolorem nesciunt sapiente quam, tempora tempore labore, in optio vel vero facere commodi rem. Blanditiis expedita iusto accusantium praesentium dolorem nesciunt beatae at earum sequi dolore facilis fugiat nihil odit tempora numquam est cupiditate doloribus pariatur illum aliquam cum, repudiandae veniam. Quibusdam rerum iure, id doloremque nihil ipsam soluta ex mollitia cum, illum sapiente debitis enim nobis ullam molestias natus sequi. Ad, doloribus, quas. Quis id, tempora eveniet sequi modi in exercitationem! Inventore, eaque vel ipsum nostrum vero dolore, temporibus ea ipsam iure. Cumque in error suscipit deleniti harum alias omnis maiores perferendis amet animi magni voluptates, inventore dolorem ducimus magnam, cum dolore repellendus doloremque maxime, tenetur dolores voluptate? Et qui necessitatibus est expedita nisi facere optio repudiandae impedit sunt sequi ipsa, praesentium obcaecati libero explicabo, eum, officia odio numquam animi.",
      "image": "assets/img/sections/yorba-linda.png",
      "image_caption": "Yorba Linda",
      "start_time": "18:30",
      "end_time": "20:00",
      "temperature": 26.00,
      "visibility": "public",
      "published_at_human_readable": "12 seconds ago",
      "locationable": {
        "id": 45,
        "coordinates": {
          "coordinates": [34.052235, -118.243683],
        },
        "map_zoom": 10.0,
        "name": "Nice location",
        "info": "Just another nice location on the globe. This is the first location of the trip, it describes the first day, including complete journey and arrival (The day of travel is one before the day of arrival but we regard it as one, because we didn't sleep and thus percieved it as one day). A quick summary of the day is: We first took the flight from DUS to AMS and waited for a very long time in AMS. There where plenty of things to do in the transit area. The second flight was way too long. Border was fine in LA. Devin picked us up at LAX, we got donuts, drove through LA, saw hollywood signs in the distance, went closer, went to griffith observatory and finally at the end of the day to Yorba Linda, our settlement for the next few days. Just another nice location on the globe. This is the first location of the trip, it describes the first day, including complete journey and arrival (The day of travel is one before the day of arrival but we regard it as one, because we didn't sleep and thus percieved it as one day). A quick summary of the day is: We first took the flight from DUS to AMS and waited for a very long time in AMS. There where plenty of things to do in the transit area. The second flight was way too long. Border was fine in LA. Devin picked us up at LAX, we got donuts, drove through LA, saw hollywood signs in the distance, went closer, went to griffith observatory and finally at the end of the day to Yorba Linda, our settlement for the next few days.",
        "image": "assets/img/sections/plane.jpg",
      },
    },
  ];
}
