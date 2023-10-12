import 'package:qareeb_models/global.dart';

class DriversFilterRequest {
  String? name;
  String? phoneNo;
  Gender? gender;
  DriverStatus? status;

  DriversFilterRequest({
    this.name,
    this.phoneNo,
    this.gender,
    this.status,
  });


  void clearFilter() {
    name = null;
    phoneNo = null;
    gender = null;
    status = null;
  }

  DriversFilterRequest copyWith({
    String? name,
    String? phoneNo,
    Gender? gender,
    DriverStatus? status,
  }) {
    return DriversFilterRequest(
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      gender: gender ?? this.gender,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Phone': phoneNo,
      'Gender': gender,
      'Status': status?.index,
    };
  }

  factory DriversFilterRequest.fromJson(Map<String, dynamic> map) {
    return DriversFilterRequest(
      name: map['name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      gender: map['gender'] ?? '',
      status: map['status'] ?? '',
    );
  }
}
