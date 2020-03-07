import 'package:Columbo/models/location.dart';
import 'package:flutter/material.dart';

class LocationList extends StatefulWidget {
  const LocationList(this.locations, {Key key}) : super(key: key);

  final dynamic locations;

  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    if (widget.locations == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          for (Location item in widget.locations)
            Column(
              children: [
                ListTile(
                  title: Text(item.name),
                  contentPadding: const EdgeInsets.all(5.0),
                  key: Key(item.id.toString()),
                  leading: const Icon(Icons.location_on),
                  subtitle: Column(
                    children: <Widget>[
                      Text(item.coordinates.toString()),
                      Text(item.mapZoom.toString()),
                      Text(item.info),
                      Text(item.publishedAt),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
        ],
      );
    }
  }
}
