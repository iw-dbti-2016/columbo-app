import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Location extends StatefulWidget {
  final Map<String, dynamic> _location;

  const Location(this._location);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  bool _isPOI;
  int _sliverIndex = 0;

  @override
  void initState() {
    _isPOI = widget._location.containsKey("image");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          flexibleSpace: Stack(
            children: <Widget>[
              Positioned.fill(
                child: (_sliverIndex == 0 || !_isPOI)
                    ? FlutterMap(
                        options: MapOptions(
                          center: LatLng(
                            double.parse(widget._location["coordinates"]
                                    ["coordinates"][0]
                                .toString()),
                            double.parse(widget._location["coordinates"]
                                    ["coordinates"][1]
                                .toString()),
                          ),
                          zoom: double.parse(
                              widget._location["map_zoom"].toString()),
                        ),
                        layers: [
                          TileLayerOptions(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                            // For example purposes. It is recommended to use
                            // TileProvider with a caching and retry strategy, like
                            // NetworkTileProvider or CachedNetworkTileProvider
                            tileProvider: NonCachingNetworkTileProvider(),
                          ),
                          MarkerLayerOptions(
                            markers: [
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: LatLng(
                                  double.parse(widget._location["coordinates"]
                                          ["coordinates"][0]
                                      .toString()),
                                  double.parse(widget._location["coordinates"]
                                          ["coordinates"][1]
                                      .toString()),
                                ),
                                builder: (ctx) => Icon(
                                  Icons.place,
                                  size: 40.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Image.asset(
                        widget._location["image"].toString(),
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
              if (_isPOI)
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _sliverIndex = 0;
                          });
                        },
                        child: Opacity(
                          opacity: (_sliverIndex == 0) ? 1.0 : 0.4,
                          child: Chip(
                            label: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.place,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text("Map"),
                                ),
                              ],
                            ),
                            labelStyle: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _sliverIndex = 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Opacity(
                            opacity: (_sliverIndex == 1) ? 1.0 : 0.4,
                            child: Chip(
                              label: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text("Image"),
                                  ),
                                ],
                              ),
                              labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
              },
              child: Icon(Icons.arrow_back)),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 14.0, 18.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget._location["name"].toString(),
                      style: const TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    if (!_isPOI && (widget._location["is_draft"] as bool))
                      Chip(
                        label: Text(
                          "DRAFT",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.red,
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 12.0,
                ),
                child: Text(
                  widget._location["info"].toString(),
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              if (!_isPOI)
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "by ${widget._location["owner"]["first_name"]} ${widget._location["owner"]["last_name"]}",
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        widget._location["published_at_human_readable"]
                            .toString(),
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
