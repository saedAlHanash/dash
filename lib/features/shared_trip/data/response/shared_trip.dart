import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/shared_trip/data/response/shared_trip.dart';

import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../services/trip_path/data/models/trip_path.dart';
import '../../../drivers/data/response/drivers_response.dart';
import 'package:qareeb_models/points/data/response/points_response.dart';

class SharedTripsResponse {
  SharedTripsResponse({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<SharedTrip> items;

  factory SharedTripsResponse.fromJson(Map<String, dynamic> json) {
    return SharedTripsResponse(
      totalCount: json['result']["totalCount"] ?? 0,
      items: json['result']["items"] == null
          ? []
          : List<SharedTrip>.from(json['result']["items"]!.map((x) => SharedTrip.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "items": items.map((x) => x.toJson()).toList(),
  };
}
