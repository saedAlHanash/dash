import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:map_package/map/bloc/search_location/search_location_cubit.dart';
import 'package:map_package/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/widgets/auto_complete_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../../map/search_location_widget.dart';
import '../../../map/search_widget.dart';
import '../../bloc/get_edged_point_cubit/get_all_points_cubit.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  late final MapControllerCubit mapController;

  final mapKey = GlobalKey<MapWidgetState>();

  void addPoints(List<TripPoint> result) {
    mapController
      ..clearMap(false)
      ..addAllPoints(
        points: result,
        onTapMarker: (item) {
          final c = MapMediator(
            zoom: mapKey.currentState?.controller.zoom,
            center: mapKey.currentState?.controller.center.gll,
            pointId: (item as TripPoint).id,
          );

          context.pushNamed(
            GoRouteName.pointInfo,
            queryParams: {'id': item.id.toString()},
            extra: c,
          );
        },
      );
  }

  @override
  void initState() {
    mapController = context.read<MapControllerCubit>();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (context.read<PointsCubit>().state.result.isEmpty) {
          context.read<PointsCubit>().getAllPoints(context);
        } else {
          addPoints(context.read<PointsCubit>().state.result);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PointsCubit, PointsInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) => addPoints(state.result),
        ),
      ],
      child: Scaffold(
        floatingActionButton: isAllowed(AppPermissions.CREATION)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () {
                      final c = MapMediator(
                        zoom: mapKey.currentState?.controller.zoom,
                        center: mapKey.currentState?.controller.center.gll,
                      );

                      context.pushNamed(
                        GoRouteName.pointInfo,
                        extra: c,
                      );
                    },
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                  10.0.verticalSpace,
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () {
                      NoteMessage.showCustomBottomSheet(
                        context,
                        child: Column(
                          children: [
                            30.0.verticalSpace,
                            SizedBox(
                              width: 300.0.w,
                              child: AutoCompleteWidget(
                                onTap: (spinnerItem) {
                                  final c = MapMediator(
                                    zoom: mapKey.currentState?.controller.zoom,
                                    center: mapKey.currentState?.controller.center.gll,
                                    pointId: spinnerItem.id??0,
                                  );
                                  context.pushNamed(
                                    GoRouteName.pointInfo,
                                    queryParams: {'id': spinnerItem.id.toString()},
                                    extra: c,
                                  );
                                },
                                listItems:
                                    context.read<PointsCubit>().state.getSpinnerItems(),
                              ),
                            ),
                            30.0.verticalSpace,
                          ],
                        ),
                        onCancel: (val) {},
                      );
                    },
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ],
              )
            : null,
        body: MapWidget(
          clustering: true,
          key: mapKey,
          // updateMarkerWithZoom: true,
          search: () async {
            NoteMessage.showCustomBottomSheet(
              context,
              child: BlocProvider.value(
                value: context.read<SearchLocationCubit>(),
                child: SearchWidget(
                  onTap: (SearchLocationItem location) {
                    Navigator.pop(context);
                    context
                        .read<MapControllerCubit>()
                        .movingCamera(point: location.point, zoom: 15.0);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MapMediator {
  LatLng? center;
  double? zoom;
  int pointId;

  MapMediator({
    this.pointId = 0,
    required this.center,
    required this.zoom,
  });

  Map<String, dynamic> toMap() {
    return {
      'center': center,
      'zoom': zoom,
      'pointId': pointId,
    };
  }
}
