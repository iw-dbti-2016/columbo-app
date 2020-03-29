import 'package:Columbo/models/plan.dart';
import 'package:Columbo/models/section.dart';
import 'package:Columbo/models/trip.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:intl/intl.dart';

part 'report.g.dart';

abstract class Report implements Built<Report, ReportBuilder> {
  static Serializer<Report> get serializer => _$reportSerializer;

  int get id;

  String get title;

  @nullable
  @BuiltValueField(wireName: 'date')
  DateTime get dateObj;

  @nullable
  @memoized
  String get date => DateFormat('dd/MM/y').format(dateObj);

  @nullable
  String get description;

  @BuiltValueField(wireName: "published_at")
  DateTime get publishedAtObj;

  @memoized
  String get publishedAt =>
      DateFormat('dd/MM/y HH:mm:ss').format(publishedAtObj);

  @nullable
  Trip get trip;

  @nullable
  BuiltList<Section> get sections;

  @nullable
  Plan get plan;

  factory Report([void Function(ReportBuilder) updates]) = _$Report;

  Report._();
}
