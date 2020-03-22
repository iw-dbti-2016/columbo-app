import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:Columbo/models/serializers.dart';
import 'package:built_value/serializer.dart';
import 'package:http/http.dart';

abstract class Network {
  factory Network._() => null;

  static const String baseUrl = "http://127.0.0.1:8000/api/v1";
  static const Map<String, String> defaultHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<Response> get(String url,
      {@required int expectedStatus, Function preExceptionAction}) async {
    final Response response =
        await http.get('$baseUrl$url', headers: getHeaders());
    handleErrors(response, expectedStatus, preExceptionAction);

    return response;
  }

  Future<Response> post(String url,
      {String body,
      @required int expectedStatus,
      Function preExceptionAction}) async {
    final Response response =
        await http.post('$baseUrl$url', body: body, headers: getHeaders());
    handleErrors(response, expectedStatus, preExceptionAction);

    return response;
  }

  Future<Response> patch(String url,
      {String body,
      @required int expectedStatus,
      Function preExceptionAction}) async {
    final Response response =
        await http.patch('$baseUrl$url', body: body, headers: getHeaders());
    handleErrors(response, expectedStatus, preExceptionAction);

    return response;
  }

  Future<Response> delete(String url,
      {@required int expectedStatus, Function preExceptionAction}) async {
    final Response response =
        await http.delete('$baseUrl$url', headers: getHeaders());
    handleErrors(response, expectedStatus, preExceptionAction);

    return response;
  }

  @nonVirtual
  Map<String, String> getHeaders() {
    return {
      if (getAuthenticationHeader() != null)
        "Authorization": getAuthenticationHeader(),
      ...defaultHeaders,
    };
  }

  @nonVirtual
  void handleErrors(Response response, int expectedStatus,
      [Function preExceptionAction]) {
    if (expectedStatus == null || response.statusCode == expectedStatus) {
      return;
    }

    if (preExceptionAction != null) {
      preExceptionAction();
    }

    throw Exception("Error not correctly handled.");
  }

  String getAuthenticationHeader() {
    return null;
  }
}

Future<dynamic> getResourceList(String url, Serializer serializer) async {
  final response = await http.get('http://127.0.0.1:8000/api/v1/$url');

  if (response.statusCode != 200) {
    handleError(response);
    return;
  }

  return json
      .decode(response.body)
      .map(
          (dynamic map) => standardSerializers.deserializeWith(serializer, map))
      .toList();
}

void handleError(dynamic response) {
  throw Exception('Failed to load resource');
}
