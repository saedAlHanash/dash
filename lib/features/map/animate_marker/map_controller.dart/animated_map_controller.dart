import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';

class AnimatedMapController extends MapControllerImpl {
  final TickerProvider vsync;
  AnimatedMapController({
    required this.vsync,
  });

  late AnimationController _animationController =
      AnimationController(duration: const Duration(milliseconds: 300), vsync: vsync);

  Future animatedTo(
    LatLng destLocation, {
    double? destZoom,
    double? destBearing,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.linear,
  }) async {
    try {
      final latTween =
          Tween<double>(begin: center.latitude, end: destLocation.latitude);
      final lngTween =
          Tween<double>(begin: center.longitude, end: destLocation.longitude);
      final zoomTween = Tween<double>(begin: zoom, end: destZoom ?? zoom);
      final bearingTween =
          Tween<double>(begin: rotation, end: destBearing ?? rotation);

      try {
        _animationController.dispose();
      } catch (e) {
        loggerObject.e(e);
      }
      _animationController =
          AnimationController(duration: duration, vsync: vsync);
      final Animation<double> animation =
          CurvedAnimation(parent: _animationController, curve: curve);

      _animationController.addListener(() {
        final newPoint =
            LatLng(latTween.evaluate(animation), lngTween.evaluate(animation));
        moveAndRotate(
          newPoint,
          zoomTween.evaluate(animation),
          bearingTween.evaluate(animation),
        );
      });
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.dispose();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.dispose();
        }
      });
      _animationController.forward();
    } catch (e) {
      loggerObject.e(e);
    }
  }
}
