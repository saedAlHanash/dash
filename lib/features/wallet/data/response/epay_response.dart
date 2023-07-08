import '../../../../core/strings/fix_url.dart';

class EpayResponse {
  EpayResponse({
    required this.result,
  });

  final EpayResult result;

  factory EpayResponse.fromJson(Map<String, dynamic> json) {
    return EpayResponse(
      result: EpayResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class EpayResult {
  EpayResult({
    required this.items,
    required this.totalCount,
  });

  final List<EpayItem> items;
  final num totalCount;

  factory EpayResult.fromJson(Map<String, dynamic> json) {
    return EpayResult(
      items: json["items"] == null
          ? []
          : List<EpayItem>.from(json["items"]!.map((x) => EpayItem.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class EpayItem {
  EpayItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.phone,
    required this.link,
    required this.file,
    required this.creationTime,
    required this.creatorUserId,
    required this.isActive,
    required this.isWebView,
  });

  final int id;
  final String name;
  final String imageUrl;
  final String email;
  final String phone;
  final String link;
  final String file;
  final bool isWebView;
  final String creationTime;
  final String creatorUserId;
   bool isActive;

  factory EpayItem.fromJson(Map<String, dynamic> json) {
    return EpayItem(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      isWebView: json["isWebView"] ?? false,
      imageUrl: fixAvatarImage(json["imageUrl"]),
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      link: json["link"] ?? "",
      file: json["file"] ?? "",
      creationTime: json["creationTime"] ?? "",
      creatorUserId: json["creatorUserId"] ?? "",
      isActive: json["isActive"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "email": email,
        "phone": phone,
        "link": link,
        "file": file,
        "isWebView": isWebView,
        "creationTime": creationTime,
        "creatorUserId": creatorUserId,
        "isActive": isActive,
      };
}
