import 'dart:convert';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart' as http;
import 'package:signsign/widgets/sign.dart';

class SignSignApi {
  final apiUrl = 'https://signsign.ru/api/2.0';
  final _client = http.Client();

  List<Sign> parseSigns(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed['result'].map<Sign>((json) => Sign.fromJSON(json)).toList();
  }

  Future<List<Sign>> get(LatLngBounds bounds) async {
    final topLeft = bounds.northWest;
    final bottomRight = bounds.southEast;
    final requestBody = jsonEncode({
      'bounds': [
        [topLeft.latitude, topLeft.longitude],
        [bottomRight.latitude, bottomRight.longitude]
      ]
    });
    final res = await _client.post(
      '$apiUrl/get',
      headers: {
        "Content-Type": "application/json"
      },
      body: requestBody
    );
    return parseSigns(res.body);
  }
}
