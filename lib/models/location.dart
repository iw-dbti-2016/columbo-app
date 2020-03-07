import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'location.g.dart';

abstract class Location implements Built<Location, LocationBuilder> {
  static Serializer<Location> get serializer => _$locationSerializer;

  int get id;

  @BuiltValueField(wireName: 'is_draft')
  bool get isDraft;

  BuiltList<double> get coordinates;

  @BuiltValueField(wireName: 'map_zoom')
  double get mapZoom;

  @nullable
  String get name;

  @nullable
  String get info;

  @BuiltValueField(wireName: 'published_at')
  String get publishedAt;

  factory Location([void Function(LocationBuilder) updates]) = _$Location;
  Location._();
}