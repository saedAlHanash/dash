import '../../../../core/strings/enum_manager.dart';

class ClientsFilterRequest {
  String? name;
  String? phoneNo;
  Gender? gender;

  ClientsFilterRequest({
    this.name,
    this.phoneNo,
    this.gender,
  });

  bool isRequestData() {
    return name != null && phoneNo != null && gender != null;
  }

  void clearFilter() {
    name = null;
    phoneNo = null;
    gender = null;
  }

  ClientsFilterRequest copyWith({
    String? name,
    String? phoneNo,
    Gender? gender,
  }) {
    return ClientsFilterRequest(
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phoneNo,
      'Gender': gender,
    };
  }

  factory ClientsFilterRequest.fromJson(Map<String, dynamic> map) {
    return ClientsFilterRequest(
      name: map['name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      gender: map['gender'] ?? '',
    );
  }
}
