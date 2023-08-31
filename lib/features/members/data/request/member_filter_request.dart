class MemberFilterRequest {
  String? collegeIdNumber;
  String? name;
  String? phoneNo;
  String? facility;
  String? idNumber;
  String? address;

  MemberFilterRequest({
    this.collegeIdNumber,
    this.name,
    this.phoneNo,
    this.facility,
    this.idNumber,
    this.address,
  });

  bool isRequestData() {
    return collegeIdNumber != null &&
        name != null &&
        phoneNo != null &&
        facility != null &&
        idNumber != null &&
        address != null;
  }

  void clearFilter() {
    collegeIdNumber = null;
    name = null;
    phoneNo = null;
    facility = null;
    idNumber = null;
    address = null;
  }

  MemberFilterRequest copyWith({
    String? collegeIdNumber,
    String? name,
    String? phoneNo,
    String? facility,
    String? idNumber,
    String? address,
  }) {
    return MemberFilterRequest(
      collegeIdNumber: collegeIdNumber ?? this.collegeIdNumber,
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      facility: facility ?? this.facility,
      idNumber: idNumber ?? this.idNumber,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collegeIdNumber': collegeIdNumber,
      'name': name,
      'phoneNo': phoneNo,
      'facility': facility,
      'idNumber': idNumber,
      'address': address,
    };
  }

  factory MemberFilterRequest.fromJson(Map<String, dynamic> map) {
    return MemberFilterRequest(
      collegeIdNumber: map['collegeIdNumber'] ?? '',
      name: map['name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      facility: map['facility'] ?? '',
      idNumber: map['idNumber'] ?? '',
      address: map['address'] ?? '',
    );
  }
}
