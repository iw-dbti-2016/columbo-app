import 'package:flutter/material.dart';

import 'package:Columbo/models/poi.dart';
import 'package:Columbo/widgets/columbo_scaffold.dart';
import 'package:Columbo/services/network.dart';

class PoiList extends StatefulWidget {
  const PoiList({Key key}) : super(key: key);

  @override
  _PoiListState createState() => _PoiListState();
}

class _PoiListState extends State<PoiList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  dynamic pois;

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
    return getResourceList('pois', Poi.serializer)
        .then((listData) => setState(() {
              pois = listData;
            }));
  }

  Widget _buildList() {
    if (pois == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          for (Poi item in pois)
            Column(
              children: [
                ListTile(
                  title: Text(item.name),
                  contentPadding: const EdgeInsets.all(5.0),
                  key: Key(item.id.toString()),
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
