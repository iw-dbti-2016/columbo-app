import 'package:flutter/material.dart';

import 'package:Columbo/models/report.dart';
import 'package:Columbo/widgets/columbo_scaffold.dart';
import 'package:Columbo/services/network.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key key}) : super(key: key);

  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  dynamic reports;

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
    return getResourceList('reports', Report.serializer)
        .then((listData) => setState(() {
              reports = listData;
            }));
  }

  Widget _buildList() {
    if (reports == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          for (Report item in reports)
            Column(
              children: [
                ListTile(
                  title: Text(item.title),
                  contentPadding: const EdgeInsets.all(5.0),
                  key: Key(item.id.toString()),
                  leading: const Icon(Icons.folder_open),
                  subtitle: Column(
                    children: <Widget>[
                      Text(item.description),
                      Text(item.date),
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
