import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../../points/bloc/get_points_edge_cubit/get_points_edge_cubit.dart';
import '../../../shared_trip/bloc/add_point_cubit/add_point_cubit.dart';
import '../../bloc/create_temp_trip_cubit/create_temp_trip_cubit.dart';
import 'path_points_widget.dart';
import 'search_points_widget.dart';

class CreateTempTripWidget extends StatefulWidget {
  const CreateTempTripWidget({Key? key}) : super(key: key);

  @override
  State<CreateTempTripWidget> createState() => _CreateTempTripWidgetState();
}

class _CreateTempTripWidgetState extends State<CreateTempTripWidget> {
  /// Start Text Controller
  final searchController = TextEditingController();

  late MapControllerCubit mapCubit;
  late AddPointCubit addPointCubit;
  late PointsCubit pointsCubit;
  late PointsEdgeCubit pointsEdgeCubit;
  late CreateTempTripCubit createTempCubit;

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
    createTempCubit = context.read<CreateTempTripCubit>();

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
                edgeId: state.result.id, pointId: state.result.endPointId);
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
      ],
      child: Padding(
        padding: MyStyle.pagePadding,
        child: Column(

          children: [
            const PathPointsWidget(),
            MyEditTextWidget(
              controller: searchController,

              radios: 15.0.r,
              backgroundColor: AppColorManager.whit,
              hint: AppStringManager.search,
              onChanged: search,
            ),
            DrawableText(
              text: 'يرجى اختيار نقطة تجمع من القائمة التالية',
              color: AppColorManager.gray,
              matchParent: true,
              textAlign: TextAlign.end,
              size: 16.0.sp,
            ),
            3.0.verticalSpace,
            DrawableText(
              text: 'بعد اختيارك أول نقطة يمكنك الاختيار من النقاط المرتبطة بها ',
              color: AppColorManager.gray,
              matchParent: true,
              textAlign: TextAlign.end,
              size: 16.0.sp,
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<PointsCubit, PointsInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
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
          ],
        ),
      ),
    );
  }
}
