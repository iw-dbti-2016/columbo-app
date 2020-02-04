import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  static Serializer<User> get serializer => _$userSerializer;

  int get id;

  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @BuiltValueField(wireName: 'middle_name')
  @nullable
  String get middleName;

  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  factory User([void Function(UserBuilder) updates]) = _$User;
  User._();
}