import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment.g.dart';

abstract class Payment implements Built<Payment, PaymentBuilder> {
  static Serializer<Payment> get serializer => _$paymentSerializer;

  int get id;

  String get uuid;

  @nullable
  String get name;

  String get benificiary;

  String get date;

  @nullable
  String get comments;

  @BuiltValueField(wireName: 'total_amount')
  int get totalAmount;

  @BuiltValueField(wireName: 'tax_percentage')
  double get taxPercentage;

  @BuiltValueField(wireName: 'tip_amount')
  int get tipAmount;

  factory Payment([void Function(PaymentBuilder) updates]) = _$Payment;
  Payment._();
}