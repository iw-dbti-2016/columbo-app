import 'package:Columbo/models/poi.dart';
import 'package:flutter/material.dart';

class PoiList extends StatefulWidget {
  const PoiList(this.pois, {Key key}) : super(key: key);

  final dynamic pois;

  @override
  _PoiListState createState() => _PoiListState();
}

class _PoiListState extends State<PoiList> {
  @override
  Widget build(BuildContext context) {
    if (widget.pois == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          for (Poi item in widget.pois)
            Column(
              children: [
                ListTile(
                  title: Text(item.name),
                  contentPadding: const EdgeInsets.all(5.0),
                  key: Key(item.id.toString()),
                  leading: const Icon(Icons.star_border),
                  subtitle: Column(
                    children: <Widget>[
                      Text(item.coordinates.toString()),
                      Text(item.mapZoom.toString()),
                      Text(item.info),
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