import '../../../members/data/response/member_response.dart';

class TicketsResponse {
  TicketsResponse({
    required this.result,
  });

  final TicketsResult result;

  factory TicketsResponse.fromJson(Map<String, dynamic> json) {
    return TicketsResponse(
      result: TicketsResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class TicketsResult {
  TicketsResult({
    required this.items,
    required this.totalCount,
  });

  final List<Ticket> items;
  final int totalCount;

  factory TicketsResult.fromJson(Map<String, dynamic> json) {
    return TicketsResult(
      items: json["items"] == null
          ? []
          : List<Ticket>.from(json["items"]!.map((x) => Ticket.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class Ticket {
  Ticket({
    required this.id,
    required this.description,
    required this.memberId,
    required this.member,
    required this.institutionId,
    required this.date,
    required this.replies,
  });

  final int id;
  final String description;
  final num memberId;
  final Member member;
  final num institutionId;
  final DateTime? date;
  final List<Reply> replies;

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json["id"] ?? 0,
      description: json["description"] ?? "",
      memberId: json["memberId"] ?? 0,
      member: Member.fromJson(json["member"] ?? {}),
      institutionId: json["institutionId"] ?? 0,
      date: DateTime.tryParse(json["date"] ?? ""),
      replies: json["replies"] == null
          ? []
          : List<Reply>.from(json["replies"]!.map((x) => Reply.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "memberId": memberId,
        "member": member.toJson(),
        "institutionId": institutionId,
        "date": date?.toIso8601String(),
        "replies": replies.map((x) => x.toJson()).toList(),
      };
}

class Reply {
  Reply({
    required this.id,
    required this.reply,
    required this.adminId,
    required this.admin,
    required this.ticketId,
    required this.date,
  });

  final int id;
  final String reply;
  final num adminId;
  final Admin? admin;
  final num ticketId;
  final DateTime? date;

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      id: json["id"] ?? 0,
      reply: json["reply"] ?? "",
      adminId: json["adminId"] ?? 0,
      admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
      ticketId: json["ticketId"] ?? 0,
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "reply": reply,
        "adminId": adminId,
        "admin": admin?.toJson(),
        "ticketId": ticketId,
        "date": date?.toIso8601String(),
      };
}

class Admin {
  Admin({
    required this.userName,
    required this.fullName,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.avatar,
  });

  final String userName;
  final String fullName;
  final String name;
  final String surname;
  final String phoneNumber;
  final String avatar;

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      userName: json["userName"] ?? "",
      fullName: json["fullName"] ?? "",
      name: json["name"] ?? "",
      surname: json["surname"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      avatar: json["avatar"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "fullName": fullName,
        "name": name,
        "surname": surname,
        "phoneNumber": phoneNumber,
        "avatar": avatar,
      };
}
