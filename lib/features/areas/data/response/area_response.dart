import '../../../governorates/data/response/governorate_response.dart';

class AreaResponse {
  AreaResponse({
    required this.result,
  });

  final AreaResult result;

  factory AreaResponse.fromJson(Map<String, dynamic> json) {
    return AreaResponse(
      result: AreaResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class AreaResult {
  AreaResult({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<AreaModel> items;

  factory AreaResult.fromJson(Map<String, dynamic> json) {
    return AreaResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<AreaModel>.from(json["items"]!.map((x) => AreaModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class AreaModel {
  AreaModel({
    required this.id,
    required this.name,
    required this.governorateId,
    required this.governorate,
  });

  final int id;
  String name;
  num governorateId;
  final GovernorateModel governorate;

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      governorateId: json["governorateId"] ?? 0,
      governorate: GovernorateModel.fromJson(json["governorate"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "governorateId": governorateId,
      };
}
