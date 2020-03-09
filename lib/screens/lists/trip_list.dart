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
          for (Trip trip in trips)
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      trip.name,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    key: Key(trip.id.toString()),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: SizedBox(
                                    height: 10,
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.grey[200],
                                      valueColor: AlwaysStoppedAnimation(
                                          Colors.green[600]),
                                      value: (trip.startDateObj
                                              .difference(DateTime.now())
                                              .inDays) /
                                          (trip.startDateObj
                                              .difference(trip.endDateObj)
                                              .inDays),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      trip.startDate,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      trip.endDate,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            trip.description,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.justify,
                            maxLines: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.star_border),
                                  iconSize: 30,
                                  onPressed: () {},
                                ),
                                OutlineButton(
                                  onPressed: () {},
                                  child: const Text('Read More'),
                                ),
                                IconButton(
                                  icon: Icon(Icons.bookmark_border),
                                  iconSize: 30,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
        ],
      );
    }
  }
}
