import 'package:Columbo/widgets/markdown.dart';
import 'package:flutter/material.dart';

import 'package:Columbo/models/section.dart';
import 'package:Columbo/widgets/columbo_scaffold.dart';
import 'package:Columbo/services/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          for (Section section in sections)
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "${section.startTime} - ${section.endTime}",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    key: Key(section.id.toString()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.wb_sunny,
                                    size: 25,
                                    color: Colors.yellow[900],
                                  ),
                                  Text(
                                    ' ${section.temperature}°C',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ],
                              ),
                              if (section.isDraft)
                                Chip(
                                  label: const Text('Draft'),
                                  padding: const EdgeInsets.all(6),
                                  backgroundColor: Colors.green[600],
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        MarkDownText(
                          section.content,
                          key: Key('section-${section.id}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            'published at ${section.publishedAt}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                  const Divider(),
                ],
              ),
            ),
        ],
      );
    }
  }
}
