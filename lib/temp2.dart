import 'dart:math';
class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);
}

bool isPointInPolygon(LatLng point, List<LatLng> polygonVertices) {
  int intersectCount = 0;
  for (int i = 0; i < polygonVertices.length; i++) {
    final LatLng p1 = polygonVertices[i];
    final LatLng p2 = polygonVertices[(i + 1) % polygonVertices.length];
    if (rayIntersectsSegment(point, p1, p2)) {
      intersectCount++;
    }
  }
  return intersectCount % 2 == 1;
}

bool rayIntersectsSegment(LatLng point, LatLng p1, LatLng p2) {
  final double pointLat = point.latitude;
  final double pointLng = point.longitude;
  final double p1Lat = p1.latitude;
  final double p1Lng = p1.longitude;
  final double p2Lat = p2.latitude;
  final double p2Lng = p2.longitude;

  if (pointLat > min(p1Lat, p2Lat) &&
      pointLat <= max(p1Lat, p2Lat) &&
      pointLng <= max(p1Lng, p2Lng) &&
      p1Lat != p2Lat) {
    final double xIntersection = (pointLat - p1Lat) *
        (p2Lng - p1Lng) /
        (p2Lat - p1Lat) +
        p1Lng;
    if (p1Lng == p2Lng || pointLng <= xIntersection) {
      return true;
    }
  }
  return false;
}