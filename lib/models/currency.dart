import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'currency.g.dart';

abstract class Currency implements Built<Currency, CurrencyBuilder> {
  static Serializer<Currency> get serializer => _$currencySerializer;

  String get id;

  String get name;

  String get symbol;

  int get decimals;

  @BuiltValueField(wireName: 'decimal_spacer')
  String get decimalSpacer;

  @BuiltValueField(wireName: 'thousand_spacer')
  String get thousandSpacer;

  factory Currency([void Function(CurrencyBuilder) updates]) = _$Currency;
  Currency._();
}