import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:intl/intl.dart';

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
  DateTime get startDateObj;

  @memoized
  String get startDate => DateFormat('dd/MM/y').format(startDateObj);

  @BuiltValueField(wireName: "end_date")
  DateTime get endDateObj;

  @memoized
  String get endDate => DateFormat('dd/MM/y').format(endDateObj);

  @BuiltValueField(wireName: "published_at")
  DateTime get publishedAtObj;

  @memoized
  String get publishedAt =>
      DateFormat('dd/MM/y HH:mm:ss').format(publishedAtObj);

  factory Trip([void Function(TripBuilder) updates]) = _$Trip;

  Trip._();
}
