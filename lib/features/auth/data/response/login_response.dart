class LoginResponse {
  LoginResponse({
    required this.result,
  });

  final LoginResult result;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      result: LoginResult.fromJson(json["result"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class LoginResult {
  LoginResult({
    required this.accessToken,
    required this.encryptedAccessToken,
    required this.expireInSeconds,
    required this.userId,
    required this.userTrip,
    required this.accepctPolicy,
  });

  final String accessToken;
  final String encryptedAccessToken;
  final int expireInSeconds;
  final int userId;
  final String userTrip;
  final bool accepctPolicy;

  factory LoginResult.initial() {
    return LoginResult.fromJson({});
  }

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      accessToken: json["accessToken"] ?? "",
      encryptedAccessToken: json["encryptedAccessToken"] ?? "",
      expireInSeconds: json["expireInSeconds"] ?? 0,
      userId: json["userId"] ?? 0,
      userTrip: json["userTrip"] ?? "",
      accepctPolicy: json["accepctPolicy"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "encryptedAccessToken": encryptedAccessToken,
        "expireInSeconds": expireInSeconds,
        "userId": userId,
        "userTrip": userTrip,
        "accepctPolicy": accepctPolicy,
      };
}
