import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.10.194:5000";

  static Future<Map<String, dynamic>> predictCrop({
    required double n,
    required double p,
    required double k,

    required double temp,
    required double humidity,
    required double ph,
    required double rainfall,

    required String state,
    required String season,

    required double area,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/predict"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({
        "N": n,
        "P": p,
        "K": k,

        "temperature": temp,
        "humidity": humidity,
        "ph": ph,
        "rainfall": rainfall,

        "state": state,
        "season": season,

        "area": area,
      }),
    );

    return jsonDecode(response.body);
  }
}
