class RolesResponse {
  RolesResponse({
    required this.result,
  });

  final RoleResult result;

  factory RolesResponse.fromJson(Map<String, dynamic> json) {
    return RolesResponse(
      result: RoleResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class RoleResult {
  RoleResult({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<Role> items;

  factory RoleResult.fromJson(Map<String, dynamic> json) {
    return RoleResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<Role>.from(json["items"]!.map((x) => Role.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class Role {
  Role({
    required this.name,
    required this.displayName,
    required this.normalizedName,
    required this.description,
    required this.lastModificationTime,
    required this.creationTime,
    required this.lastModifierUserId,
    required this.grantedPermissions,
    required this.id,
  });

  final String name;
  final String displayName;
  final String normalizedName;
  final String description;
  final DateTime? lastModificationTime;
  final DateTime? creationTime;
  final num lastModifierUserId;
  final List<String> grantedPermissions;
  final int id;

  String get getP {
    var t = '';
    for (var e in grantedPermissions) {
      t += '$e\n';
    }
    return t;
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      name: json["name"] ?? "",
      displayName: json["displayName"] ?? "",
      normalizedName: json["normalizedName"] ?? "",
      description: json["description"] ?? "",
      lastModificationTime: DateTime.tryParse(json["lastModificationTime"] ?? ""),
      creationTime: DateTime.tryParse(json["creationTime"] ?? ""),
      lastModifierUserId: json["lastModifierUserId"] ?? 0,
      grantedPermissions: json["grantedPermissions"] == null
          ? []
          : List<String>.from(json["grantedPermissions"]!.map((x) => x)),
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "displayName": displayName,
        "normalizedName": normalizedName,
        "description": description,
        "lastModificationTime": lastModificationTime?.toIso8601String(),
        "creationTime": creationTime?.toIso8601String(),
        "lastModifierUserId": lastModifierUserId,
        "grantedPermissions": grantedPermissions.map((x) => x).toList(),
        "id": id,
      };
}
