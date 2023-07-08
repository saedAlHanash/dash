class AdminsResponse {
  AdminsResponse({
    required this.result,
  });

  final List<AdminModel> result;

  factory AdminsResponse.fromJson(Map<String, dynamic> json) {
    return AdminsResponse(
      result: json["result"] == null
          ? []
          : List<AdminModel>.from(json["result"]!.map((x) => AdminModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.map((x) => x.toJson()).toList(),
      };
}

class AdminModel {
  AdminModel({
    required this.id,
    required this.userName,
    required this.name,
    required this.surname,
    required this.emailAddress,
    required this.isActive,
    required this.address,
    required this.image,
    required this.avatar,
    required this.identity,
    required this.contract,
    required this.drivingLicence,
    required this.carMechanic,
    required this.birthdate,
    required this.gender,
    required this.fullName,
    required this.ageRange,
    required this.tripsCount,
    required this.favoritePlacesCount,
    required this.discountCouponValue,
    required this.fireBaseToken,
    required this.creationTime,
    required this.roleNames,
    required this.phoneNumber,
    required this.coupons,
    required this.imei,
    required this.password,
    required this.latitude,
    required this.longitude,
  });

  final int id;
  final String userName;
  final String name;
  final String surname;
  final String emailAddress;
   bool isActive;
  final String address;
  final String image;
  final String avatar;
  final String identity;
  final String contract;
  final String drivingLicence;
  final String carMechanic;
  final DateTime? birthdate;
  final int gender;
  final String fullName;
  final String ageRange;
  final num tripsCount;
  final num favoritePlacesCount;
  final num discountCouponValue;
  final String fireBaseToken;
  final String creationTime;
  final List<String> roleNames;
  final String phoneNumber;
  final String coupons;
  final dynamic imei;
  final String password;
  final num latitude;
  final num longitude;

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json["id"] ?? 0,
      userName: json["userName"] ?? "",
      name: json["name"] ?? "",
      surname: json["surname"] ?? "",
      emailAddress: json["emailAddress"] ?? "",
      isActive: json["isActive"] ?? false,
      address: json["address"] ?? "",
      image: json["image"] ?? "",
      avatar: json["avatar"] ?? "",
      identity: json["identity"] ?? "",
      contract: json["contract"] ?? "",
      drivingLicence: json["drivingLicence"] ?? "",
      carMechanic: json["carMechanic"] ?? "",
      birthdate: DateTime.tryParse(json["birthdate"] ?? ""),
      gender: json["gender"] ?? "",
      fullName: json["fullName"] ?? "",
      ageRange: json["ageRange"] ?? "",
      tripsCount: json["tripsCount"] ?? 0,
      favoritePlacesCount: json["favoritePlacesCount"] ?? 0,
      discountCouponValue: json["discountCouponValue"] ?? 0,
      fireBaseToken: json["fireBaseToken"] ?? "",
      creationTime: json["creationTime"] ?? "",
      roleNames: json["roleNames"] == null
          ? []
          : List<String>.from(json["roleNames"]!.map((x) => x)),
      phoneNumber: json["phoneNumber"] ?? "",
      coupons: json["coupons"] ?? "",
      imei: json["imei"] ?? "",
      password: json["password"] ?? "",
      latitude: json["latitude"] ?? 0,
      longitude: json["longitude"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "name": name,
        "surname": surname,
        "emailAddress": emailAddress,
        "isActive": isActive,
        "address": address,
        "image": image,
        "avatar": avatar,
        "identity": identity,
        "contract": contract,
        "drivingLicence": drivingLicence,
        "carMechanic": carMechanic,
        "birthdate": birthdate?.toIso8601String(),
        "gender": gender,
        "fullName": fullName,
        "ageRange": ageRange,
        "tripsCount": tripsCount,
        "favoritePlacesCount": favoritePlacesCount,
        "discountCouponValue": discountCouponValue,
        "fireBaseToken": fireBaseToken,
        "creationTime": creationTime,
        "roleNames": roleNames.map((x) => x).toList(),
        "phoneNumber": phoneNumber,
        "coupons": coupons,
        "imei": imei,
        "password": password,
        "latitude": latitude,
        "longitude": longitude,
      };
}
