part of 'map_controller_cubit.dart';

class MapControllerInitial {
  ///current point shown in map
  final LatLng? point;

  final LatLng initialPoint;

  ///latest point shown
  final LatLng? oldPoint;

  final double bearing;

  ///Camera Zoom
  final double zoom;

  ///all markers that set over map
  final Map<num, MyMarker> markers = {};

  ///all poly lines that drawn over Map,
  ///Key is hash is : end point hashing (for find and delete )
  final Map<num, Pair<List<LatLng>,Color>> polyLines = {};

  final int markerNotifier;
  final int polylineNotifier;

  final dynamic additional;

  MapControllerInitial({
    this.point,
    this.markerNotifier = 0,
    this.polylineNotifier = 0,
    this.zoom = 15,
    required this.initialPoint,
    this.oldPoint,
    this.additional,
    required this.bearing,
  });

  @override
  String toString() {
    return 'MapControllerInitial{point: $point'
        ', initialPoint: $initialPoint'
        ', oldPoint: $oldPoint'
        ', bearing: $bearing'
        ', zoom: $zoom'
        ', markers: $markers'
        ', polyLines: $polyLines'
        '}';
  }

  factory MapControllerInitial.initial() {
    return MapControllerInitial(
      initialPoint: LatLng(33.508082, 36.288161),
      bearing: 0,
    );
  }

  MapControllerInitial copyWith({
    LatLng? point,
    LatLng? initialPoint,
    LatLng? oldPoint,
    double? bearing,
    double? zoom,
    int? markerNotifier,
    int? polylineNotifier,
    dynamic additional,
  }) {
    return MapControllerInitial(
        point: point,
        initialPoint: initialPoint ?? this.initialPoint,
        markerNotifier: markerNotifier ?? this.markerNotifier,
        polylineNotifier: polylineNotifier ?? this.polylineNotifier,
        oldPoint: oldPoint ?? this.oldPoint,
        bearing: bearing ?? this.bearing,
        zoom: zoom ?? this.zoom,
        additional: additional ?? this.additional)
      ..markers.addAll(markers)
      ..polyLines.addAll(polyLines);
  }
}
