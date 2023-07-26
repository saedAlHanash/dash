import 'package:qareeb_dash/core/strings/fix_url.dart';

class MembersResponse {
  MembersResponse({
    required this.result,
  });

  final MembersResult result;

  factory MembersResponse.fromJson(Map<String, dynamic> json) {
    return MembersResponse(
      result: MembersResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class MembersResult {
  MembersResult({
    required this.items,
    required this.totalCount,
  });

  final List<Member> items;
  int totalCount;

  factory MembersResult.fromJson(Map<String, dynamic> json) {
    return MembersResult(
      items: json["items"] == null
          ? []
          : List<Member>.from(json["items"]!.map((x) => Member.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class Member {
  Member({
    required this.id,
    required this.fullName,
    required this.imageUrl,
    required this.address,
    required this.late,
    required this.longe,
    required this.userName,
    required this.password,
    required this.institutionId,
    required this.subscriptions,
  });

  final int id;
  final String fullName;
  final String imageUrl;
  final String address;
  final double late;
  final double longe;
  final String userName;
  final String password;
  final num institutionId;
  final List<Subscription> subscriptions;

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json["id"] ?? 0,
      fullName: json["fullName"] ?? "",
      imageUrl: fixAvatarImage(json["imageUrl"] ?? ""),
      address: json["address"] ?? "",
      late: json["late"] ?? 0,
      longe: json["longe"] ?? 0,
      userName: json["userName"] ?? "",
      password: json["password"] ?? "",
      institutionId: json["institutionId"] ?? 0,
      subscriptions: json["subscriptions"] == null
          ? []
          : List<Subscription>.from(
              json["subscriptions"]!.map((x) => Subscription.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "imageUrl": imageUrl,
        "address": address,
        "late": late,
        "longe": longe,
        "userName": userName,
        "password": password,
        "institutionId": institutionId,
        "subscriptions": subscriptions.map((x) => x.toJson()).toList(),
      };
}

class Subscription {
  Subscription({
    required this.id,
    required this.institutionId,
    required this.memberId,
    required this.supscriptionDate,
    required this.expirationDate,
    required this.isActive,
  });

  final int id;
  final num institutionId;
  final num memberId;
  final DateTime? supscriptionDate;
  final DateTime? expirationDate;
  final bool isActive;

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json["id"] ?? 0,
      institutionId: json["institutionId"] ?? 0,
      memberId: json["memberId"] ?? 0,
      supscriptionDate: DateTime.tryParse(json["supscriptionDate"] ?? ""),
      expirationDate: DateTime.tryParse(json["expirationDate"] ?? ""),
      isActive: json["isActive"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "institutionId": institutionId,
        "memberId": memberId,
        "supscriptionDate": supscriptionDate?.toIso8601String(),
        "expirationDate": expirationDate?.toIso8601String(),
        "isActive": isActive,
      };
}
