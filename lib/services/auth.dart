import 'dart:async';
import 'dart:convert';

import 'package:Columbo/models/serializers.dart';
import 'package:Columbo/models/user.dart';
import 'package:Columbo/services/auth_service.dart';
import 'package:Columbo/services/device_info.dart';
import 'package:Columbo/services/network.dart';
import 'package:Columbo/services/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Auth with Network, ChangeNotifier implements AuthService {
  static const String tokenStorageKey = "user_auth_token";
  static const String tokenType = "Bearer";
  static const deviceInfo = DeviceInfo();

  String _deviceName;
  User _user;
  String _token;
  bool _loading = false;
  final StreamController<User> _onAuthStateChangedController =
      StreamController<User>();

  Auth() {
    deviceInfo.getDeviceName().then((value) {
      _deviceName = value;
    }).then((_) => _initUser());
  }

  bool get loading => _loading;

  bool get authenticated => _user != null;

  User get user => _user;

  @override
  Stream<User> get onAuthStateChanged => _onAuthStateChangedController.stream;

  Future<void> _initUser() async {
    try {
      final String token = await retrieveToken();

      if (token == null) {
        _onAuthStateChangedController.add(null);
      }

      await retrieveUser();
    } catch (e) {
      print(e);
    }

    _onAuthStateChangedController.add(_user);
    notifyListeners();
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email,
      String password,
      String pwConfirm,
      String username,
      String firstName,
      String lastName) async {
    _startLoading();

    final Response response = await this.post('/auth/register',
        body: json.encode({
          "email": email,
          "username": username,
          "first_name": firstName,
          "last_name": lastName,
          "password": password,
          "password_confirmation": pwConfirm,
          "device_name": _deviceName,
        }));

    if (response.statusCode != 201) {
      _stopLoading();
      throw Exception(response.body);
    }

    return _storeUser(_userFromResponse(response.body));
  }

  @override
  Future<User> currentUser() async {
    if (_user != null) {
      return _user;
    }

    return retrieveUser();
  }

  Future<User> retrieveUser({bool forceReload = false}) async {
    if (_user != null && !forceReload) {
      return _user;
    }

    if (await retrieveToken() == null) {
      return null;
    }

    final Response response = await this.get('/user');

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return _storeUser(_userFromResponse(response.body));
  }

  @override
  Future<String> retrieveToken() async {
    if (_token != null) {
      return _token;
    }

    final storageToken = await secureStorage.read(key: tokenStorageKey);

    if (storageToken == null) {
      return null;
    }

    return _token = storageToken;
  }

  @override
  Future<bool> refreshToken() async {
    _startLoading();
    final Response response = await this.patch('/auth/refresh', body: '''{
          "device_name": "$_deviceName"
        }''');

    if (response.statusCode != 200) {
      _stopLoading();
      throw Exception(response.body);
      return false;
    }

    _storeUser(_userFromResponse(response.body));
    return true;
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    _startLoading();
    final Response response = await this.post('/auth/password/email', body: '''{
        "email": "$email"
      }''');

    _stopLoading();

    if (response.statusCode != 200) {
      throw Exception(response.body);
      return false;
    }

    return true;
  }

  @override
  Future<bool> resendEmailVerification() async {
    _startLoading();
    final Response response = await this.post('/auth/email/resend');

    _stopLoading();

    if (response.statusCode != 200) {
      throw Exception(response.body);
      return false;
    }

    return true;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    _startLoading();

    final Response response = await this.post('/auth/login', body: '''{
      "email": "$email",
      "password": "$password",
      "device_name": "$_deviceName"
    }''');

    if (response.statusCode != 200) {
      _stopLoading();
      throw Exception(response.body);
    }

    return _storeUser(_userFromResponse(response.body));
  }

  @override
  Future<bool> signOut() async {
    _startLoading();

    final Response response = await this.delete('/auth/logout');

    if (response.statusCode != 200) {
      _stopLoading();
      throw Exception(response.body);
      return false;
    }

    await secureStorage.delete(key: tokenStorageKey);
    _token = null;
    _user = null;
    _stopLoading();

    return true;
  }

  void _startLoading() {
    _loading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _loading = false;
    notifyListeners();
  }

  User _storeUser(User user) {
    _user = user;
    _cacheToken(user.token);
    _stopLoading();

    return _user;
  }

  void _cacheToken(String token) {
    if (token == null) {
      return;
    }

    _token = token;
    secureStorage.write(key: tokenStorageKey, value: token);
  }

  User _userFromResponse(String response) {
    return standardSerializers.deserializeWith(
        User.serializer, json.decode(response));
  }

  /// NETWORK MIXIN

  @override
  String getAuthenticationHeader() {
    if (_token == null) {
      return null;
    }

    return '$tokenType $_token';
  }
}
