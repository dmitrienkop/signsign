import 'dart:convert';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'https://signsign.ru/api/2.0';

Future<String> getSignsList(LatLngBounds bounds) async {
  final topLeft = bounds.northWest;
  final bottomRight = bounds.southEast;

  final response = await http.post(
    '$apiUrl/get',
    body: jsonEncode({
      'bounds': [
        [topLeft.latitude, topLeft.longitude],
        [bottomRight.latitude, bottomRight.longitude]
      ]
    })
  );

  return response.body;
}
