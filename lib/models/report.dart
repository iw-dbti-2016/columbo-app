import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:intl/intl.dart';

part 'report.g.dart';

abstract class Report implements Built<Report, ReportBuilder> {
  static Serializer<Report> get serializer => _$reportSerializer;

  int get id;

  String get title;

  @nullable
  String get date;

  @nullable
  String get description;

  @BuiltValueField(wireName: "published_at")
  DateTime get publishedAtObj;

  @memoized
  String get publishedAt =>
      DateFormat('dd/MM/y HH:mm:ss').format(publishedAtObj);

  factory Report([void Function(ReportBuilder) updates]) = _$Report;

  Report._();
}
