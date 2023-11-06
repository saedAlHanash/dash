class HomeResponse {
  HomeResponse({
    required this.result,
  });

  final HomeResult result;

  factory HomeResponse.fromJson(Map<String, dynamic> json){
    return HomeResponse(
      result: HomeResult.fromJson(json["result"]??{}),
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

  factory HomeResult.fromJson(Map<String, dynamic> json){
    return HomeResult(
      statistics: Statistics.fromJson(json["statistics"]??{}),
    );
  }

  Map<String, dynamic> toJson() => {
    "statistics": statistics.toJson(),
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

  factory Statistics.fromJson(Map<String, dynamic> json){
    return Statistics(
      clients: json["clients"] ?? 0,
      drivers: json["drivers"] ?? 0,
      trips: json["trips"] ?? 0,
      sharedTrips: json["sharedTrips"] ?? 0,
      activeDrivers: json["activeDrivers"] ?? 0,
      institutions: json["institutions"] ?? 0,
      agencies: json["agencies"] ?? 0,
      incoms: json["incoms"] ?? 0,
      awards: json["awards"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "clients": clients,
    "drivers": drivers,
    "trips": trips,
    "sharedTrips": sharedTrips,
    "activeDrivers": activeDrivers,
    "institutions": institutions,
    "agencies": agencies,
    "incoms": incoms,
    "awards": awards,
  };

}
