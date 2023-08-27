class SystemSettingResponse {
  SystemSettingResponse({
    required this.result,
  });

  final SystemSettingResult result;

  factory SystemSettingResponse.fromJson(Map<String, dynamic> json) {
    return SystemSettingResponse(
      result: SystemSettingResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class SystemSettingResult {
  SystemSettingResult({
    required this.totalCount,
    required this.items,
  });

  final num totalCount;
  final List<SystemSetting> items;

  factory SystemSettingResult.fromJson(Map<String, dynamic> json) {
    return SystemSettingResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<SystemSetting>.from(
              json["items"]!.map((x) => SystemSetting.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class SystemSetting {
  SystemSetting({
    this.mainClientAppVersion,
    this.mainSriverAppVersion,
    this.iosDomainTest,
    required this.id,
  });

  String? mainClientAppVersion;
  String? mainSriverAppVersion;
  bool? iosDomainTest;
  final int id;

  factory SystemSetting.fromJson(Map<String, dynamic> json) {
    return SystemSetting(
      mainClientAppVersion: json["mainClientAppVersion"] ?? "",
      mainSriverAppVersion: json["mainSriverAppVersion"] ?? "",
      iosDomainTest: json["iosDomainTest"] ?? false,
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "mainClientAppVersion": mainClientAppVersion,
        "mainSriverAppVersion": mainSriverAppVersion,
        "iosDomainTest": iosDomainTest,
        "id": id,
      };

  SystemSetting copyWith({
    String? mainClientAppVersion,
    String? mainSriverAppVersion,
    bool? iosDomainTest,
    int? id,
  }) {
    return SystemSetting(
      mainClientAppVersion: mainClientAppVersion ?? this.mainClientAppVersion,
      mainSriverAppVersion: mainSriverAppVersion ?? this.mainSriverAppVersion,
      iosDomainTest: iosDomainTest ?? this.iosDomainTest,
      id: id ?? this.id,
    );
  }
}
