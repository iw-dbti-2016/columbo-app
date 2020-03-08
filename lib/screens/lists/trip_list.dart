import 'package:flutter/material.dart';

import 'package:Columbo/models/trip.dart';
import 'package:Columbo/widgets/columbo_scaffold.dart';
import 'package:Columbo/services/network.dart';

class TripList extends StatefulWidget {
  const TripList({Key key}) : super(key: key);

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  dynamic trips;

  @override
  void initState() {
    super.initState();

    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return ColumboScaffold(
      child: Center(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refreshList,
          child: _buildList(),
        ),
      ),
    );
  }

  Future<void> _refreshList() async {
    return getResourceList('trips', Trip.serializer)
        .then((listData) => setState(() {
              trips = listData;
            }));
  }

  Widget _buildList() {
    if (trips == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          for (Trip item in trips)
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
