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
  DateTime get startTimeObj;

  @nullable
  @memoized
  String get startTime => DateFormat('dd/MM/y').format(startTimeObj);

  @nullable
  @BuiltValueField(wireName: 'end_time')
  DateTime get endTimeObj;

  @nullable
  @memoized
  String get endTime => DateFormat('dd/MM/y').format(endTimeObj);

  @nullable
  int get temperature;

  @BuiltValueField(wireName: 'published_at')
  DateTime get publishedAtObj;

  @memoized
  String get publishedAt =>
      DateFormat('dd/MM/y HH:mm:ss').format(publishedAtObj);

  factory Section([void Function(SectionBuilder) updates]) = _$Section;

  Section._();
}
