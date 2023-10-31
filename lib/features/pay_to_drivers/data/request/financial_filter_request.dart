import 'package:qareeb_models/global.dart';

class FinancialFilterRequest {
  String? name;
  String? phoneNo;
  bool? isAvailable;
  int? agencyId;
  Gender? gender;

  FinancialFilterRequest({
    this.name,
    this.phoneNo,
    this.isAvailable,
    this.agencyId,
    this.gender,
  });

  bool isRequestData() {
    return name != null && phoneNo != null && gender != null;
  }

  void clearFilter() {
    name = null;
    isAvailable = null;
    agencyId = null;
    phoneNo = null;
    gender = null;
  }

  FinancialFilterRequest copyWith({
    String? name,
    String? phoneNo,
    bool? isAvailable,
    int? agencyId,
    Gender? gender,
  }) {
    return FinancialFilterRequest(
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      isAvailable: isAvailable ?? this.isAvailable,
      agencyId: agencyId ?? this.agencyId,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phoneNo,
      'isAvailable': isAvailable,
      'agencyId': agencyId,
      'Gender': gender,
    };
  }

  factory FinancialFilterRequest.fromJson(Map<String, dynamic> map) {
    return FinancialFilterRequest(
      name: map['name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      isAvailable: map['isAvailable'] ?? '',
      agencyId: map['agencyId'] ?? '',
      gender: map['gender'] ?? '',
    );
  }
}
