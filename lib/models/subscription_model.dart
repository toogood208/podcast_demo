class SubscriptionModel {
  final int id;
  final int userId;
  final String effectiveTime;
  final String expiryTime;
  final String statusCode;
  final Map<String, dynamic> details;

  SubscriptionModel({
    required this.id,
    required this.userId,
    required this.effectiveTime,
    required this.expiryTime,
    required this.statusCode,
    required this.details,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json["id"],
      userId: json["user_id"],
      effectiveTime: json["effectiveTime"],
      expiryTime: json["expiryTime"],
      statusCode: json["statusCode"],
      details: json["details"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "effectiveTime": effectiveTime,
    "expiryTime": expiryTime,
    "statusCode": statusCode,
    "details": details,
  };
}
