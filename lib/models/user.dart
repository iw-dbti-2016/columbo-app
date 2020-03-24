import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:intl/intl.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  static Serializer<User> get serializer => _$userSerializer;

  int get id;

  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @nullable
  @BuiltValueField(wireName: 'middle_name')
  String get middleName;

  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  String get username;

  String get email;

  @nullable
  String get telephone;

  @nullable
  String get image;

  @nullable
  @BuiltValueField(wireName: 'birth_date')
  DateTime get birthDateObj;

  @nullable
  @memoized
  String get birthDate =>
      birthDateObj == null ? null : DateFormat('dd/MM/y').format(birthDateObj);

  @nullable
  String get description;

  @nullable
  String get language;

  @nullable
  String get token;

  @nullable
  @BuiltValueField(wireName: 'email_verified_at')
  DateTime get emailVerifiedAtObj;

  @nullable
  @memoized
  String get emailVerifiedAt => emailVerifiedAtObj == null
      ? null
      : DateFormat('dd/MM/y').format(emailVerifiedAtObj);

  factory User([void Function(UserBuilder) updates]) = _$User;

  User._();
}
