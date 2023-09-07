import 'package:qareeb_dash/core/strings/fix_url.dart';

class CarCategoriesResponse {
  CarCategoriesResponse({
    required this.result,
  });

  final CarCategoriesResult result;

  factory CarCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CarCategoriesResponse(
      result: CarCategoriesResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class CarCategoriesResult {
  CarCategoriesResult({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<CarCategory> items;

  factory CarCategoriesResult.fromJson(Map<String, dynamic> json) {
    return CarCategoriesResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<CarCategory>.from(json["items"]!.map((x) => CarCategory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class CarCategory {
  CarCategory({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.driverRatio,
    required this.nightKmOverCost,
    required this.dayKmOverCost,
    required this.sharedKmOverCost,
    required this.nightSharedKmOverCost,
    required this.sharedDriverRatio,
    required this.minimumDayPrice,
    required this.minimumNightPrice,
    required this.companyLoyaltyRatio,
    required this.id,
    required this.normalOilRatio,
    required this.normalGoldRatio,
    required this.normalTiresRatio,
    required this.sharedOilRatio,
    required this.sharedGoldRatio,
    required this.sharedTiresRatio,
    required this.priceVariant,
  });

  final String name;
  final String imageUrl;
  final num price;
  final num driverRatio;
  final num nightKmOverCost;
  final num dayKmOverCost;
  final num sharedKmOverCost;
  final num nightSharedKmOverCost;
  final num sharedDriverRatio;
  final num minimumDayPrice;
  final num minimumNightPrice;
  final num companyLoyaltyRatio;
  final int id;
  final num normalOilRatio;
  final num normalGoldRatio;
  final num normalTiresRatio;
  final num sharedOilRatio;
  final num sharedGoldRatio;
  final num sharedTiresRatio;
  final num priceVariant;

  factory CarCategory.fromJson(Map<String, dynamic> json) {
    return CarCategory(
      name: json["name"] ?? "",
      imageUrl: fixAvatarImage(json["imageUrl"] ?? ""),
      price: json["price"] ?? 0,
      driverRatio: json["driverRatio"] ?? 0,
      nightKmOverCost: json["nightKMOverCost"] ?? 0,
      dayKmOverCost: json["dayKMOverCost"] ?? 0,
      sharedKmOverCost: json["sharedKMOverCost"] ?? 0,
      nightSharedKmOverCost: json["nightSharedKMOverCost"] ?? 0,
      sharedDriverRatio: json["sharedDriverRatio"] ?? 0,
      minimumDayPrice: json["minimumDayPrice"] ?? 0,
      minimumNightPrice: json["minimumNightPrice"] ?? 0,
      companyLoyaltyRatio: json["companyLoyaltyRatio"] ?? 0,
      id: json["id"] ?? 0,
      normalOilRatio: json["normalOilRatio"] ?? 0.0,
      normalGoldRatio: json["normalGoldRatio"] ?? 0.0,
      normalTiresRatio: json["normalTiresRatio"] ?? 0.0,
      sharedOilRatio: json["sharedOilRatio"] ?? 0.0,
      sharedGoldRatio: json["sharedGoldRatio"] ?? 0.0,
      sharedTiresRatio: json["sharedTiresRatio"] ?? 0.0,
      priceVariant: json["priceVariant"] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "price": price,
        "driverRatio": driverRatio,
        "nightKMOverCost": nightKmOverCost,
        "dayKMOverCost": dayKmOverCost,
        "sharedKMOverCost": sharedKmOverCost,
        "nightSharedKMOverCost": nightSharedKmOverCost,
        "sharedDriverRatio": sharedDriverRatio,
        "minimumDayPrice": minimumDayPrice,
        "minimumNightPrice": minimumNightPrice,
        "companyLoyaltyRatio": companyLoyaltyRatio,
        "id": id,
        "normalOilRatio": normalOilRatio,
        "normalGoldRatio": normalGoldRatio,
        "normalTiresRatio": normalTiresRatio,
        "sharedOilRatio": sharedOilRatio,
        "sharedGoldRatio": sharedGoldRatio,
        "sharedTiresRatio": sharedTiresRatio,
        "priceVariant": priceVariant,
      };
}
