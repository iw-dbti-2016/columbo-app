import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'plan.g.dart';

abstract class Plan implements Built<Plan, PlanBuilder> {
  static Serializer<Plan> get serializer => _$planSerializer;

  int get id;

  String get date;

  String get program;

  @nullable
  @BuiltValueField(wireName: 'driving_distance_km')
  double get drivingDistance;

  @BuiltValueField(wireName: 'wifi_available')
  bool get wifiAvailable;

  @nullable
  @BuiltValueField(wireName: 'sleeping_location')
  String get sleepingLocation;

  @nullable
  @BuiltValueField(wireName: 'estimated_price')
  int get estimatedPrice;

  @nullable
  @BuiltValueField(wireName: 'status_sleep')
  String get sleepStatus;

  @nullable
  @BuiltValueField(wireName: 'status_activities')
  String get activityStatus;

  factory Plan([void Function(PlanBuilder) updates]) = _$Plan;
  Plan._();
}