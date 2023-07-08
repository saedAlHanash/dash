class ClientResponse {
  ClientResponse({
    required this.result,
  });

  final List<ClientResult> result;

  factory ClientResponse.fromJson(Map<String, dynamic> json) {
    return ClientResponse(
      result: json["result"] == null
          ? []
          : List<ClientResult>.from(json["result"]!.map((x) => ClientResult.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.map((x) => x.toJson()).toList(),
      };
}

class ClientResult {
  ClientResult({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.name,
    required this.fireBaseToken,
    required this.carCategoryId,
    required this.surname,
    required this.birthdate,
    required this.address,
    required this.phoneNumber,
    required this.carCategories,
    required this.currentLocation,
    required this.carType,
    required this.userType,
    required this.roleNames,
    required this.isActive,
    required this.isLoyaltySupscriper,
    required this.emailConfirmationCode,
    required this.creationTime,
    required this.emailAddress,
    required this.imei,
    required this.qarebDeviceimei,
    required this.gender,
    required this.avatar,
    required this.identity,
    required this.contract,
    required this.drivingLicence,
    required this.carMechanic,
    required this.password,
  });

  final int id;
  final String userName;
  final String fullName;
  final String name;
  final String fireBaseToken;
  final num carCategoryId;
  final String surname;
  final String birthdate;
  final String address;
  final String phoneNumber;
  final CarCategories? carCategories;
  final CurrentLocation? currentLocation;
  final CarType? carType;
  final String userType;
  final List<String> roleNames;
  final bool isActive;
  final bool isLoyaltySupscriper;
  final String emailConfirmationCode;
  final String creationTime;
  final String emailAddress;
  final String imei;
  final String qarebDeviceimei;
  final String gender;
  final String avatar;
  final String identity;
  final String contract;
  final String drivingLicence;
  final String carMechanic;
  final String password;

  factory ClientResult.fromJson(Map<String, dynamic> json) {
    return ClientResult(
      id: json["id"] ?? 0,
      userName: json["userName"] ?? "",
      fullName: json["fullName"] ?? "",
      name: json["name"] ?? "",
      fireBaseToken: json["fireBaseToken"] ?? "",
      carCategoryId: json["carCategoryID"] ?? 0,
      surname: json["surname"] ?? "",
      birthdate: json["birthdate"] ?? "",
      address: json["address"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      carCategories: json["carCategories"] == null
          ? null
          : CarCategories.fromJson(json["carCategories"]),
      currentLocation: json["currentLocation"] == null
          ? null
          : CurrentLocation.fromJson(json["currentLocation"]),
      carType: json["carType"] == null ? null : CarType.fromJson(json["carType"]),
      userType: json["userType"] ?? "",
      roleNames: json["roleNames"] == null
          ? []
          : List<String>.from(json["roleNames"]!.map((x) => x)),
      isActive: json["isActive"] ?? false,
      isLoyaltySupscriper: json["isLoyaltySupscriper"] ?? false,
      emailConfirmationCode: json["emailConfirmationCode"] ?? "",
      creationTime: json["creationTime"] ?? "",
      emailAddress: json["emailAddress"] ?? "",
      imei: json["imei"] ?? "",
      qarebDeviceimei: json["qarebDeviceimei"] ?? "",
      gender: json["gender"] ?? "",
      avatar: json["avatar"] ?? "",
      identity: json["identity"] ?? "",
      contract: json["contract"] ?? "",
      drivingLicence: json["drivingLicence"] ?? "",
      carMechanic: json["carMechanic"] ?? "",
      password: json["password"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "fullName": fullName,
        "name": name,
        "fireBaseToken": fireBaseToken,
        "carCategoryID": carCategoryId,
        "surname": surname,
        "birthdate": birthdate,
        "address": address,
        "phoneNumber": phoneNumber,
        "carCategories": carCategories?.toJson(),
        "currentLocation": currentLocation?.toJson(),
        "carType": carType?.toJson(),
        "userType": userType,
        "roleNames": roleNames.map((x) => x).toList(),
        "isActive": isActive,
        "isLoyaltySupscriper": isLoyaltySupscriper,
        "emailConfirmationCode": emailConfirmationCode,
        "creationTime": creationTime,
        "emailAddress": emailAddress,
        "imei": imei,
        "qarebDeviceimei": qarebDeviceimei,
        "gender": gender,
        "avatar": avatar,
        "identity": identity,
        "contract": contract,
        "drivingLicence": drivingLicence,
        "carMechanic": carMechanic,
        "password": password,
      };
}

class CarCategories {
  CarCategories({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.driverRatio,
    required this.nightKmOverCost,
    required this.dayKmOverCost,
    required this.sharedKmOverCost,
    required this.nightSharedKmOverCost,
    required this.sharedDriverRatio,
    required this.minimumDayPrice,
    required this.minimumNightPrice,
    required this.companyLoyaltyRatio,
  });

  final int id;
  final String name;
  final String imageUrl;
  final num price;
  final num driverRatio;
  final num nightKmOverCost;
  final num dayKmOverCost;
  final num sharedKmOverCost;
  final num nightSharedKmOverCost;
  final num sharedDriverRatio;
  final num minimumDayPrice;
  final num minimumNightPrice;
  final num companyLoyaltyRatio;

  factory CarCategories.fromJson(Map<String, dynamic> json) {
    return CarCategories(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      price: json["price"] ?? 0,
      driverRatio: json["driverRatio"] ?? 0,
      nightKmOverCost: json["nightKMOverCost"] ?? 0,
      dayKmOverCost: json["dayKMOverCost"] ?? 0,
      sharedKmOverCost: json["sharedKMOverCost"] ?? 0,
      nightSharedKmOverCost: json["nightSharedKMOverCost"] ?? 0,
      sharedDriverRatio: json["sharedDriverRatio"] ?? 0,
      minimumDayPrice: json["minimumDayPrice"] ?? 0,
      minimumNightPrice: json["minimumNightPrice"] ?? 0,
      companyLoyaltyRatio: json["companyLoyaltyRatio"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "price": price,
        "driverRatio": driverRatio,
        "nightKMOverCost": nightKmOverCost,
        "dayKMOverCost": dayKmOverCost,
        "sharedKMOverCost": sharedKmOverCost,
        "nightSharedKMOverCost": nightSharedKmOverCost,
        "sharedDriverRatio": sharedDriverRatio,
        "minimumDayPrice": minimumDayPrice,
        "minimumNightPrice": minimumNightPrice,
        "companyLoyaltyRatio": companyLoyaltyRatio,
      };
}

class CarType {
  CarType({
    required this.userId,
    required this.carBrand,
    required this.carModel,
    required this.carColor,
    required this.carNumber,
    required this.seatsNumber,
  });

  final num userId;
  final String carBrand;
  final String carModel;
  final String carColor;
  final String carNumber;
  final num seatsNumber;

  factory CarType.fromJson(Map<String, dynamic> json) {
    return CarType(
      userId: json["userId"] ?? 0,
      carBrand: json["carBrand"] ?? "",
      carModel: json["carModel"] ?? "",
      carColor: json["carColor"] ?? "",
      carNumber: json["carNumber"] ?? "",
      seatsNumber: json["seatsNumber"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "carBrand": carBrand,
        "carModel": carModel,
        "carColor": carColor,
        "carNumber": carNumber,
        "seatsNumber": seatsNumber,
      };
}

class CurrentLocation {
  CurrentLocation({
    required this.clientId,
    required this.longitud,
    required this.latitud,
    required this.speed,
    required this.active,
  });

  final num clientId;
  final num longitud;
  final num latitud;
  final String speed;
  final String active;

  factory CurrentLocation.fromJson(Map<String, dynamic> json) {
    return CurrentLocation(
      clientId: json["clientId"] ?? 0,
      longitud: json["longitud"] ?? 0,
      latitud: json["latitud"] ?? 0,
      speed: json["speed"] ?? "",
      active: json["active"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "longitud": longitud,
        "latitud": latitud,
        "speed": speed,
        "active": active,
      };
}
