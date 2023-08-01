import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:qareeb_dash/core/strings/enum_manager.dart';
import 'package:qareeb_dash/features/points/data/response/points_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../services/osrm/data/response/osrm_model.dart';
import '../../../shared_trip/data/response/shared_trip.dart';
import '../../../trip/data/response/trip_response.dart';
import '../../data/models/my_marker.dart';

part 'map_controller_state.dart';

const _singleMarkerKey = -5622;

class MapControllerCubit extends Cubit<MapControllerInitial> {
  MapControllerCubit() : super(MapControllerInitial.initial());

  var mapHeight = 640.0;
  var mapWidth = 360.0;

  final network = sl<NetworkInfo>();

  void addMarker({required MyMarker marker}) {
    state.markers[marker.key ?? marker.point.hashCode] = marker;
    emit(state.copyWith(markerNotifier: state.markerNotifier + 1));
  }

  void addSingleMarker({required MyMarker? marker, bool? moveTo}) {
    if (marker == null) {
      state.markers.remove(_singleMarkerKey);
    } else {
      state.markers[_singleMarkerKey] = marker;
      if (moveTo ?? false) movingCamera(point: marker.point);
    }

    emit(state.copyWith(markerNotifier: state.markerNotifier + 1));
  }

  void movingCamera({required LatLng point, double? zoom}) {
    emit(state.copyWith(point: point, zoom: zoom));
  }

  void addMarkers({required List<MyMarker> marker, bool update = true}) {
    for (var e in marker) {
      state.markers[e.key ?? e.point.hashCode] = e;
    }
    if (update) emit(state.copyWith(markerNotifier: state.markerNotifier + 1));
  }

  void addPath({required SharedTrip trip}) {
    addMarkers(marker: trip.path.getMarkers(), update: false);
    addEncodedPolyLines(myPolyLines: trip.path.getPolyLines(), update: false);
    var f = trip.path.getPoints();
    emit(state.copyWith(
        zoom: getZoomLevel(f.first, f.last, mapWidth),
        point: trip.path.startPoint,
        additional: trip,
        markerNotifier: state.markerNotifier + 1,
        polylineNotifier: state.polylineNotifier + 1));
  }

  void addTrip({required TripResult trip}) {
    addMarkers(marker: trip.getMarkers);
    addPolyLine(start: trip.startPoint, end: trip.endPoint);
    emit(state.copyWith(
      zoom: getZoomLevel(trip.currentLocation.latLng, trip.destination.latLng, mapWidth),
      point: trip.startPoint,
      markerNotifier: state.markerNotifier + 1,
      polylineNotifier: state.polylineNotifier + 1,
    ));
  }

  void removeMarker({LatLng? point, int? key}) {
    if (point == null && key == null) return;

    state.markers.remove(key ?? point.hashCode);

    emit(state.copyWith(markerNotifier: state.markerNotifier + 1));
  }

  void removeMarkers({List<LatLng>? points, List<int>? keys}) {
    if (points == null && keys == null) return;

    if (points != null) {
      for (var e in points) {
        state.markers.remove(e.hashCode);
      }
    } else {
      for (var e in keys!) {
        state.markers.remove(e);
      }
    }

    emit(state.copyWith(markerNotifier: state.markerNotifier + 1));
  }

  Future<void> addPolyLine({
    required LatLng? start,
    required LatLng end,
    int? key,
  }) async {
    if (start == null) return;

    final pair = await _getRoutePointApi(start: start, end: end);

    if (pair.first != null) {
      var list = decodePolyline(pair.first!.routes.first.geometry).unpackPolyline();
      state.polyLines[key ?? end.hashCode] = Pair(list, Colors.black);
      emit(state.copyWith(polylineNotifier: state.polylineNotifier + 1));
    }
  }

  void addEncodedPolyLine({required MyPolyLine myPolyLine}) {
    if (myPolyLine.key == null && myPolyLine.endPoint == null) return;

    var list = decodePolyline(myPolyLine.encodedPolyLine).unpackPolyline();
    state.polyLines[myPolyLine.key ?? myPolyLine.endPoint.hashCode] =
        Pair(list, myPolyLine.color ?? Colors.black);

    emit(state.copyWith(polylineNotifier: state.polylineNotifier + 1));
  }

  void addEncodedPolyLines({required List<MyPolyLine> myPolyLines, bool update = true}) {
    state.polyLines.clear();
    for (var e in myPolyLines) {
      if (e.endPoint != null) {
        addMarker(
            marker: MyMarker(
          point: e.endPoint!.getLatLng,
          type: MyMarkerType.point,
          item: e.endPoint,
        ));
      }
      if (e.key == null && e.endPoint == null) return;
      var list = decodePolyline(e.encodedPolyLine).unpackPolyline();
      state.polyLines[e.key ?? e.endPoint.hashCode] = Pair(list, e.color ?? Colors.black);
    }
    if (update) emit(state.copyWith(polylineNotifier: state.polylineNotifier + 1));
  }

  Future<Pair<OsrmModel?, String?>> _getRoutePointApi(
      {required LatLng start, required LatLng end}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
          url: OsrmUrl.getRoutePoints,
          hostName: OsrmUrl.hostName,
          path: '${start.longitude},${start.latitude};'
              '${end.longitude},${end.latitude}');

      if (response.statusCode == 200) {
        return Pair(OsrmModel.fromJson(jsonDecode(response.body)), null);
      } else {
        return Pair(null, 'error');
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }

  void removePolyLine({LatLng? endPoint, int? key}) {
    if (endPoint == null && key == null) return;
    state.polyLines.remove(key ?? endPoint.hashCode);
    emit(state.copyWith(polylineNotifier: state.polylineNotifier + 1));
  }

  void addAllPoints({required List<TripPoint> points}) {
    state.markers.clear();
    addMarkers(
        marker: points.mapIndexed(
      (i, e) {
        return MyMarker(point: e.getLatLng, type: MyMarkerType.point, key: e.id, item: e);
      },
    ).toList());
  }

  void updateMarkersWithZoom(double zoom) {
    loggerObject.v(zoom);
    emit(state.copyWith(markerNotifier: state.markerNotifier + 1, mapZoom: zoom));
  }
}

double distanceBetween(LatLng point1, LatLng point2) {
  const p = 0.017453292519943295;
  final a = 0.5 -
      cos((point2.latitude - point1.latitude) * p) / 2 +
      cos(point1.latitude * p) *
          cos(point2.latitude * p) *
          (1 - cos((point2.longitude - point1.longitude) * p)) /
          2;
  return 12742 * asin(sqrt(a));
}

double getZoomLevel(LatLng point1, LatLng point2, double width) {
  final distance = distanceBetween(point1, point2) * 1000;
  final zoomScale = distance / (width * 0.6);
  final zoom =
      log(40075016.686 * cos(point1.latitude * pi / 180) / (256 * zoomScale)) / log(2);
  return zoom;
}
