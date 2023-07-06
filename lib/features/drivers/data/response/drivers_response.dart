import '../../../../core/strings/fix_url.dart';
import '../../../trip/data/shared/location_model.dart';

class DriversResponse {
  DriversResponse({
    required this.result,
  });

  final List<DriverModel> result;

  factory DriversResponse.fromJson(Map<String, dynamic> json) {
    return DriversResponse(
      result: json["result"] == null
          ? []
          : List<DriverModel>.from(json["result"]!.map((x) => DriverModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.map((x) => x.toJson()).toList(),
      };
}

class DriverModel {
  DriverModel({
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
    required this.loyalty,
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
  final CarCategories carCategories;
  final LocationModel currentLocation;
  final CarType carType;
  final int userType;
  final List<String> roleNames;
  bool isActive;
  bool loyalty;
  final String emailConfirmationCode;
  final String creationTime;
  final String emailAddress;
  final dynamic imei;
  final String qarebDeviceimei;
  final int gender;
  final String avatar;
  final String identity;
  final String contract;
  final String drivingLicence;
  final String carMechanic;
  final String password;

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
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
      carCategories: CarCategories.fromJson(json["carCategories"] ?? {}),
      currentLocation: LocationModel.fromJson(json["currentLocation"] ?? {}),
      carType: CarType.fromJson(json["carType"] ?? {}),
      userType: json["userType"] ?? 0,
      roleNames: json["roleNames"] == null
          ? []
          : List<String>.from(json["roleNames"]!.map((x) => x)),
      isActive: json["isActive"] ?? false,
      loyalty: json["isLoyaltySupscriper"] ?? false,
      emailConfirmationCode: json["emailConfirmationCode"] ?? "",
      creationTime: json["creationTime"] ?? "",
      emailAddress: json["emailAddress"] ?? "",
      imei: json["imei"] ?? '',
      qarebDeviceimei: json["qarebDeviceimei"] ?? '',
      gender: json["gender"] ?? 0,
      avatar: fixAvatarImage(json["avatar"] ?? ""),
      identity: fixAvatarImage(json["identity"] ?? ""),
      contract: fixAvatarImage(json["contract"] ?? ""),
      drivingLicence: fixAvatarImage(json["drivingLicence"] ?? ""),
      carMechanic: fixAvatarImage(json["carMechanic"] ?? ""),
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
        "carCategories": carCategories.toJson(),
        "currentLocation": currentLocation.toJson(),
        "carType": carType.toJson(),
        "userType": userType,
        "roleNames": roleNames.map((x) => x).toList(),
        "isActive": isActive,
        "emailConfirmationCode": emailConfirmationCode,
        "creationTime": creationTime,
        "emailAddress": emailAddress,
        "imei": imei,
        "loyalty": loyalty,
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
    required this.seatsNumber,
    required this.price,
    required this.driverRatio,
    required this.nightKmOverCost,
    required this.dayKmOverCost,
    required this.sharedKmOverCost,
    required this.nightSharedKmOverCost,
    required this.sharedDriverRatio,
    required this.minimumDayPrice,
    required this.minimumNightPrice,
    required this.gold,
    required this.oil,
    required this.tires,
    required this.clientLoyalty,
    required this.driverLoyalty,
    required this.companyRatio,
    required this.sharedGold,
    required this.sharedOil,
    required this.sharedTires,
    required this.sharedClientLoyalty,
    required this.sharedDriverLoyalty,
    required this.sharedCompanyRatio,
  });

  final int id;
  final String name;
  final String imageUrl;
  final num seatsNumber;
  final num price;
  final num driverRatio;
  final num nightKmOverCost;
  final num dayKmOverCost;
  final num sharedKmOverCost;
  final num nightSharedKmOverCost;
  final num sharedDriverRatio;
  final num minimumDayPrice;
  final num minimumNightPrice;
  final num gold;
  final num oil;
  final num tires;
  final num clientLoyalty;
  final num driverLoyalty;
  final num companyRatio;
  final num sharedGold;
  final num sharedOil;
  final num sharedTires;
  final num sharedClientLoyalty;
  final num sharedDriverLoyalty;
  final num sharedCompanyRatio;

  factory CarCategories.fromJson(Map<String, dynamic> json) {
    return CarCategories(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      seatsNumber: json["seatsNumber"] ?? 0,
      price: json["price"] ?? 0,
      driverRatio: json["driverRatio"] ?? 0,
      nightKmOverCost: json["nightKMOverCost"] ?? 0,
      dayKmOverCost: json["dayKMOverCost"] ?? 0,
      sharedKmOverCost: json["sharedKMOverCost"] ?? 0,
      nightSharedKmOverCost: json["nightSharedKMOverCost"] ?? 0,
      sharedDriverRatio: json["sharedDriverRatio"] ?? 0,
      minimumDayPrice: json["minimumDayPrice"] ?? 0,
      minimumNightPrice: json["minimumNightPrice"] ?? 0,
      gold: json["gold"] ?? 0,
      oil: json["oil"] ?? 0,
      tires: json["tires"] ?? 0,
      clientLoyalty: json["clientLoyalty"] ?? 0,
      driverLoyalty: json["driverLoyalty"] ?? 0,
      companyRatio: json["companyRatio"] ?? 0,
      sharedGold: json["sharedGold"] ?? 0,
      sharedOil: json["sharedOil"] ?? 0,
      sharedTires: json["sharedTires"] ?? 0,
      sharedClientLoyalty: json["sharedClientLoyalty"] ?? 0,
      sharedDriverLoyalty: json["sharedDriverLoyalty"] ?? 0,
      sharedCompanyRatio: json["sharedCompanyRatio"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "seatsNumber": seatsNumber,
        "price": price,
        "driverRatio": driverRatio,
        "nightKMOverCost": nightKmOverCost,
        "dayKMOverCost": dayKmOverCost,
        "sharedKMOverCost": sharedKmOverCost,
        "nightSharedKMOverCost": nightSharedKmOverCost,
        "sharedDriverRatio": sharedDriverRatio,
        "minimumDayPrice": minimumDayPrice,
        "minimumNightPrice": minimumNightPrice,
        "gold": gold,
        "oil": oil,
        "tires": tires,
        "clientLoyalty": clientLoyalty,
        "driverLoyalty": driverLoyalty,
        "companyRatio": companyRatio,
        "sharedGold": sharedGold,
        "sharedOil": sharedOil,
        "sharedTires": sharedTires,
        "sharedClientLoyalty": sharedClientLoyalty,
        "sharedDriverLoyalty": sharedDriverLoyalty,
        "sharedCompanyRatio": sharedCompanyRatio,
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
