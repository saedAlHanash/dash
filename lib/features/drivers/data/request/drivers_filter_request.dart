import 'package:qareeb_models/global.dart';

class DriversFilterRequest {
  String? name;
  String? phoneNo;
  int? agencyId;
  int? carCategoryId;
  Gender? gender;
  bool? isExamined;
  bool? isActive;
  bool? engineStatus;
  bool? orderByLastInternetConnection;
  DriverStatus? status;

  DriversFilterRequest({
    this.name,
    this.phoneNo,
    this.agencyId,
    this.carCategoryId,
    this.gender,
    this.isExamined,
    this.isActive = true,
    this.engineStatus,
    this.orderByLastInternetConnection,
    this.status,
  });


  void clearFilter() {
    name = null;
    phoneNo = null;
    agencyId = null;
    carCategoryId = null;
    gender = null;
    isExamined = null;
    isActive = null;
    engineStatus = null;
    orderByLastInternetConnection = null;
    status = null;
  }

  DriversFilterRequest copyWith({
    String? name,
    String? phoneNo,
    int? agencyId,
    int? carCategoryId,
    Gender? gender,
    bool? isExamined,
    bool? isActive,
    bool? engineStatus,
    bool? OrderByLastInternetConnection,
    DriverStatus? status,
  }) {
    return DriversFilterRequest(
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      agencyId: agencyId ?? this.agencyId,
      carCategoryId: carCategoryId ?? this.carCategoryId,
      gender: gender ?? this.gender,
      isExamined: isExamined ?? this.isExamined,
      isActive: isActive ?? this.isActive,
      engineStatus: engineStatus ?? this.engineStatus,
      orderByLastInternetConnection: OrderByLastInternetConnection ?? this.orderByLastInternetConnection,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Phone': phoneNo,
      'agencyId': agencyId,
      'carCategoryId': carCategoryId,
      'Gender': gender?.index,
      'IsExaminated': isExamined,
      'isActive': isActive,
      'engineStatus': engineStatus,
      'OrderByLastInternetConnection': orderByLastInternetConnection,
      'Status': status?.index,
    };
  }

  factory DriversFilterRequest.fromJson(Map<String, dynamic> map) {
    return DriversFilterRequest(
      name: map['name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      agencyId: map['agencyId'] ?? '',
      carCategoryId: map['carCategoryId'] ?? '',
      gender: map['gender'] ?? '',
      isExamined: map['IsExaminated'] ?? '',
      isActive: map['isActive'] ?? '',
      engineStatus: map['engineStatus'] ?? '',
      orderByLastInternetConnection: map['OrderByLastInternetConnection'] ?? '',
      status: map['status'] ?? '',
    );
  }
}
