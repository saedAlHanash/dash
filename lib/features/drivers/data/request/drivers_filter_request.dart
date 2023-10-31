import 'package:qareeb_models/global.dart';

class DriversFilterRequest {
  String? name;
  String? phoneNo;
  int? agencyId;
  Gender? gender;
  DriverStatus? status;

  DriversFilterRequest({
    this.name,
    this.phoneNo,
    this.agencyId,
    this.gender,
    this.status,
  });


  void clearFilter() {
    name = null;
    phoneNo = null;
    agencyId = null;
    gender = null;
    status = null;
  }

  DriversFilterRequest copyWith({
    String? name,
    String? phoneNo,
    int? agencyId,
    Gender? gender,
    DriverStatus? status,
  }) {
    return DriversFilterRequest(
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      agencyId: agencyId ?? this.agencyId,
      gender: gender ?? this.gender,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Phone': phoneNo,
      'agencyId': agencyId,
      'Gender': gender,
      'Status': status?.index,
    };
  }

  factory DriversFilterRequest.fromJson(Map<String, dynamic> map) {
    return DriversFilterRequest(
      name: map['name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      agencyId: map['agencyId'] ?? '',
      gender: map['gender'] ?? '',
      status: map['status'] ?? '',
    );
  }
}
