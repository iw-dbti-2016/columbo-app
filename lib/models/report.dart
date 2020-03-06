import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'report.g.dart';

abstract class Report implements Built<Report, ReportBuilder> {
  static Serializer<Report> get serializer => _$reportSerializer;

  int get id;

  String get title;

  @nullable
  String get date;

  @nullable
  String get description;

  factory Report([void Function(ReportBuilder) updates]) = _$Report;
  Report._();
}