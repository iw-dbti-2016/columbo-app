import 'package:Columbo/models/section.dart';
import 'package:Columbo/widgets/markdown.dart';
import 'package:flutter/material.dart';

class SectionContent extends StatelessWidget {
  final Section section;

  const SectionContent(this.section);

  @override
  Widget build(BuildContext context) {
    return MarkDownText(
      section.content,
      key: Key('section-${section.id}'),
    );
  }
}
