import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:map_package/map/bloc/search_location/search_location_cubit.dart';
import 'package:map_package/map/data/models/my_marker.dart';
import 'package:map_package/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/app_bar_widget.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/features/points/bloc/creta_edge_cubit/create_edge_cubit.dart';
import 'package:qareeb_dash/features/points/bloc/get_all_points_cubit/get_edged_point_cubit.dart';
import 'package:qareeb_dash/features/points/data/request/create_edg_request.dart';
import 'package:qareeb_dash/features/points/ui/pages/points_page.dart';
import 'package:qareeb_dash/features/shared_trip/ui/widget/path_points_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';
import 'package:qareeb_models/trip_path/data/models/trip_path.dart';
import "package:universal_html/html.dart";

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/auto_complete_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../../../services/osrm/bloc/location_name_cubit/location_name_cubit.dart';
import '../../../map/search_location_widget.dart';
import '../../../map/search_widget.dart';
import '../../bloc/creta_point_cubit/create_point_cubit.dart';
import '../../bloc/delete_edge_cubit/delete_edge_cubit.dart';
import '../../bloc/delete_point_cubit/delete_point_cubit.dart';
import '../../bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../bloc/point_by_id_cubit/point_by_id_cubit.dart';
import '../../data/request/create_point_request.dart';

class PointInfoPage extends StatefulWidget {
  const PointInfoPage({super.key, this.mapMediator});

  final MapMediator? mapMediator;

  @override
  State<PointInfoPage> createState() => _PointInfoPageState();
}

class _PointInfoPageState extends State<PointInfoPage> {
  late final MapControllerCubit mapController;

  List<Edge>? edges;
  final request = CreatePointRequest();

  TripPoint? tripPoint;
  final pointNameC = TextEditingController();
  var canEdit = false;
  var createMode = true;

  final mapKey = GlobalKey<MapWidgetState>();

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        if (context.read<PointsCubit>().state.result.isEmpty) {
          context.read<PointsCubit>().getAllPoints(context);
        }
      },
    );

    mapController = context.read<MapControllerCubit>();

    mapController
      ..clearMap(false)
      ..addAllPoints(
        points: context.read<PointsCubit>().state.result,
        onTapMarker: (item) {
          final c = MapMediator(
            zoom: mapKey.currentState?.controller.zoom,
            center: mapKey.currentState?.controller.center.gll,
          );
          context.pushNamed(
            GoRouteName.pointInfo,
            queryParams: {'id': item.id.toString()},
            extra: c,
          );
        },
      );

    // if (widget.mapMediator != null && widget.mapMediator!.center != null) {
    //   Future.delayed(
    //     const Duration(seconds: 1),
    //     () {
    //       mapController.movingCamera(
    //           point: widget.mapMediator!.center!, zoom: widget.mapMediator!.zoom ?? 14);
    //     },
    //   );
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteEdgeCubit, DeleteEdgeInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<EdgesPointCubit>().getAllEdgesPoint(
                  context,
                  id: request.id!,
                );
          },
        ),
        BlocListener<CreateEdgeCubit, CreateEdgeInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context
                .read<EdgesPointCubit>()
                .getAllEdgesPoint(context, id: tripPoint?.id ?? 0);
          },
        ),
        BlocListener<PointsCubit, PointsInitial>(
          listener: (context, state) {
            mapController
              ..clearMap(false)
              ..addAllPoints(
                points: state.result,
                onTapMarker: (item) {
                  final c = MapMediator(
                    zoom: mapKey.currentState?.controller.zoom,
                    center: mapKey.currentState?.controller.center.gll,
                  );
                  context.pushNamed(
                    GoRouteName.pointInfo,
                    queryParams: {'id': item.id.toString()},
                    extra: c,
                  );
                },
              );
          },
        ),
        BlocListener<CreatePointCubit, CreatePointInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<PointsCubit>().getAllPoints(context);
            if (tripPoint != null) {
              context.read<PointByIdCubit>().getPointById(context, id: request.id);
              context.read<EdgesPointCubit>().getAllEdgesPoint(context, id: request.id);
              setState(() => canEdit = false);
            } else {
              // context.read<PointsCubit>().getAllPoints(context);
              window.history.back();
            }
          },
        ),
        BlocListener<DeletePointCubit, DeletePointInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<PointsCubit>().getAllPoints(context);
            window.history.back();
          },
        ),
        BlocListener<EdgesPointCubit, EdgesPointInitial>(
          listener: (context, state) {
            mapController.addEncodedPolyLines(
              myPolyLines: state.result
                  .mapIndexed(
                    (i, e) => MyPolyLine(
                      encodedPolyLine: e.steps,
                      endPoint: e.endPoint,
                      color: AppColorManager.getPolyLineColor(i),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        BlocListener<PointByIdCubit, PointByIdInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            tripPoint = state.result;
            pointNameC.text = tripPoint?.name ?? '';
            mapController.addSingleMarker(
              marker: MyMarker(
                point: state.result.getLatLng,
                item: state.result,
              ),
            );

            if (widget.mapMediator != null && widget.mapMediator!.center != null) {
              Future.delayed(
                const Duration(seconds: 1),
                    () {
                  mapController.movingCamera(
                      point: widget.mapMediator!.center!, zoom: widget.mapMediator!.zoom ?? 14);
                },
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'نقطة مواقف قريب',
        ),
        body: BlocBuilder<PointByIdCubit, PointByIdInitial>(
          builder: (context, state) {
            createMode = state.statuses.init;
            if (state.statuses.isLoading) {
              return MyStyle.loadingWidget();
            }
            if (!createMode) {
              request.initFromPoint(state.result);
            }

            return Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0).r,
                    child: tripInfoBuilder(),
                  ),
                ),
                20.0.horizontalSpace,
                Expanded(
                  child: MapWidget(
                    key: mapKey,
                    updateMarkerWithZoom: true,
                    initialPoint: request.getLatLng,
                    search: search,
                    onMapClick: !canEdit && !createMode
                        ? null
                        : (latLng) {
                            request.lat = latLng.latitude;
                            request.lng = latLng.longitude;
                            mapController.addSingleMarker(
                              marker: MyMarker(
                                  point: request.getLatLng!, type: MyMarkerType.location),
                              moveTo: true,
                            );
                          },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void search() {
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
  }

  Widget tripInfoBuilder() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DrawableText(
          text: 'معلومات النقطة ',
          matchParent: true,
          fontFamily: FontManager.cairoBold,
          size: 28.0.sp,
          padding: const EdgeInsets.symmetric(vertical: 15.0).h,
          textAlign: TextAlign.center,
          drawableEnd: createMode
              ? null
              : BlocBuilder<DeletePointCubit, DeletePointInitial>(
                  buildWhen: (p, c) => c.id == tripPoint?.id,
                  builder: (context, state) {
                    if (state.statuses.isLoading) {
                      return MyStyle.loadingWidget();
                    }
                    return IconButton(
                      onPressed: () {
                        context.read<DeletePointCubit>().deletePoint(
                              context,
                              id: tripPoint?.id ?? 0,
                            );
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
        ),
        MyTextFormNoLabelWidget(
          enable: canEdit || createMode,
          label: ' اسم النقطة (AR)',
          onChanged: (val) => request.arName = val,
          initialValue: request.arName,
        ),
        20.0.verticalSpace,
        MyTextFormNoLabelWidget(
          controller: pointNameC,
          enable: canEdit || createMode,
          label: ' اسم النقطة (en)',
          textDirection: TextDirection.ltr,
          onChanged: (val) => request.name = val,
        ),
        20.0.verticalSpace,
        MyTextFormNoLabelWidget(
          enable: canEdit || createMode,
          label: 'خطوط الطول والعرض ( 0.00,0.00 )',
          onChanged: (val) async {
            final listNum = val.split(',');
            if (listNum.length <= 2) {
              var lat = double.tryParse(listNum.first);
              var lng = double.tryParse(listNum.last);
              request.lat = lat;
              request.lng = lng;
              var l = request.getLatLng;
              if (l != null) {
                mapController.addSingleMarker(marker: MyMarker(point: l), moveTo: true);
                setState(() {});
                if (pointNameC.text.isEmpty) {
                  final name = await LocationNameCubit.getLocationNameApi(latLng: l);

                  request.name = name.first;

                  pointNameC.text = request.name ?? '';
                }
              }
            }
          },
          initialValue: request.lat == null ? null : '${request.lat},${request.lng}',
        ),
        20.0.verticalSpace,
        MyTextFormNoLabelWidget(
          enable: canEdit || createMode,
          label: 'وسوم النقطة (يرجى الفصل بين الوسوم ب , )',
          onChanged: (val) => request.tags = val,
          initialValue: request.tags,
        ),
        DrawableText(
          text: 'النقاط المتصلة',
          matchParent: true,
          padding: const EdgeInsets.symmetric(vertical: 15.0).h,
          textAlign: TextAlign.center,
        ),
        BlocBuilder<EdgesPointCubit, EdgesPointInitial>(
          builder: (context, state) {
            if (state.statuses.isLoading) {
              return MyStyle.loadingWidget();
            }
            edges = state.result;

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.result.length,
              itemBuilder: (context, i) {
                return EdgesPointWidget(
                  item: state.result[i],
                  color: AppColorManager.getPolyLineColor(i),
                );
              },
            );
          },
        ),
        20.0.verticalSpace,
        if (isAllowed(AppPermissions.UPDATE))
          if (!canEdit && !createMode)
            Row(
              children: [
                MyButton(
                  text: 'وضع التعديل؟',
                  onTap: () => setState(() => canEdit = true),
                ),
                10.0.horizontalSpace,
                MyButton(
                  text: 'توصيل بنقطة',
                  onTap: () {
                    if (edges == null) return;
                    final createEdgeRequest = CreateEdgeRequest(
                      startPointId: tripPoint?.id,
                      startPointLatLng: tripPoint?.getLatLng,
                    );
                    NoteMessage.showCustomBottomSheet(
                      context,
                      child: BlocProvider.value(
                        value: context.read<CreateEdgeCubit>(),
                        child: Column(
                          children: [
                            30.0.verticalSpace,
                            SizedBox(
                              width: 300.0.w,
                              child: AutoCompleteWidget(
                                onTap: (spinnerItem) {
                                  createEdgeRequest.endPointId = spinnerItem.id;
                                  createEdgeRequest.endPointLatLng =
                                      (spinnerItem.item as TripPoint).getLatLng;
                                },
                                listItems:
                                    context.read<PointsCubit>().state.getSpinnerItems(
                                  reject: [
                                    tripPoint?.id,
                                    ...edges!
                                        .map(
                                          (e) => e.endPointId,
                                        )
                                        .toList(),
                                  ],
                                ),
                              ),
                            ),
                            30.0.verticalSpace,
                            BlocBuilder<CreateEdgeCubit, CreateEdgeInitial>(
                              builder: (context, state) {
                                if (state.statuses.isLoading) {
                                  return MyStyle.loadingWidget();
                                }
                                return MyButton(
                                  onTap: () {
                                    context
                                        .read<CreateEdgeCubit>()
                                        .createEdge(context, request: createEdgeRequest);
                                  },
                                  text: 'توصيل',
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      onCancel: (val) {},
                    );
                  },
                ),
              ],
            ),
        10.0.verticalSpace,
        if (createMode || canEdit)
          BlocBuilder<CreatePointCubit, CreatePointInitial>(
            builder: (context, createState) {
              if (createState.statuses.isLoading) {
                return MyStyle.loadingWidget();
              }
              return MyButton(
                active: createMode || canEdit,
                text: createMode ? 'إنشاء' : 'تعديل',
                onTap: () {
                  if (!request.validateRequest(context)) return;

                  context.read<CreatePointCubit>().createPoint(context, request: request);
                },
              );
            },
          )
      ],
    );
  }
}
