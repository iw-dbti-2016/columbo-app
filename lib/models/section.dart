import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

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
  String get publishedAt;

  factory Section([void Function(SectionBuilder) updates]) = _$Section;
  Section._();
}