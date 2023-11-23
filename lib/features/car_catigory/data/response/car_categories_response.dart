// import 'package:qareeb_dash/core/strings/fix_url.dart';
//
// class CarCategoriesResponse {
//   CarCategoriesResponse({
//     required this.result,
//   });
//
//   final CarCategoriesResult result;
//
//   factory CarCategoriesResponse.fromJson(Map<String, dynamic> json) {
//     return CarCategoriesResponse(
//       result: CarCategoriesResult.fromJson(json["result"] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "result": result.toJson(),
//       };
// }
//
// class CarCategoriesResult {
//   CarCategoriesResult({
//     required this.totalCount,
//     required this.items,
//   });
//
//   final int totalCount;
//   final List<CarCategory> items;
//
//   factory CarCategoriesResult.fromJson(Map<String, dynamic> json) {
//     return CarCategoriesResult(
//       totalCount: json["totalCount"] ?? 0,
//       items: json["items"] == null
//           ? []
//           : List<CarCategory>.from(json["items"]!.map((x) => CarCategory.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "totalCount": totalCount,
//         "items": items.map((x) => x.toJson()).toList(),
//       };
// }
//
// class CarCategory {
//   CarCategory({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.price,
//     required this.driverRatio,
//     required this.nightKmOverCost,
//     required this.dayKmOverCost,
//     required this.sharedKmOverCost,
//     required this.nightSharedKmOverCost,
//     required this.sharedDriverRatio,
//     required this.minimumDayPrice,
//     required this.minimumNightPrice,
//     required this.companyLoyaltyRatio,
//     required this.sharedMinimumDistanceInMeters,
//     required this.normalOilRatio,
//     required this.normalGoldRatio,
//     required this.normalTiresRatio,
//     required this.normalGasRatio,
//     required this.sharedOilRatio,
//     required this.sharedGoldRatio,
//     required this.sharedTiresRatio,
//     required this.sharedGasRatio,
//     required this.priceVariant,
//     required this.seatNumber,
//     required this.planDriverRation,
//     required this.planKmCost,
//     required this.planMinimumCost,
//   });
//
//   final int id;
//   final String name;
//   final String imageUrl;
//   final num price;
//   final num driverRatio;
//   final num nightKmOverCost;
//   final num dayKmOverCost;
//   final num sharedKmOverCost;
//   final num nightSharedKmOverCost;
//   final num sharedDriverRatio;
//   final num minimumDayPrice;
//   final num minimumNightPrice;
//   final num companyLoyaltyRatio;
//   final num sharedMinimumDistanceInMeters;
//   final num normalOilRatio;
//   final num normalGoldRatio;
//   final num normalTiresRatio;
//   final num normalGasRatio;
//   final num sharedOilRatio;
//   final num sharedGoldRatio;
//   final num sharedTiresRatio;
//   final num sharedGasRatio;
//   final num priceVariant;
//   final num seatNumber;
//   final num planDriverRation;
//   final num planKmCost;
//   final num planMinimumCost;
//
//   factory CarCategory.fromJson(Map<String, dynamic> json) {
//     return CarCategory(
//       id: json["id"] ?? 0,
//       name: json["name"] ?? "",
//       imageUrl: fixAvatarImage(json["imageUrl"] ?? ""),
//       price: json["price"] ?? 0,
//       driverRatio: json["driverRatio"] ?? 0,
//       nightKmOverCost: json["nightKMOverCost"] ?? 0,
//       dayKmOverCost: json["dayKMOverCost"] ?? 0,
//       sharedKmOverCost: json["sharedKMOverCost"] ?? 0,
//       nightSharedKmOverCost: json["nightSharedKMOverCost"] ?? 0,
//       sharedDriverRatio: json["sharedDriverRatio"] ?? 0,
//       minimumDayPrice: json["minimumDayPrice"] ?? 0,
//       minimumNightPrice: json["minimumNightPrice"] ?? 0,
//       companyLoyaltyRatio: json["companyLoyaltyRatio"] ?? 0,
//       sharedMinimumDistanceInMeters: json["sharedMinimumDistanceInMeters"] ?? 0,
//       normalOilRatio: json["normalOilRatio"] ?? 0,
//       normalGoldRatio: json["normalGoldRatio"] ?? 0,
//       normalTiresRatio: json["normalTiresRatio"] ?? 0,
//       normalGasRatio: json["normalGasRatio"] ?? 0,
//       sharedOilRatio: json["sharedOilRatio"] ?? 0,
//       sharedGoldRatio: json["sharedGoldRatio"] ?? 0,
//       sharedTiresRatio: json["sharedTiresRatio"] ?? 0,
//       sharedGasRatio: json["sharedGasRatio"] ?? 0,
//       priceVariant: json["priceVariant"] ?? 0,
//       seatNumber: json["seatNumber"] ?? 0,
//       planDriverRation: json["planDriverRation"] ?? 0,
//       planKmCost: json["planKmCost"] ?? 0,
//       planMinimumCost: json["planMinimumCost"] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "imageUrl": imageUrl,
//         "price": price,
//         "driverRatio": driverRatio,
//         "nightKMOverCost": nightKmOverCost,
//         "dayKMOverCost": dayKmOverCost,
//         "sharedKMOverCost": sharedKmOverCost,
//         "nightSharedKMOverCost": nightSharedKmOverCost,
//         "sharedDriverRatio": sharedDriverRatio,
//         "minimumDayPrice": minimumDayPrice,
//         "minimumNightPrice": minimumNightPrice,
//         "companyLoyaltyRatio": companyLoyaltyRatio,
//         "sharedMinimumDistanceInMeters": sharedMinimumDistanceInMeters,
//         "normalOilRatio": normalOilRatio,
//         "normalGoldRatio": normalGoldRatio,
//         "normalTiresRatio": normalTiresRatio,
//         "normalGasRatio": normalGasRatio,
//         "sharedOilRatio": sharedOilRatio,
//         "sharedGoldRatio": sharedGoldRatio,
//         "sharedTiresRatio": sharedTiresRatio,
//         "sharedGasRatio": sharedGasRatio,
//         "priceVariant": priceVariant,
//         "seatNumber": seatNumber,
//         "planDriverRation": planDriverRation,
//         "planKmCost": planKmCost,
//         "planMinimumCost": planMinimumCost,
//       };
// }
