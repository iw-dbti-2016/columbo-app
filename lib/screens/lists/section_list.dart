import 'package:Columbo/widgets/sections/image_map.dart';
import 'package:Columbo/widgets/sections/location_temperature.dart';
import 'package:Columbo/widgets/sections/publish_info.dart';
import 'package:Columbo/widgets/sections/section_content.dart';
import 'package:Columbo/widgets/sections/time_header.dart';
import 'package:flutter/material.dart';

import 'package:Columbo/models/section.dart';
import 'package:Columbo/widgets/columbo_scaffold.dart';
import 'package:Columbo/services/network.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SectionList extends StatefulWidget {
  const SectionList({Key key}) : super(key: key);

  @override
  _SectionListState createState() => _SectionListState();
}

class _SectionListState extends State<SectionList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  dynamic sections;
  final PageController _pageController = PageController();

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
          child: Column(
            children: <Widget>[
              // PLANNING EXPANDABLE,
              Placeholder(
                color: Colors.grey[300],
                fallbackHeight: 50,
                strokeWidth: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 12, bottom: 5, left: 5, right: 5),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: sections.length as int,
                  effect: ScrollingDotsEffect(
                    activeDotColor: Colors.green[600],
                    dotColor: Colors.grey[300],
                    dotHeight: 10,
                    dotWidth: 10,
                    fixedCenter: true,
                    activeDotScale: 1.1,
                    maxVisibleDots: 19,
                    strokeWidth: 2,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Divider(
                  height: 1,
                ),
              ),
              Flexible(child: _buildList()),
            ],
          ),
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
      return PageView.builder(
        controller: _pageController,
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildListItem(sections[index] as Section);
        },
        itemCount: sections.length as int,
      );
    }
  }

  Widget _buildListItem(Section section) {
    return Column(
      children: <Widget>[
        Material(
          elevation: 3,
          child: Column(
            children: <Widget>[
              // TIME (start-end)
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, left: 20, right: 20, bottom: 10),
                child: TimeHeader(section),
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView(
            children: <Widget>[
              // IMAGE/MAP
              ImageAndMap(section),
              // LOCATION + TEMPERATURE
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: LocationTemperature(section),
              ),
              // PARSED CONTENT
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: SectionContent(section),
              ),
              // NAME + PUBLISHED AT HUMAN READABLE
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 15, bottom: 20),
                child: PublishInfo(section),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
