library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/serializer.dart';
import 'currency.dart';
import 'location.dart';
import 'payment.dart';
import 'plan.dart';
import 'poi.dart';
import 'report.dart';
import 'section.dart';
import 'trip.dart';
import 'user.dart';

part 'serializers.g.dart';

@SerializersFor([
  Trip,
  Report,
  User,
  Section,
  Location,
  Poi,
  Plan,
  Currency,
  Payment,
])
Serializers serializers = _$serializers;

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();