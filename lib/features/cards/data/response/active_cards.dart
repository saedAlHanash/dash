

import 'cards_user_response.dart';

class ActiveCards {
  ActiveCards({
    required this.items,
    required this.totalCount,
  });

  final List<ActiveCard> items;
  final num totalCount;

  factory ActiveCards.fromJson(Map<String, dynamic> json) {
    return ActiveCards(
      items: json["items"] == null
          ? []
          : List<ActiveCard>.from(json["items"]!.map((x) => ActiveCard.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class ActiveCard {
  ActiveCard({
    required this.id,
    required this.cardId,
    required this.card,
    required this.userId,
    required this.user,
    required this.date,
    required this.address,
  });

  final int id;
  final num cardId;
  final UserCard card;
  final num userId;
  final User user;
  final DateTime? date;
  final String address;

  factory ActiveCard.fromJson(Map<String, dynamic> json) {
    return ActiveCard(
      id: json["id"] ?? 0,
      cardId: json["cardId"] ?? 0,
      card: UserCard.fromJson(json["card"] ?? {}),
      userId: json["userId"] ?? 0,
      user: User.fromJson(json["user"] ?? {}),
      date: DateTime.tryParse(json["date"] ?? ""),
      address: json["address"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cardId": cardId,
        "card": card.toJson(),
        "userId": userId,
        "user": user.toJson(),
        "date": date?.toIso8601String(),
        "address": address,
      };
}

class User {
  User({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.avatar,
    required this.emergencyPhone,
    required this.userType,
    required this.accountBalance,
  });

  final int id;
  final String userName;
  final String fullName;
  final String name;
  final String surname;
  final String phoneNumber;
  final String avatar;
  final String emergencyPhone;
  final String userType;
  final num accountBalance;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0,
      userName: json["userName"] ?? "",
      fullName: json["fullName"] ?? "",
      name: json["name"] ?? "",
      surname: json["surname"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      avatar: json["avatar"] ?? "",
      emergencyPhone: json["emergencyPhone"] ?? "",
      userType: json["userType"] ?? "",
      accountBalance: json["accountBalance"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "fullName": fullName,
        "name": name,
        "surname": surname,
        "phoneNumber": phoneNumber,
        "avatar": avatar,
        "emergencyPhone": emergencyPhone,
        "userType": userType,
        "accountBalance": accountBalance,
      };
}
