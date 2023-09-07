
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel {
  LocationModel({
    required this.lng,
    required this.lat,
  });

  double lng;
  double lat;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lng: json["longitud"] ?? 0.0,
      lat: json["latitud"] ?? 0.0,
    );
  }

  LatLng get latLng => LatLng(lat, lng);

  factory LocationModel.fromLatLng(LatLng latLng) =>
      LocationModel(lng: latLng.longitude, lat: latLng.latitude);

  factory LocationModel.latLng(LatLng latLng) =>
      LocationModel(lng: latLng.longitude, lat: latLng.latitude);

  Map<String, dynamic> toJson() => {"longitud": lng, "latitud": lat};

}
