import 'dart:convert';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart' as http;

class SignSignApi {
  final apiUrl = 'https://signsign.ru/api/2.0';
  http.Client _client;

  SignSignApi() {
    _client = http.Client();
  }

  Future<dynamic> get(LatLngBounds bounds) async {
    final topLeft = bounds.northWest;
    final bottomRight = bounds.southEast;
    final requestBody = jsonEncode({
      "bounds": [
        // [topLeft.latitude, topLeft.longitude],
        // [bottomRight.latitude, bottomRight.longitude]
        [55.03014612528671, 82.91469293429488],
        [55.031427966316585, 82.92479413344499]
      ]
    });
    print('requestBody: ' + requestBody.toString());
    final res = await _client.post(
      '$apiUrl/get',
      headers: {
        "Content-Type": "application/json"
      },
      body: requestBody
    );
    return res.body;
  }
}
