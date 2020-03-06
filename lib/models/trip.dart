import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'trip.g.dart';

abstract class Trip implements Built<Trip, TripBuilder> {
  static Serializer<Trip> get serializer => _$tripSerializer;

  int get id;

  String get name;

  @nullable
  String get synopsis;

  @nullable
  String get description;

  @BuiltValueField(wireName: "start_date")
  String get startDate;

  @BuiltValueField(wireName: "end_date")
  String get endDate;

  @BuiltValueField(wireName: "published_at")
  String get publishedAt;

  factory Trip([void Function(TripBuilder) updates]) = _$Trip;
  Trip._();
}