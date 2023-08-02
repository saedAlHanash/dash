import '../../../../core/strings/enum_manager.dart';

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
    required this.institutionId,
    required this.userId,
    required this.userType,
    required this.accepctPolicy,
  });

  final String accessToken;
  final String encryptedAccessToken;
  final int institutionId;
  final int userId;
  final UserType userType;
  final bool accepctPolicy;

  factory LoginResult.initial() {
    return LoginResult.fromJson({});
  }

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      accessToken: json["accessToken"] ?? "",
      encryptedAccessToken: json["encryptedAccessToken"] ?? "",
      institutionId: json["institutionId"] ?? 0,
      userId: json["userId"] ?? 0,
      userType: UserType.values[json["userType"] ?? 0],
      accepctPolicy: json["accepctPolicy"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "encryptedAccessToken": encryptedAccessToken,
        "institutionId": institutionId,
        "userId": userId,
        "userType": userType,
        "accepctPolicy": accepctPolicy,
      };
}
