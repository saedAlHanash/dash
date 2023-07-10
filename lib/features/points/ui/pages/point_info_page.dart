import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/app_bar_widget.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/features/map/data/models/my_marker.dart';
import 'package:qareeb_dash/features/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/features/points/bloc/creta_edge_cubit/create_edge_cubit.dart';
import 'package:qareeb_dash/features/points/bloc/get_all_points_cubit/get_edged_point_cubit.dart';
import 'package:qareeb_dash/features/points/data/request/create_edg_request.dart';
import 'package:qareeb_dash/features/points/data/response/points_response.dart';
import 'package:qareeb_dash/features/shared_trip/ui/widget/path_points_widget.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../bloc/creta_point_cubit/create_point_cubit.dart';
import '../../bloc/delete_edge_cubit/delete_edge_cubit.dart';
import '../../bloc/delete_point_cubit/delete_point_cubit.dart';
import '../../bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../bloc/point_by_id_cubit/point_by_id_cubit.dart';
import '../../data/request/create_point_request.dart';

class PointInfoPage extends StatefulWidget {
  const PointInfoPage({super.key});

  @override
  State<PointInfoPage> createState() => _PointInfoPageState();
}

class _PointInfoPageState extends State<PointInfoPage> {
  late final MapControllerCubit mapController;

  final request = CreatePointRequest();

  TripPoint? tripPoint;
  var canEdit = false;

  @override
  void initState() {
    mapController = context.read<MapControllerCubit>();
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
        BlocListener<CreatePointCubit, CreatePointInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<PointsCubit>().getAllPoints(context);
            if (tripPoint != null) {
              setState(() => canEdit = false);
            } else {
              context.read<PointsCubit>().getAllPoints(context);
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<DeletePointCubit, DeletePointInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<PointsCubit>().getAllPoints(context);
            Navigator.pop(context);
          },
        ),
        BlocListener<EdgesPointCubit, EdgesPointInitial>(
          listener: (context, state) {
            mapController.addEncodedPolyLines(
              myPolyLines: state.result
                  .mapIndexed(
                    (i, e) => MyPolyLine(
                      encodedPolyLine: e.steps,
                      endPoint: e.endPoint.getLatLng,
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
            mapController.addMarker(
                marker: MyMarker(
              point: state.result.getLatLng,
              item: state.result,
            ));
          },
        ),
      ],
      child: BlocBuilder<PointByIdCubit, PointByIdInitial>(
        builder: (context, state) {
          var createMode = state.statuses.init;
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          if (!createMode) {
            request.initFromPoint(state.result);
          }

          return Scaffold(
            appBar: const AppBarWidget(
              text: 'نقطة مواقف قريب',
            ),
            body: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0).r,
                    child: Column(
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
                                    if (state.statuses.loading) {
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
                          enable: canEdit || createMode,
                          label: ' اسم النقطة (en)',
                          onChanged: (val) => request.name = val,
                          initialValue: request.name,
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
                            if (state.statuses.loading) {
                              return MyStyle.loadingWidget();
                            }

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
                                          SpinnerWidget(
                                            items: context
                                                .read<PointsCubit>()
                                                .state
                                                .getSpinnerItems(reject: tripPoint?.id),
                                            onChanged: (spinnerItem) {
                                              createEdgeRequest.endPointId =
                                                  spinnerItem.id;
                                              createEdgeRequest.endPointLatLng =
                                                  (spinnerItem.item as TripPoint)
                                                      .getLatLng;
                                            },
                                          ),
                                          BlocBuilder<CreateEdgeCubit, CreateEdgeInitial>(
                                            builder: (context, state) {
                                              if (state.statuses.loading) {
                                                return MyStyle.loadingWidget();
                                              }
                                              return MyButton(
                                                onTap: () {
                                                  context
                                                      .read<CreateEdgeCubit>()
                                                      .createEdge(context,
                                                          request: createEdgeRequest);
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
                        BlocBuilder<CreatePointCubit, CreatePointInitial>(
                          builder: (context, createState) {
                            if (createState.statuses.loading) {
                              return MyStyle.loadingWidget();
                            }
                            return MyButton(
                              active: createMode || canEdit,
                              text: createMode ? 'إنشاء' : 'تعديل',
                              onTap: () {
                                if (!request.validateRequest(context)) return;

                                context
                                    .read<CreatePointCubit>()
                                    .createPoint(context, request: request);
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                20.0.horizontalSpace,
                Expanded(
                  child: MapWidget(
                    initialPoint: request.getLatLng,
                    onMapClick: !createMode
                        ? null
                        : (latLng) {
                            request.lat = latLng.latitude;
                            request.lng = latLng.longitude;
                          },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
