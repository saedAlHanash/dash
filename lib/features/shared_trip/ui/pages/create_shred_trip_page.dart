import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../router/app_router.dart';
import '../../../points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../../points/bloc/get_points_edge_cubit/get_points_edge_cubit.dart';
import '../../../temp_trips/ui/widget/search_points_widget.dart';
import '../../bloc/add_point_cubit/add_point_cubit.dart';
import '../../bloc/create_shared_trip_cubit/create_shared_trip_cubit.dart';
import '../../data/request/create_shared_request.dart';
import '../widget/path_points_widget.dart';


class CreateSharedTripPage extends StatefulWidget {
  const CreateSharedTripPage({Key? key}) : super(key: key);

  @override
  State<CreateSharedTripPage> createState() => _CreateSharedTripPageState();
}

class _CreateSharedTripPageState extends State<CreateSharedTripPage> {
  /// Start Text Controller
  final searchController = TextEditingController();

  late MapControllerCubit mapCubit;
  late AddPointCubit addPointCubit;
  late PointsCubit pointsCubit;
  late PointsEdgeCubit pointsEdgeCubit;
  late CreateSharedTripCubit createSharedCubit;

  final List<TripPoint> finalList = [];
  final List<TripPoint> list = [];

  ///search in DB and render list widget
  Future<void> search(String val) async {
    list.clear();
    if (val.isEmpty) {
      setState(() => list.addAll(finalList));
    }

    setState(() {
      for (var e in finalList) {
        if (e.arName.contains(val)) list.add(e);
      }
    });
  }

  @override
  void initState() {
    mapCubit = context.read<MapControllerCubit>();
    addPointCubit = context.read<AddPointCubit>();
    pointsCubit = context.read<PointsCubit>();
    pointsEdgeCubit = context.read<PointsEdgeCubit>();
    createSharedCubit = context.read<CreateSharedTripCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<PointsEdgeCubit, PointsEdgeInitial>(
            listenWhen: (p, c) => c.statuses.done,
            listener: (context, state) {
              addPointCubit.addEdge(
                edgeId: state.result.id,
                pointId: state.result.endPointId,
                edge: state.result,
              );
            },
          ),
          BlocListener<PointsCubit, PointsInitial>(
            listenWhen: (p, c) => c.statuses.done,
            listener: (context, state) {
              setState(() {
                finalList
                  ..clear()
                  ..addAll(state.result);

                list
                  ..clear()
                  ..addAll(finalList);
              });
            },
          ),
          BlocListener<CreateSharedTripCubit, CreateSharedTripInitial>(
            listenWhen: (p, c) => c.statuses.done,
            listener: (context, state) {
              NoteMessage.showDoneDialog(
                context,
                text: 'تم انشاء الرحلة التشاركية ',
                onCancel: () {
                  Navigator.pushReplacementNamed(context, RouteNames.sharedTrips);
                },
              );
            },
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const AppBarWidget(),
          body: Padding(
            padding: MyStyle.pagePadding,
            child: Column(
              children: [
                const PathPointsWidget(),
                MyEditTextWidget(
                  controller: searchController,
                  radios: 15.0.r,
                  backgroundColor: AppColorManager.cardColor,
                  hint: AppStringManager.search,
                  onChanged: search,
                ),
                DrawableText(
                  text: 'يرجى اختيار نقطة تجمع من القائمة التالية',
                  color: AppColorManager.gray,
                  matchParent: true,
                  textAlign: TextAlign.start,
                  size: 16.0.sp,
                ),
                3.0.verticalSpace,
                DrawableText(
                  text: 'بعد اختيارك أول نقطة يمكنك الاختيار من النقاط المرتبطة بها ',
                  color: AppColorManager.gray,
                  matchParent: true,
                  textAlign: TextAlign.start,
                  size: 16.0.sp,
                ),
                const Divider(),
                Expanded(
                  child: BlocBuilder<PointsCubit, PointsInitial>(
                    builder: (context, state) {
                      if (state.statuses.isLoading) {
                        return MyStyle.loadingWidget();
                      }

                      return SearchLocationWidget(
                        items: list,
                        onItemClick: (e) {
                          pointsEdgeCubit.getPointsEdge(
                            context,
                            start: addPointCubit.getLatestPoint?.id,
                            end: e.id,
                          );
                          //إضافة لقائمة المختار
                          addPointCubit.addPoint(point: e);
                          //جلب النقاط التالية
                          pointsCubit.getConnectedPoints(context, point: e);

                          searchController.text = '';
                        },
                      );
                    },
                  ),
                ),
                BlocBuilder<CreateSharedTripCubit, CreateSharedTripInitial>(
                  builder: (context, state) {
                    if (state.statuses.isLoading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      color: addPointCubit.state.addedPoints.length < 2
                          ? AppColorManager.mainColor.withOpacity(0.5)
                          : null,
                      text: 'إنشاء الرحلة',
                      onTap: addPointCubit.state.addedPoints.length < 2
                          ? null
                          : () async {
                              final now = DateTime.now();
                              final pick = await showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: now,
                                lastDate: now.addFromNow(month: 1),
                              );
                              if (pick != null && context.mounted) {

                                final time = await showTimePicker(
                                    context: context, initialTime: TimeOfDay.now());

                                if (time != null && context.mounted) {
                                  final request = RequestCreateShared();
                                  request.schedulingDate =
                                      now.initialFromDateTime(date: pick, time: time);

                                  for (var value in addPointCubit.state.edgeIds) {
                                    request.pathEdgesIds.add(value);
                                  }

                                  createSharedCubit.createSharesTrip(
                                    context,
                                    request: request,
                                  );
                                }
                              }
                            },
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
