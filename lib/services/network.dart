import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Columbo/models/serializers.dart';
import 'package:built_value/serializer.dart';

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

Future<dynamic> post(String url, {String body, Serializer serializer}) async {
  final response = await http.post(
    'http://127.0.0.1:8000/api/v1/$url',
    body: body,
    headers: {
      "Content-Type": "application/json",
    }
  );

//  if (response.statusCode != 200) {
//    handleError(response);
//    return;
//  }

  if (serializer == null) {
    return response.body;
  }

  return standardSerializers.deserializeWith(serializer, json.decode(response.body));
}

void handleError(dynamic response) {
  throw Exception('Failed to load resource');
}
