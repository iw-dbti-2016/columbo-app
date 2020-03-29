import 'package:Columbo/models/locationable.dart';
import 'package:Columbo/models/report.dart';
import 'package:Columbo/models/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:intl/intl.dart';

part 'section.g.dart';

abstract class Section implements Built<Section, SectionBuilder> {
  static Serializer<Section> get serializer => _$sectionSerializer;

  int get id;

  @BuiltValueField(wireName: 'is_draft')
  bool get isDraft;

  @nullable
  String get content;

  @nullable
  String get image;

  @nullable
  @BuiltValueField(wireName: 'image_caption')
  String get imageCaption;

  @nullable
  @BuiltValueField(wireName: 'start_time')
  String get startTime;

  @nullable
  @BuiltValueField(wireName: 'end_time')
  String get endTime;

  @nullable
  int get temperature;

  @BuiltValueField(wireName: 'published_at')
  DateTime get publishedAtObj;

  @memoized
  String get publishedAt =>
      DateFormat('dd/MM/y HH:mm:ss').format(publishedAtObj);

  @nullable
  Report get report;

  @nullable
  User get owner;

  @nullable
  Locationable get locationable;

  factory Section([void Function(SectionBuilder) updates]) = _$Section;

  Section._();
}
