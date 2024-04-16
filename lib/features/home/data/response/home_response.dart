class HomeResponse {
  HomeResponse({
    required this.result,
  });

  final HomeResult result;

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      result: HomeResult.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class HomeResult {
  HomeResult({
    required this.statistics,
  });

  final Statistics statistics;

  factory HomeResult.fromJson(Map<String, dynamic> json) {
    return HomeResult(
      statistics: Statistics.fromJson(json["Statistics"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "Statistics": statistics.toJson(),
      };
}

class Statistics {
  Statistics({
    required this.clients,
    required this.drivers,
    required this.trips,
    required this.sharedTrips,
    required this.activeDrivers,
    required this.institutions,
    required this.agencies,
    required this.incoms,
    required this.awards,
    required this.requiredAmountFromComapnay,
  });

  final num clients;
  final num drivers;
  final num trips;
  final num sharedTrips;
  final num activeDrivers;
  final num institutions;
  final num agencies;
  final num incoms;
  final num awards;
  final num requiredAmountFromComapnay;

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      clients: json["Clients"] ?? 0,
      drivers: json["Drivers"] ?? 0,
      trips: json["Trips"] ?? 0,
      sharedTrips: json["SharedTrips"] ?? 0,
      activeDrivers: json["ActiveDrivers"] ?? 0,
      institutions: json["Institutions"] ?? 0,
      agencies: json["Agencies"] ?? 0,
      incoms: json["Incoms"] ?? 0,
      awards: json["Awards"] ?? 0,
      requiredAmountFromComapnay: json["RequiredAmountFromComapnay"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "Clients": clients,
        "Drivers": drivers,
        "Trips": trips,
        "SharedTrips": sharedTrips,
        "ActiveDrivers": activeDrivers,
        "Institutions": institutions,
        "Agencies": agencies,
        "Incoms": incoms,
        "Awards": awards,
        "RequiredAmountFromComapnay": requiredAmountFromComapnay,
      };
}
