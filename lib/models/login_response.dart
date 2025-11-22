import 'package:podcast_demo/models/subscription_model.dart';
import 'package:podcast_demo/models/user_model.dart';

class LoginResponse {
  final UserModel user;
  final SubscriptionModel subscription;
  final String token;

  LoginResponse({
    required this.user,
    required this.subscription,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: UserModel.fromJson(json["data"]["user"]),
      subscription: SubscriptionModel.fromJson(json["data"]["subscription"]),
      token: json["data"]["token"],
    );
  }

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "subscription": subscription.toJson(),
    "token": token,
  };
}
