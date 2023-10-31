import 'package:qareeb_dash/core/strings/fix_url.dart';

class AgenciesResponse {
  AgenciesResponse({
    required this.result,
  });

  final AgenciesResult result;

  factory AgenciesResponse.fromJson(Map<String, dynamic> json) {
    return AgenciesResponse(
      result: AgenciesResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class AgenciesResult {
  AgenciesResult({
    required this.items,
    required this.totalCount,
  });

  final List<Agency> items;
  final int totalCount;

  factory AgenciesResult.fromJson(Map<String, dynamic> json) {
    return AgenciesResult(
      items: json["items"] == null
          ? []
          : List<Agency>.from(json["items"]!.map((x) => Agency.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class Agency {
  Agency({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.agencyRatio,
  });

  final int id;
  final String name;
  final String imageUrl;
  final num agencyRatio;

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      imageUrl: fixAvatarImage(json["imageUrl"] ?? ""),
      agencyRatio: json["agencyRatio"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "agencyRatio": agencyRatio,
      };
}
