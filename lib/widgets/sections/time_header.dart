import 'package:Columbo/models/section.dart';
import 'package:flutter/material.dart';

class TimeHeader extends StatelessWidget {
  final Section section;

  const TimeHeader(this.section);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'start',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'end',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              section.startTime,
              style: Theme.of(context).textTheme.headline1,
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
            Text(
              section.endTime,
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ],
    );
  }
}
