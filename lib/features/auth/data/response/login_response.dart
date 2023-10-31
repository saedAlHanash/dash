import 'package:qareeb_models/global.dart';

class LoginResponse {
  LoginResponse({
    required this.result,
  });

  final UserModel result;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      result: UserModel.fromJson(json["result"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class UserModel {
  UserModel({
    required this.accessToken,
    required this.encryptedAccessToken,
    required this.expireInSeconds,
    required this.userId,
    required this.userTrip,
    required this.accepctPolicy,
    required this.institutionId,
    required this.agencyId,
    required this.userType,
    required this.roleName,
  });

  final String accessToken;
  final String encryptedAccessToken;
  final num expireInSeconds;
  final int userId;
  final String userTrip;
  final bool accepctPolicy;
  final int institutionId;
  final int agencyId;
  final UserType userType;
  final String roleName;

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      accessToken: json["accessToken"] ?? "",
      encryptedAccessToken: json["encryptedAccessToken"] ?? "",
      expireInSeconds: json["expireInSeconds"] ?? 0,
      userId: json["userId"] ?? 0,
      userTrip: json["userTrip"] ?? "",
      accepctPolicy: json["accepctPolicy"] ?? false,
      institutionId: json["institutionId"]??0,
      agencyId: json["agencyId"] ?? 0,
      userType: UserType.values[json["userType"] ?? 0],
      roleName: json["roleName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "encryptedAccessToken": encryptedAccessToken,
    "expireInSeconds": expireInSeconds,
    "userId": userId,
    "userTrip": userTrip,
    "accepctPolicy": accepctPolicy,
    "institutionId": institutionId,
    "agencyId": agencyId,
    "userType": userType.index,
    "roleName": roleName,
  };

}

