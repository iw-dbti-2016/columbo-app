import 'package:Columbo/models/section.dart';
import 'package:flutter/material.dart';

class ImageAndMap extends StatefulWidget {
  final Section section;

  const ImageAndMap(this.section);

  @override
  _ImageAndMapState createState() => _ImageAndMapState();
}

class _ImageAndMapState extends State<ImageAndMap> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Placeholder(
        color: Colors.grey[300],
        strokeWidth: 1,
      ),
    );
  }
}
