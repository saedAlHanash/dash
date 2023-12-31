class OsmNameModel {
  OsmNameModel({
    required this.lat,
    required this.lon,
    required this.displayName,
    required this.address,
    required this.boundingbox,
  });

  final double lat;
  final double lon;
  final String displayName;
  final Address address;
  final List<String> boundingbox;

  factory OsmNameModel.fromJson(Map<String, dynamic> json) {
    return OsmNameModel(
      lat: double.tryParse(json["lat"]?.toString() ?? "0.0") ?? 0.0,
      lon: double.tryParse(json["lon"]?.toString() ?? "0.0") ?? 0.0,
      displayName: json["display_name"] ?? "",
      address: Address.fromJson(json["address"] ?? {}),
      boundingbox: json["boundingbox"] == null
          ? []
          : List<String>.from(json["boundingbox"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "display_name": displayName,
        "address": address.toJson(),
        "boundingbox": boundingbox.map((x) => x).toList(),
      };
}

class Address {
  Address({
    required this.shop,
    required this.road,
    required this.county,
    required this.stateDistrict,
    required this.state,
    required this.iso31662Lvl4,
    required this.country,
    required this.countryCode,
  });

  final String shop;
  final String road;
  final String county;
  final String stateDistrict;
  final String state;
  final String iso31662Lvl4;
  final String country;
  final String countryCode;

  String getName() {
    return '$road $county $stateDistrict $shop';
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      shop: json["shop"] ?? "",
      road: json["road"] ?? "",
      county: json["county"] ?? "",
      stateDistrict: json["state_district"] ?? "",
      state: json["state"] ?? "",
      iso31662Lvl4: json["ISO3166-2-lvl4"] ?? "",
      country: json["country"] ?? "",
      countryCode: json["country_code"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "shop": shop,
        "road": road,
        "county": county,
        "state_district": stateDistrict,
        "state": state,
        "ISO3166-2-lvl4": iso31662Lvl4,
        "country": country,
        "country_code": countryCode,
      };
}
