import 'package:qareeb_models/global.dart';

class ClientsFilterRequest {
  String? name;
  String? phoneNo;
  bool? isAvailable;
  Gender? gender;

  ClientsFilterRequest({
    this.name,
    this.phoneNo,
    this.isAvailable,
    this.gender,
  });

  bool isRequestData() {
    return name != null && phoneNo != null && gender != null;
  }

  void clearFilter() {
    name = null;
    isAvailable = null;
    phoneNo = null;
    gender = null;
  }

  ClientsFilterRequest copyWith({
    String? name,
    String? phoneNo,
    bool? isAvailable,
    Gender? gender,
  }) {
    return ClientsFilterRequest(
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      isAvailable: isAvailable ?? this.isAvailable,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phoneNo,
      'isAvailable': isAvailable,
      'Gender': gender,
    };
  }

  factory ClientsFilterRequest.fromJson(Map<String, dynamic> map) {
    return ClientsFilterRequest(
      name: map['name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      isAvailable: map['isAvailable'] ?? '',
      gender: map['gender'] ?? '',
    );
  }
}
