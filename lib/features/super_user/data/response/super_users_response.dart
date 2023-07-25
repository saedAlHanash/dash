import 'package:qareeb_dash/features/buses/data/response/buses_response.dart';


class SuperUsersResponse {
  SuperUsersResponse({
    required this.result,
  });

  final SuperUserResult result;

  factory SuperUsersResponse.fromJson(Map<String, dynamic> json) {
    return SuperUsersResponse(
      result: SuperUserResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class SuperUserResult {
  SuperUserResult({
    required this.totalCount,
    required this.items,
  });

   int totalCount;
  final List<SuperUserModel> items;

  factory SuperUserResult.fromJson(Map<String, dynamic> json) {
    return SuperUserResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<SuperUserModel>.from(
              json["items"]!.map((x) => SuperUserModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class SuperUserModel {
  SuperUserModel({
    required this.fullName,
    required this.phone,
    required this.userName,
    required this.password,
    required this.busId,
    required this.bus,
    required this.institutionId,
    required this.id,
  });

  final String fullName;
  final String phone;
  final String userName;
  final String password;
  final num busId;
  final BusModel bus;
  final num institutionId;
  final int id;

  factory SuperUserModel.fromJson(Map<String, dynamic> json) {
    return SuperUserModel(
      fullName: json["fullName"] ?? "",
      phone: json["phone"] ?? "",
      userName: json["userName"] ?? "",
      password: json["password"] ?? "",
      busId: json["busId"] ?? 0,
      bus: BusModel.fromJson(json["bus"] ?? {}),
      institutionId: json["institutionId"] ?? 0,
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phone": phone,
        "userName": userName,
        "password": password,
        "busId": busId,
        "bus": bus.toJson(),
        "institutionId": institutionId,
        "id": id,
      };
}


