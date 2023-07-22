class PermissionsResponse {
  PermissionsResponse({
    required this.result,
  });

  final PermissionsResult result;

  factory PermissionsResponse.fromJson(Map<String, dynamic> json) {
    return PermissionsResponse(
      result: PermissionsResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class PermissionsResult {
  PermissionsResult({
    required this.items,
  });

  final List<Permission> items;

  factory PermissionsResult.fromJson(Map<String, dynamic> json) {
    return PermissionsResult(
      items: json["items"] == null
          ? []
          : List<Permission>.from(json["items"]!.map((x) => Permission.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class Permission {
  Permission({
    required this.name,
    required this.displayName,
    required this.description,
    required this.id,
  });

  final String name;
  final String displayName;
  final String description;
  final int id;

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      name: json["name"] ?? "",
      displayName: json["displayName"] ?? "",
      description: json["description"] ?? "",
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "displayName": displayName,
        "description": description,
        "id": id,
      };
}
