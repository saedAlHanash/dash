import 'package:qareeb_models/trip_path/data/models/trip_path.dart';

class TempTripsResponse {
  TempTripsResponse({
    required this.result,
  });

  final List<TripPath> result;

  factory TempTripsResponse.fromJson(Map<String, dynamic> json) {
    return TempTripsResponse(
      result: json["result"] == null
          ? []
          : List<TripPath>.from(json["result"]!.map((x) => TripPath.fromJson(x))),
    );
  }
}
