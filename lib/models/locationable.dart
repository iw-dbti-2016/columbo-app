import 'package:Columbo/models/location.dart';
import 'package:Columbo/models/poi.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'locationable.g.dart';

abstract class Locationable implements Built<Locationable, LocationableBuilder> {
  static Serializer<Locationable> get serializer => _$locationableSerializer;

  @nullable
  Location get location;

  @nullable
  Poi get poi;

  factory Locationable([void Function(LocationableBuilder) updates]) = _$Locationable;
  Locationable._();
}