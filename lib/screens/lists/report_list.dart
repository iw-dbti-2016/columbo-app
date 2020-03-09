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
          for (Report report in reports)
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      report.date,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    key: Key(report.id.toString()),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            report.title,
                            style: Theme.of(context).textTheme.headline2,
                            textAlign: TextAlign.justify,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Text(
                              report.description,
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.justify,
                              maxLines: 5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                OutlineButton(
                                  onPressed: () {},
                                  child: const Text('Read More'),
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
