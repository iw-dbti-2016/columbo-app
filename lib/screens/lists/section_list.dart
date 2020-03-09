import 'package:flutter/material.dart';

import 'package:Columbo/models/section.dart';
import 'package:Columbo/widgets/columbo_scaffold.dart';
import 'package:Columbo/services/network.dart';

class SectionList extends StatefulWidget {
  const SectionList({Key key}) : super(key: key);

  @override
  _SectionListState createState() => _SectionListState();
}

class _SectionListState extends State<SectionList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  dynamic sections;

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
    return getResourceList('sections', Section.serializer)
        .then((listData) => setState(() {
              sections = listData;
            }));
  }

  Widget _buildList() {
    if (sections == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          for (Section item in sections)
            Column(
              children: [
                ListTile(
                  title: Text("${item.startTime} - ${item.endTime}"),
                  contentPadding: const EdgeInsets.all(5.0),
                  key: Key(item.id.toString()),
                  subtitle: Column(
                    children: <Widget>[
                      Text(item.content),
                      Text(item.imageCaption),
                      Text(item.temperature.toString()),
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
