class BusesFilterRequest {
  String? imei;
  String? name;


  BusesFilterRequest({
    this.imei,
    this.name,

  });

  bool isRequestData() {
    return imei != null &&
        name != null;
  }

  void clearFilter() {
    imei = null;
    name = null;
  }

  BusesFilterRequest copyWith({
    String? imei,
    String? name,
    String? phoneNo,
    String? facility,
    String? idNumber,
    String? address,
  }) {
    return BusesFilterRequest(
      imei: imei ?? this.imei,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Imei': imei,
      'DriverName': name,
      'Name': name,
    };
  }

  factory BusesFilterRequest.fromJson(Map<String, dynamic> map) {
    return BusesFilterRequest(
      imei: map['Imei'] ?? '',
      name: map['DriverName'] ?? '',
    );
  }
}
