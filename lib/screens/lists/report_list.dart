import 'package:TravelCompanion/models/report.dart';
import 'package:flutter/material.dart';

class ReportList extends StatefulWidget {
  const ReportList(this.reports, {Key key}) : super(key: key);

  final dynamic reports;

  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        for (Report item in widget.reports)
          Column(
            children: [
              ListTile(
                title: Text(item.title),
                contentPadding: const EdgeInsets.all(5.0),
                key: Key(item.id.toString()),
                leading: const Icon(Icons.folder),
                subtitle: Column(
                  children: <Widget>[
                    Text(item.description),
                    Text(item.date),
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
