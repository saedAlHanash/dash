import 'package:qareeb_dash/core/strings/fix_url.dart';

class BusResponse {
  BusResponse({
    required this.result,
  });

  final BusModel result;

  factory BusResponse.fromJson(Map<String, dynamic> json) {
    return BusResponse(
      result: BusModel.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class BusesResponse {
  BusesResponse({
    required this.result,
  });

  final BusResult? result;

  factory BusesResponse.fromJson(Map<String, dynamic> json) {
    return BusesResponse(
      result: json["result"] == null ? null : BusResult.fromJson(json["result"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
      };
}

class BusResult {
  BusResult({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  final List<BusModel> items;

  factory BusResult.fromJson(Map<String, dynamic> json) {
    return BusResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<BusModel>.from(json["items"]!.map((x) => BusModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
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
  final List<Supervisor> supervisors;
  final int id;

  factory BusModel.fromJson(Map<String, dynamic> json) {
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
      supervisors: json["supervisors"] == null
          ? []
          : List<Supervisor>.from(
              json["supervisors"]!.map(
                (x) => Supervisor.fromJson(x),
              ),
            ),
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

class Supervisor {
  Supervisor({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.userName,
    required this.password,
    required this.busId,
    required this.bus,
    required this.institutionId,
  });

  final int id;
  final String fullName;
  final String phone;
  final String userName;
  final String password;
  final num busId;
  final String bus;
  final num institutionId;

  factory Supervisor.fromJson(Map<String, dynamic> json) {
    return Supervisor(
      id: json["id"] ?? 0,
      fullName: json["fullName"] ?? "",
      phone: json["phone"] ?? "",
      userName: json["userName"] ?? "",
      password: json["password"] ?? "",
      busId: json["busId"] ?? 0,
      bus: json["bus"] ?? "",
      institutionId: json["institutionId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "phone": phone,
        "userName": userName,
        "password": password,
        "busId": busId,
        "bus": bus,
        "institutionId": institutionId,
      };
}
