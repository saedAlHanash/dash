


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
  final int busId;
  final BusModel bus;
  final int institutionId;
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



class BusModel {
  BusModel({
    required this.ime,
    required this.driverName,
    required this.driverPhone,
    required this.busModel,
    required this.busColor,
    required this.busNumber,
    required this.seatsNumber,
    required this.institutionId,
    required this.institution,
    required this.supervisors,
    required this.id,
  });

  final String ime;
  final String driverName;
  final String driverPhone;
  final String busModel;
  final String busColor;
  final String busNumber;
  final num seatsNumber;
  final num institutionId;
  final dynamic institution;
  final List<dynamic> supervisors;
  final int id;

  factory BusModel.fromJson(Map<String, dynamic> json){
    return BusModel(
      ime: json["ime"] ?? "",
      driverName: json["driverName"] ?? "",
      driverPhone: json["driverPhone"] ?? "",
      busModel: json["busModel"] ?? "",
      busColor: json["busColor"] ?? "",
      busNumber: json["busNumber"] ?? "",
      seatsNumber: json["seatsNumber"] ?? 0,
      institutionId: json["institutionId"] ?? 0,
      institution: json["institution"],
      supervisors: json["supervisors"] == null ? [] : List<dynamic>.from(json["supervisors"]!.map((x) => x)),
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "ime": ime,
    "driverName": driverName,
    "driverPhone": driverPhone,
    "busModel": busModel,
    "busColor": busColor,
    "busNumber": busNumber,
    "seatsNumber": seatsNumber,
    "institutionId": institutionId,
    "institution": institution,
    "supervisors": supervisors.map((x) => x).toList(),
    "id": id,
  };

}

