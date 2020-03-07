import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'poi.g.dart';

abstract class Poi implements Built<Poi, PoiBuilder> {
  static Serializer<Poi> get serializer => _$poiSerializer;

  int get id;

  BuiltList<double> get coordinates;

  @BuiltValueField(wireName: 'map_zoom')
  double get mapZoom;

  String get name;

  @nullable
  String get info;

  @nullable
  String get image;

  factory Poi([void Function(PoiBuilder) updates]) = _$Poi;
  Poi._();
}