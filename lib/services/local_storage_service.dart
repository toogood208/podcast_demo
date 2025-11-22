import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_response.dart';
import '../models/subscription_model.dart';
import '../models/user_model.dart';

class LocalStorageService {
  Future<void> saveData(LoginResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("login_data", jsonEncode(response.toJson()));
  }
  Future<LoginResponse?> loadLoginData() async {
    final prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString("login_data");

    if (jsonString == null) return null;

    final jsonData = jsonDecode(jsonString);

    return LoginResponse(
      user: UserModel.fromJson(jsonData["user"]),
      subscription: SubscriptionModel.fromJson(jsonData["subscription"]),
      token: jsonData["token"],
    );
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("login_data");
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("login_data");
  }


}

var localProvider = Provider((ref)=> LocalStorageService());