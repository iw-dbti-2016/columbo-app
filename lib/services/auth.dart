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

  Auth() {
    deviceInfo
        .getDeviceName()
        .then((value) {
          _deviceName = value;
        })
        .then((_) => getUser())
        .then((_) {
          notifyListeners();
        })
        .catchError((e) => print('INIT exception: $e'));
  }

  // GETTERS

  bool get loading => _loading;

  bool get authenticated => _user != null;

  @override
  User get user => _user;

  @override
  String get token => _token;

  @override
  Future<User> register(String email, String password, String pwConfirm,
      String username, String firstName, String lastName) async {
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
        }),
        expectedStatus: 201,
        preExceptionAction: _stopLoading);

    return _storeUser(_userFromResponse(response.body));
  }

  Future<User> getUser({bool indicateLoading = true}) async {
    if (_user != null) {
      return _user;
    }

    return fetchUser(indicateLoading: indicateLoading);
  }

  @override
  Future<User> fetchUser({bool indicateLoading = true}) async {
    if (indicateLoading) {
      _startLoading();
    }

    if (await _retrieveToken() == null) {
      if (indicateLoading) {
        _stopLoading();
      }
      _user = null;
      return null;
    }

    final Response response = await this.get('/user', expectedStatus: 200);

    return _storeUser(_userFromResponse(response.body));
  }

  Future<String> _retrieveToken() async {
    if (_token != null) {
      return _token;
    }

    final storageToken = await secureStorage.read(key: tokenStorageKey);

    if (storageToken == null) {
      _token = null;
      return null;
    }

    return _token = storageToken;
  }

  @override
  Future<bool> refreshToken() async {
    _startLoading();
    final Response response = await this.patch('/auth/refresh',
        body: json.encode({"device_name": _deviceName}),
        expectedStatus: 200,
        preExceptionAction: _stopLoading);

    _storeUser(_userFromResponse(response.body));
    return true;
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    _startLoading();

    await this.post('/auth/password/email',
        body: json.encode({"email": email}),
        expectedStatus: 200,
        preExceptionAction: _stopLoading);

    _stopLoading();
    return true;
  }

  @override
  Future<bool> resendEmailVerification() async {
    _startLoading();

    await this.post('/auth/email/resend',
        expectedStatus: 200, preExceptionAction: _stopLoading);

    _stopLoading();
    return true;
  }

  @override
  Future<User> login(String email, String password) async {
    _startLoading();

    final Response response = await this.post('/auth/login',
        body: json.encode(
            {"email": email, "password": password, "device_name": _deviceName}),
        expectedStatus: 200,
        preExceptionAction: _stopLoading);

    return _storeUser(_userFromResponse(response.body));
  }

  @override
  Future<bool> logout() async {
    _startLoading();

    await this.delete('/auth/logout',
        expectedStatus: 200, preExceptionAction: _stopLoading);

    await secureStorage.delete(key: tokenStorageKey);
    _token = null;
    _user = null;

    _stopLoading();
    return true;
  }

  void _startLoading() {
    if (_loading) {
      // Already loading, no need to notify
      return;
    }
    _loading = true;
    notifyListeners();
  }

  void _stopLoading() {
    if (!_loading) {
      // Already not loading, no need to notify
      return;
    }
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
