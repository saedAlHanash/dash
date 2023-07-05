class OsrmModel {
  OsrmModel({
    required this.code,
    required this.routes,
  });

  final String code;
  final List<Route> routes;

  factory OsrmModel.fromJson(Map<String, dynamic> json) {
    return OsrmModel(
      code: json["code"] ?? "",
      routes: json["routes"] == null
          ? []
          : List<Route>.from(json["routes"]!.map((x) => Route.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "routes": routes.map((x) => x.toJson()).toList(),
      };
}

class Route {
  Route({
    required this.geometry,
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
  });

  final String geometry;
  final String weightName;
  final num weight;
  final double duration;
  final double distance;

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      geometry: json["geometry"] ?? "",
      weightName: json["weight_name"] ?? "",
      weight: json["weight"] ?? 0,
      duration: json["duration"] ?? 0,
      distance: json["distance"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "geometry": geometry,
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
      };
}
