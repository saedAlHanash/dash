import 'package:latlong2/latlong.dart';
import 'package:qareeb_models/points/data/response/points_edge_response.dart';

import '../response/points_edge_response.dart';

class CreateEdgeRequest {
  CreateEdgeRequest({
     this.startPointLatLng,
     this.endPointLatLng,
    this.id,
    this.startPointId,
    this.endPointId,
    this.distance,
    this.price,
    this.steps,
    this.name,
    this.arName,
  });

  int? id;
  num? startPointId;
  LatLng? startPointLatLng;
  num? endPointId;
  LatLng? endPointLatLng;
  num? distance;
  num? price;

  String? steps;
  String? name = '';
  String? arName = '';

  factory CreateEdgeRequest.fromJson(Map<String, dynamic> json) {
    return CreateEdgeRequest(
      id: json["id"] ?? 0,
      startPointId: json["startPointId"] ?? 0,
      endPointId: json["endPointId"] ?? 0,
      distance: json["distance"] ?? 0,
      price: json["price"] ?? 0,
      steps: json["steps"] ?? "",
      name: json["name"] ?? "",
      arName: json["arName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "startPointId": startPointId,
        "endPointId": endPointId,
        "distance": distance,
        "price": price,
        "steps": steps,
        "name": name,
        "arName": arName,
      };

  void initFromEdge(PointsEdgeResult result) {
    id = result.id;
    startPointId = result.startPointId;
    endPointId = result.endPointId;
    distance = result.distance;
    price = result.price;
    steps = result.steps;
    name = result.name;
    arName = result.arName;
  }
}
