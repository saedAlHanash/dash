import 'package:qareeb_models/global.dart';

class NotificationRequest {
  UserType? userType;
  List<int>? areaIds;
  int? governorateId;
  List<int>? ids;

  String? title;
  String? body;

  NotificationRequest({
    this.userType,
    this.areaIds,
    this.governorateId,
    this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "body": body,
      "filter": {
        if (userType != null) "userType": userType?.index,
        if (governorateId != null) "governorateId": governorateId,
        if (areaIds != null) "areaIds": areaIds?.map((x) => x).toList(),
        if (ids != null) "ids": ids?.map((x) => x).toList(),
      },
    };
  }

  Map<String, dynamic> toMapBody() {
    return {
      'title': title,
      'body': body,
    };
  }

  void clearFilter() {
    userType = null;
    governorateId = null;
    areaIds = null;
    ids = null;
  }
}

class Product {
  Product({
    required this.title,
    required this.body,
    required this.filter,
  });

  final String title;
  final String body;
  final Filter? filter;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json["title"] ?? "",
      body: json["body"] ?? "",
      filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "filter": filter?.toJson(),
      };
}

class Filter {
  Filter({
    required this.userType,
    required this.governorateId,
    required this.areaIds,
    required this.ids,
  });

  final String userType;
  final num governorateId;
  final List<num> areaIds;
  final List<num> ids;

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      userType: json["userType"] ?? "",
      governorateId: json["governorateId"] ?? 0,
      areaIds:
          json["areaIds"] == null ? [] : List<num>.from(json["areaIds"]!.map((x) => x)),
      ids: json["ids"] == null ? [] : List<num>.from(json["ids"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "userType": userType,
        "governorateId": governorateId,
        "areaIds": areaIds.map((x) => x).toList(),
        "ids": ids.map((x) => x).toList(),
      };
}
