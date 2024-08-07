import 'package:qareeb_models/global.dart';

import '../../../../core/strings/fix_url.dart';

class Cards {
  Cards({
    required this.items,
    required this.totalCount,
  });

  final List<UserCard> items;
  final num totalCount;

  factory Cards.fromJson(Map<String, dynamic> json) {
    return Cards(
      items: json["items"] == null
          ? []
          : List<UserCard>.from(json["items"]!.map((x) => UserCard.fromJson(x))),
      totalCount: json["totalCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x?.toJson()).toList(),
        "totalCount": totalCount,
      };
}

class UserCard {
  UserCard({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.adress,
    required this.maxActivationCount,
    required this.image,
  });

  final int id;
  final String name;
  final String description;
  final num price;
  final String adress;
  final num maxActivationCount;
  final String image;

  String? location;

  factory UserCard.fromJson(Map<String, dynamic> json) {
    return UserCard(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      price: json["price"] ?? 0,
      adress: json["adress"] ?? "",
      maxActivationCount: json["maxActivationCount"] ?? 0,
      image: FixUrl.fixAvatarImage(json["image"].toString() ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "adress": adress,
        "maxActivationCount": maxActivationCount,
        "image": image,
      };
}
