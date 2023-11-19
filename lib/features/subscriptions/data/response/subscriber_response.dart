class SubscriberResponse {
  SubscriberResponse({
    required this.result,
  });

  final SubscriberResult result;

  factory SubscriberResponse.fromJson(Map<String, dynamic> json) {
    return SubscriberResponse(
      result: SubscriberResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class SubscriberResult {
  SubscriberResult({
    required this.items,
    required this.totalCount,
  });

  final List<Subscriber> items;
  final int totalCount;

  factory SubscriberResult.fromJson(Map<String, dynamic> json) {
    return SubscriberResult(
      items: json["items"] == null
          ? []
          : List<Subscriber>.from(json["items"]!.map((x) => Subscriber.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class Subscriber {
  Subscriber({
    required this.id,
    required this.fullName,
    required this.imageUrl,
    required this.address,
    required this.late,
    required this.longe,
    required this.userName,
    required this.password,
    required this.phoneNo,
    required this.facility,
    required this.idNumber,
    required this.collegeIdNumber,
    required this.institutionId,
  });

  final int id;
  final String fullName;
  final String imageUrl;
  final String address;
  final num late;
  final num longe;
  final String userName;
  final String password;
  final String phoneNo;
  final String facility;
  final String idNumber;
  final String collegeIdNumber;
  final num institutionId;

  factory Subscriber.fromJson(Map<String, dynamic> json) {
    return Subscriber(
      id: json["id"] ?? 0,
      fullName: json["fullName"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      address: json["address"] ?? "",
      late: json["late"] ?? 0,
      longe: json["longe"] ?? 0,
      userName: json["userName"] ?? "",
      password: json["password"] ?? "",
      phoneNo: json["phoneNo"] ?? "",
      facility: json["facility"] ?? "",
      idNumber: json["idNumber"] ?? "",
      collegeIdNumber: json["collegeIdNumber"] ?? "",
      institutionId: json["institutionId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "imageUrl": imageUrl,
        "address": address,
        "late": late,
        "longe": longe,
        "userName": userName,
        "password": password,
        "phoneNo": phoneNo,
        "facility": facility,
        "idNumber": idNumber,
        "collegeIdNumber": collegeIdNumber,
        "institutionId": institutionId,
      };
}

class SubscriberListResponse {
  SubscriberListResponse({
    required this.result,
  });

  final List<Subscriber> result;

  factory SubscriberListResponse.fromJson(Map<String, dynamic> json) {
    return SubscriberListResponse(
      result: json["result"] == null
          ? []
          : List<Subscriber>.from(json["result"]!.map((x) => Subscriber.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.map((x) => x?.toJson()).toList(),
      };
}
