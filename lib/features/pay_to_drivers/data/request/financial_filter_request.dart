import 'package:qareeb_models/global.dart';

class FinancialFilterRequest {
  String? name;
  String? phoneNo;
  bool? isAvailable;
  int? agencyId;
  int? carCategoryId;
  Gender? gender;

  FinancialFilterRequest({
    this.name,
    this.phoneNo,
    this.isAvailable,
    this.agencyId,
    this.carCategoryId,
    this.gender,
  });

  bool isRequestData() {
    return name != null && phoneNo != null && gender != null;
  }

  void clearFilter() {
    name = null;
    isAvailable = null;
    agencyId = null;
    carCategoryId = null;
    phoneNo = null;
    gender = null;
  }

  FinancialFilterRequest copyWith({
    String? name,
    String? phoneNo,
    bool? isAvailable,
    int? agencyId,
    int? carCategoryId,
    Gender? gender,
  }) {
    return FinancialFilterRequest(
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      isAvailable: isAvailable ?? this.isAvailable,
      agencyId: agencyId ?? this.agencyId,
      carCategoryId: carCategoryId ?? this.carCategoryId,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phoneNo,
      'isAvailable': isAvailable,
      'agencyId': agencyId,
      'carCategoryId': carCategoryId,
      'Gender': gender,
    };
  }

  factory FinancialFilterRequest.fromJson(Map<String, dynamic> map) {
    return FinancialFilterRequest(
      name: map['name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      isAvailable: map['isAvailable'] ?? '',
      agencyId: map['agencyId'] ?? '',
      carCategoryId: map['carCategoryId'] ?? '',
      gender: map['gender'] ?? '',
    );
  }
}
