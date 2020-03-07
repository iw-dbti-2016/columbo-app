import 'package:Columbo/models/section.dart';
import 'package:flutter/material.dart';

class SectionList extends StatefulWidget {
  const SectionList(this.sections, {Key key}) : super(key: key);

  final dynamic sections;

  @override
  _SectionListState createState() => _SectionListState();
}

class _SectionListState extends State<SectionList> {
  @override
  Widget build(BuildContext context) {
    if (widget.sections == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          for (Section item in widget.sections)
            Column(
              children: [
                ListTile(
                  title: Text("${item.startTime} - ${item.endTime}"),
                  contentPadding: const EdgeInsets.all(5.0),
                  key: Key(item.id.toString()),
                  leading: const Icon(Icons.format_align_left),
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
