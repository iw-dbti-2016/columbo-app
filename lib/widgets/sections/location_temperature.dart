import 'package:Columbo/models/section.dart';
import 'package:flutter/material.dart';

class LocationTemperature extends StatelessWidget {
  final Section section;

  const LocationTemperature(this.section);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: 26,
            ),
            Text(
              ' Location a',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
//        Text(
//          '24/03/2020',
//          style: Theme.of(context).textTheme.headline2,
//        ),
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
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ],
    );
  }
}
