import 'package:Columbo/models/trip.dart';
import 'package:flutter/material.dart';

class TripList extends StatefulWidget {
  const TripList(this.trips, {Key key}) : super(key: key);

  final dynamic trips;

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  @override
  Widget build(BuildContext context) {
    if (widget.trips == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          for (Trip item in widget.trips)
            Column(
              children: [
                ListTile(
                  title: Text(item.name),
                  contentPadding: const EdgeInsets.all(5.0),
                  key: Key(item.id.toString()),
                  leading: const Icon(Icons.directions_car),
                  subtitle: Column(
                    children: <Widget>[
                      Text(item.description),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(item.startDate),
                          Text(item.endDate),
                        ],
                      ),
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
