import '../../../../core/strings/fix_url.dart';

class CarsType {
  CarsType({
    this.isSelected,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.seatsNumber,
    required this.price,

    // required this.driverRatio,
    // required this.nightPeriodStart,
    // required this.nightPeriodEnd,
    // required this.minimumFareNight,
    // required this.flagDownFeeNight,
    // required this.priceMinNight,
    // required this.priceKmNight,
    // required this.minimumFareDay,
    // required this.flagDownFeeDay,
    // required this.priceMinDay,
    // required this.priceKmDay,
  });

  final int id;
  final String name;
  final String imageUrl;
  final num seatsNumber;
  final num price;
  late bool? isSelected;

  // final num driverRatio;
  // final Map<String, num> nightPeriodStart;
  // final Map<String, num> nightPeriodEnd;
  // final num minimumFareNight;
  // final num flagDownFeeNight;
  // final num priceMinNight;
  // final num priceKmNight;
  // final num minimumFareDay;
  // final num flagDownFeeDay;
  // final num priceMinDay;
  // final num priceKmDay;

  factory CarsType.fromJson(Map<String, dynamic> json) {
    return CarsType(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      imageUrl: fixAvatarImage(json["imageUrl"]),
      seatsNumber: json["seatsNumber"] ?? 0,
      price: json["price"] ?? 0,
      // driverRatio: json["driverRatio"] ?? 0,
      // nightPeriodStart: Map.from(json["nightPeriod_start"]).map((k, v) => MapEntry<String, num>(k, v)),
      // nightPeriodEnd: Map.from(json["nightPeriod_End"]).map((k, v) => MapEntry<String, num>(k, v)),
      // minimumFareNight: json["minimumFare_Night"] ?? 0,
      // flagDownFeeNight: json["flag_downFee_Night"] ?? 0,
      // priceMinNight: json["price_Min_Night"] ?? 0,
      // priceKmNight: json["price_KM_Night"] ?? 0,
      // minimumFareDay: json["minimumFare_DAY"] ?? 0,
      // flagDownFeeDay: json["flag_downFee_DAY"] ?? 0,
      // priceMinDay: json["price_Min_DAY"] ?? 0,
      // priceKmDay: json["price_KM_DAY"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imageUrl": imageUrl,
    "seatsNumber": seatsNumber,
    "price": price,
    // "driverRatio": driverRatio,
    // "nightPeriod_start": Map.from(nightPeriodStart)
    //     .map((k, v) => MapEntry<String, dynamic>(k, v)),
    // "nightPeriod_End": Map.from(nightPeriodEnd)
    //     .map((k, v) => MapEntry<String, dynamic>(k, v)),
    // "minimumFare_Night": minimumFareNight,
    // "flag_downFee_Night": flagDownFeeNight,
    // "price_Min_Night": priceMinNight,
    // "price_KM_Night": priceKmNight,
    // "minimumFare_DAY": minimumFareDay,
    // "flag_downFee_DAY": flagDownFeeDay,
    // "price_Min_DAY": priceMinDay,
    // "price_KM_DAY": priceKmDay,
  };
}
