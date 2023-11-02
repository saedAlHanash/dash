import 'package:qareeb_models/global.dart';

class DriversFilterRequest {
  String? name;
  String? phoneNo;
  int? agencyId;
  int? carCategoryId;
  Gender? gender;
  DriverStatus? status;

  DriversFilterRequest({
    this.name,
    this.phoneNo,
    this.agencyId,
    this.carCategoryId,
    this.gender,
    this.status,
  });


  void clearFilter() {
    name = null;
    phoneNo = null;
    agencyId = null;
    carCategoryId = null;
    gender = null;
    status = null;
  }

  DriversFilterRequest copyWith({
    String? name,
    String? phoneNo,
    int? agencyId,
    int? carCategoryId,
    Gender? gender,
    DriverStatus? status,
  }) {
    return DriversFilterRequest(
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      agencyId: agencyId ?? this.agencyId,
      carCategoryId: carCategoryId ?? this.carCategoryId,
      gender: gender ?? this.gender,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Phone': phoneNo,
      'agencyId': agencyId,
      'carCategoryId': carCategoryId,
      'Gender': gender,
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
      status: map['status'] ?? '',
    );
  }
}
