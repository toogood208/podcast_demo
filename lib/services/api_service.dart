import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_demo/data/api_client.dart';
import 'package:podcast_demo/models/login_response.dart';
import 'package:podcast_demo/services/local_storage_service.dart';

import '../data/api_exceptions.dart';
import '../models/podcast_response.dart';

class ApiService {
  ApiClient client;
  LocalStorageService localStorageService;
  ApiService(this.client, this.localStorageService);

  Future<LatestEpisodesResponse> getRecentPodCast() async {
    try {
      final login = await localStorageService.loadLoginData();

      if (login == null) {
        throw ApiExceptions(
          message: "Unauthorized. Please login again.",
          statusCode: 401,
        );
      }
      final response = await client.get("/episodes/latest", token: login.token);
      var latestResponse = LatestEpisodesResponse.fromJson(response);
      return latestResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await client.postForm("/auth/login", {
        "phone_number": phoneNumber,
        "password": password,
      });

      var loginResponse = LoginResponse.fromJson(response);
      await localStorageService.saveData(loginResponse);
      return loginResponse;
    } catch (ex) {
      rethrow;
    }
  }
}

var apiServiceProvider = Provider(
  (ref) => ApiService(ref.read(apiClientProvider), ref.read(localProvider)),
);
