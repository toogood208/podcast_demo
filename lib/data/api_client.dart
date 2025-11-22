import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:podcast_demo/data/api_exceptions.dart';

class ApiClient {
  final String baseUrl = "https://api.jollypodcast.net/api";

  Future<Map<String, dynamic>> get(String endpoint, {String? token}) async {
    final uri = Uri.parse("$baseUrl$endpoint");

    final response = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      final map = jsonDecode(response.body);
      final errorMsg = map["message"] ?? "Something went wrong";

      throw ApiExceptions(message: errorMsg, statusCode: response.statusCode);
    }

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> postForm(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final uri = Uri.parse("$baseUrl$endpoint");

    var request = http.MultipartRequest("POST", uri);

    body.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    final response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      final map = jsonDecode(respStr);
      final errorMsg = map["message"] ?? "Something went wrong";

      throw ApiExceptions(message: errorMsg, statusCode: response.statusCode);
    }

    return jsonDecode(respStr);
  }
}

String getErrorMessage(Object e) {
  if (e is ApiExceptions) {
    return e.message;
  } else if (e is http.Response) {
    try {
      final map = jsonDecode(e.body);
      if (map['message'] != null) return map['message'];
    } catch (_) {}
  } else if (e is FormatException) {
    return e.message;
  }

  return e.toString();
}

final apiClientProvider = Provider((ref)  {
  return ApiClient();
});
