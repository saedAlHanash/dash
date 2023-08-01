import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/images/image_multi_type.dart';
import 'package:qareeb_dash/features/map/data/models/my_marker.dart';
import 'package:qareeb_dash/features/points/data/response/points_response.dart';
import 'package:qareeb_dash/features/shared_trip/data/response/shared_trip.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../bloc/set_point_cubit/map_control_cubit.dart';

class CachedTileProvider extends TileProvider {
  @override
  ImageProvider<Object> getImage(TileCoordinates coordinates, TileLayer options) {
    return CachedNetworkImageProvider(
      getTileUrl(coordinates, options),
      //Now you can set options that determine how the image gets cached via whichever plugin you use.
    );
  }
}

class MapWidget extends StatefulWidget {
  const MapWidget({
    Key? key,
    this.onMapReady,
    this.initialPoint,
    this.onMapClick,
    this.ime,
    this.search,
  }) : super(key: key);

  final Function(MapController controller)? onMapReady;
  final Function(LatLng latLng)? onMapClick;
  final Function()? search;
  final LatLng? initialPoint;
  final String? ime;

  GlobalKey<MapWidgetState> getKey() {
    return GlobalKey<MapWidgetState>();
  }

  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  late MapController controller;

  String tile = 'https://maps.almobtakiroon.com/osm/tile/{z}/{x}/{y}.png';

  var bearing = 0.0;
  var maxZoom = 18.0;

  var trackCar = true;

  controlMarkersListener(_, MapControlInitial state) async {
    if (state.moveCamera) controller.move(state.point, controller.zoom);

    if (state.state == 'mt') {
      switch (state.type) {
        case MapType.normal:
          tile = 'https://maps.almobtakiroon.com/osm/tile/{z}/{x}/{y}.png';
          maxZoom = 18.0;
          break;

        case MapType.word:
          tile = 'https://maps.almobtakiroon.com/world2/tiles/{z}/{x}/{y}.png';
          maxZoom = 16.4;
          break;

        case MapType.mix:
          tile = 'https://maps.almobtakiroon.com/overlay/{z}/{x}/{y}.png';
          maxZoom = 16.4;
          break;
      }
      setState(() {});
    }

    setState(() {});
  }

  late MapControllerCubit mapControllerCubit;

  final mapWidgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MapControlCubit, MapControlInitial>(
          listener: controlMarkersListener,
        ),
        BlocListener<MapControllerCubit, MapControllerInitial>(
          listenWhen: (p, c) => c.point != null,
          listener: (context, state) {
            controller.move(state.point!, state.zoom);
          },
        ),
      ],
      child: FlutterMap(
        key: mapWidgetKey,
        mapController: controller,
        options: MapOptions(
          maxZoom: maxZoom,
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          onMapReady: () {
            if (widget.initialPoint != null && widget.initialPoint!.latitude != 0) {
              controller.move(widget.initialPoint!, 11);
            } else {
              controller.move(LatLng(33.16, 36.16), 9);
            }

            if (widget.onMapReady != null) {
              widget.onMapReady!(controller);
            }
          },
          onTap: widget.onMapClick == null
              ? null
              : (tapPosition, point) {
                  mapControllerCubit.addSingleMarker(
                    marker: MyMarker(point: point),
                  );
                  widget.onMapClick!.call(point);
                },
          zoom: 16.0,
        ),
        nonRotatedChildren: [
          MapTypeSpinner(
            controller: controller,
          ),
          if (widget.search != null)
            Positioned(
              top: 100.0.h,
              right: 10.0.w,
              child: MyCardWidget(
                elevation: 10.0,
                padding: const EdgeInsets.all(10.0).r,
                cardColor: AppColorManager.lightGray,
                child: InkWell(
                  onTap: widget.search,
                  child: const Icon(
                    Icons.search,
                    color: AppColorManager.mainColor,
                  ),
                ),
              ),
            ),
        ],
        children: [
          TileLayer(
            urlTemplate: tile,
            tileProvider: CachedTileProvider(),
          ),
          BlocBuilder<MapControllerCubit, MapControllerInitial>(
            buildWhen: (p, c) {
              return p.polylineNotifier != c.polylineNotifier;
            },
            builder: (context, state) {
              return PolylineLayer(
                polylines: MapHelper.initPolyline(state),
              );
            },
          ),
          BlocBuilder<MapControllerCubit, MapControllerInitial>(
            buildWhen: (p, c) => p.markerNotifier != c.markerNotifier,
            builder: (context, state) {
              return MarkerLayer(
                markers: MapHelper.initMarker(state),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    mapControllerCubit = context.read<MapControllerCubit>();
    controller = MapControllerImpl();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapControllerCubit.mapHeight = mapWidgetKey.currentContext?.size?.height ?? 640.0;
      mapControllerCubit.mapWidth = mapWidgetKey.currentContext?.size?.width ?? 360.0;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

//---------------------------------------

final mapTypeList = [
  SpinnerItem(name: 'خريطة عادية', id: MapType.normal.index),
  SpinnerItem(name: 'قمر صناعي', id: MapType.word.index),
  SpinnerItem(name: 'مختلطة', id: MapType.mix.index),
];

class MapTypeSpinner extends StatelessWidget {
  const MapTypeSpinner({Key? key, required this.controller}) : super(key: key);

  final MapController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.0.h,
      right: 10.0.w,
      child: SpinnerWidget(
        items: mapTypeList,
        width: 50.0.w,
        dropdownWidth: 200.0.w,
        customButton: MyCardWidget(
          elevation: 10.0,
          padding: const EdgeInsets.all(10.0).r,
          cardColor: AppColorManager.lightGray,
          child: const Icon(Icons.layers_rounded, color: AppColorManager.mainColor),
        ),
        onChanged: (p0) {
          context
              .read<MapControlCubit>()
              .changeMapType(MapType.values[p0.id], controller.center);
        },
      ),
    );
  }
}

class MapHelper {
  static List<Marker> initMarker(MapControllerInitial state) {
    return state.markers.values.mapIndexed(
      (i, e) {
        if (e.type == MyMarkerType.point) {
          return Marker(
            point: e.point,
            height: 70.0.spMin,
            width: 70.0.spMin,
            builder: (context) {
              return InkWell(
                onTap: () {
                  context.pushNamed(
                    GoRouteName.pointInfo,
                    queryParams: {'id': e.item.id.toString()},
                  );
                },
                child: Column(
                  children: [
                    Container(
                      height: 40.spMin,
                      width: 40.spMin,
                      padding: const EdgeInsets.all(5.0).r,
                      decoration: const BoxDecoration(
                        color: AppColorManager.black,
                        shape: BoxShape.circle,
                      ),
                      child: ImageMultiType(
                        url: Assets.iconsLogoWithoutText,
                        color: Colors.white,
                        height: 30.0.spMin,
                        width: 30.0.spMin,
                      ),
                    ),
                    if (e.item is TripPoint)
                      Container(
                        width: 70.0.spMin,
                        color: Colors.white,
                        padding: const EdgeInsets.all(3.0).r,
                        child: DrawableText(
                          text: (e.item as TripPoint).arName,
                          size: 12.0.sp,
                          maxLines: 1,
                          matchParent: true,
                          textAlign: TextAlign.center,
                        ),
                      )
                  ],
                ),
              );
            },
          );
        }
        var isPoint = e.type == MyMarkerType.sharedPint;
        return Marker(
          point: e.point,
          height: !isPoint ? 40.0.spMin : 150.0.spMin,
          width: !isPoint ? 40.0.spMin : 150.0.spMin,
          builder: (context) {
            return (e.type == MyMarkerType.sharedPint)
                ? Builder(builder: (context) {
                    var nou = 0;
                    if (state.additional != null && state.additional is SharedTrip) {
                      nou = (state.additional as SharedTrip).nou(e.point);
                    }
                    return Column(
                      children: [
                        if (nou != 0)
                          Container(
                            height: 35.0.spMin,
                            width: 70.0.spMin,
                            margin: EdgeInsets.only(bottom: 5.0.spMin),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0.r),
                            ),
                            alignment: Alignment.center,
                            child: DrawableText(
                              text: '$nou مقعد',
                              color: Colors.black,
                              size: 12.0.sp,
                            ),
                          ),
                        ImageMultiType(
                          url: i.iconPoint,
                          height: 50.0.spMin,
                          width: 50.0.spMin,
                        ),
                      ],
                    );
                  })
                : ImageMultiType(
                    url: Assets.iconsMainColorMarker,
                    height: 40.0.spMin,
                    width: 40.0.spMin,
                  );
          },
        );
      },
    ).toList();
  }

  static List<Polyline> initPolyline(MapControllerInitial state) {
    return state.polyLines.values.mapIndexed(
      (i, e) {
        return Polyline(
          points: e.first,
          color: e.second,
          strokeCap: StrokeCap.round,
          strokeWidth: 5.0.spMin,
        );
      },
    ).toList();
  }
}
