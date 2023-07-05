
import '../../../trip/data/response/trip_response.dart';

class TripsResponse {
  TripsResponse({
    required this.result,
  });

  final List<TripResult> result;

  factory TripsResponse.fromJson(Map<String, dynamic> json) {
    return TripsResponse(
      result: json['result'] == null
          ? []
          : List<TripResult>.from(
              json['result']!.map((x) => TripResult.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'result': result.map((x) => x.toJson()).toList(),
      };
}
