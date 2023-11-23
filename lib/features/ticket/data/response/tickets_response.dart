

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
    required this.userId,
    required this.user,
    required this.institutionId,
    required this.date,
    required this.replies,
  });

  final int id;
  final String description;
  final num userId;
  final User user;
  final num institutionId;
  final DateTime? date;
  final List<Reply> replies;

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json["id"] ?? 0,
      description: json["description"] ?? "",
      userId: json["userId"] ?? 0,
      user: User.fromJson(json["user"] ?? {}),
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
        "userId": userId,
        "user": user.toJson(),
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
  final User? admin;
  final num ticketId;
  final DateTime? date;

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      id: json["id"] ?? 0,
      reply: json["reply"] ?? "",
      adminId: json["adminId"] ?? 0,
      admin: json["admin"] == null ? null : User.fromJson(json["admin"]),
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

class User {
  User({
    required this.userName,
    required this.fullName,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.avatar,
    required this.emergencyPhone,
    required this.userType,
  });

  final String userName;
  final String fullName;
  final String name;
  final String surname;
  final String phoneNumber;
  final String avatar;
  final String emergencyPhone;
  final String userType;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json["userName"] ?? "",
      fullName: json["fullName"] ?? "",
      name: json["name"] ?? "",
      surname: json["surname"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      avatar: json["avatar"] ?? "",
      emergencyPhone: json["emergencyPhone"] ?? "",
      userType: json["userType"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "fullName": fullName,
        "name": name,
        "surname": surname,
        "phoneNumber": phoneNumber,
        "avatar": avatar,
        "emergencyPhone": emergencyPhone,
        "userType": userType,
      };
}
