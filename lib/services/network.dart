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

void handleError(dynamic response) {
  throw Exception('Failed to load resource');
}
