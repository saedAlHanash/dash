class MessagesResponse {
  MessagesResponse({
    required this.result,
  });

  final MessagesResult result;

  factory MessagesResponse.fromJson(Map<String, dynamic> json) {
    return MessagesResponse(
      result: MessagesResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class MessagesResult {
  MessagesResult({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<MessageModel> items;

  factory MessagesResult.fromJson(Map<String, dynamic> json) {
    return MessagesResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<MessageModel>.from(json["items"]!.map((x) => MessageModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class MessageModel {
  MessageModel({
    required this.senderId,
    required this.senderName,
    required this.senderType,
    required this.reciverId,
    required this.reciverName,
    required this.reciverType,
    required this.tilte,
    required this.body,
    required this.id,
  });

  final num senderId;
  final String senderName;
  final String senderType;
  final num reciverId;
  final String reciverName;
  final String reciverType;
  final String tilte;
  final String body;
  final int id;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json["senderId"] ?? 0,
      senderName: json["senderName"] ?? "",
      senderType: json["senderType"] ?? "",
      reciverId: json["reciverId"] ?? 0,
      reciverName: json["reciverName"] ?? "",
      reciverType: json["reciverType"] ?? "",
      tilte: json["tilte"] ?? "",
      body: json["body"] ?? "",
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "senderName": senderName,
        "senderType": senderType,
        "reciverId": reciverId,
        "reciverName": reciverName,
        "reciverType": reciverType,
        "tilte": tilte,
        "body": body,
        "id": id,
      };
}
