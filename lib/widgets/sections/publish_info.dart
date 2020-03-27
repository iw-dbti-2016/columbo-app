import 'package:Columbo/models/section.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as human_time;

class PublishInfo extends StatelessWidget {
  final Section section;

  const PublishInfo(this.section);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.account_circle,
              color: Colors.grey[400],
              size: 18,
            ),
            Text(
              ' @vikvanderlinden',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        Text(
          human_time.format(section.publishedAtObj),
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
