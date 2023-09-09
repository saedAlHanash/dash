import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_package/map/data/models/my_marker.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/points/data/response/points_edge_response.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';
import 'package:qareeb_models/points/data/response/points_edge_response.dart';
import 'package:qareeb_models/trip_path/data/models/trip_path.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/images/image_multi_type.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';

import 'package:qareeb_models/points/data/response/points_response.dart';
import '../../../points/bloc/delete_edge_cubit/delete_edge_cubit.dart';
import '../../../points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../bloc/add_point_cubit/add_point_cubit.dart';

class PathPointsWidget extends StatelessWidget {
  const PathPointsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final addPointCubit = context.read<AddPointCubit>();
    final pointsCubit = context.read<PointsCubit>();

    return BlocBuilder<AddPointCubit, AddPointInitial>(
      builder: (_, state) {
        return PathPointsWidget1(
          list: state.addedPoints,
          onTap: (e) {
            var latestPoint = addPointCubit.removePoint(id: e.id);
            addPointCubit.removeEdge(pointId: latestPoint?.id);
            pointsCubit.getConnectedPoints(context, point: latestPoint);
          },
        );
      },
    );
  }
}

class PathPointsWidget1 extends StatelessWidget {
  const PathPointsWidget1({super.key, required this.list, this.onTap});

  final List<TripPoint> list;
  final Function(TripPoint e)? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0.h,
      child: ListView.separated(
        itemBuilder: (context, i) {
          final item = list[i];
          return TextButton(
            onPressed: (i != list.length - 1)
                ? null
                : () {
                    onTap?.call(item);
                  },
            child: DrawableText(
              drawablePadding: 3.0.w,
              text: item.arName,
              color: Colors.black,
              drawableStart: ImageMultiType(
                url: i.iconPoint,
                height: 25.0.spMin,
                width: 25.0.spMin,
              ),
              drawableEnd: i == list.length - 1
                  ? Icon(
                      Icons.cancel_outlined,
                      size: 12.0.r,
                      color: Colors.red,
                    )
                  : null,
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, i) {
          if (i == list.length - 1) return 0.0.verticalSpace;
          return const Icon(Icons.navigate_next);
        },
        itemCount: list.length,
      ),
    );
  }
}

class PathPointsWidgetWrap extends StatelessWidget {
  const PathPointsWidgetWrap({super.key, required this.list, this.onTap});

  final List<TripPoint> list;
  final Function(TripPoint e)? onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      runAlignment: WrapAlignment.start,
      alignment: WrapAlignment.start,
      children: list
          .mapIndexed((i, e) {
            loggerObject.w(i.iconPoint);
            return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DrawableText(
                    drawablePadding: 3.0.w,
                    text: e.arName,
                    color: Colors.black,
                    drawableStart: ImageMultiType(
                      url: i.iconPoint,
                      height: 25.0.spMin,
                      width: 25.0.spMin,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0).w,
                    child: Icon(
                      Icons.navigate_next,
                      color: i != list.length - 1 ? Colors.black : Colors.transparent,
                    ),
                  ),
                ],
              );
          })
          .toList(),
    );
  }
}

class PathPointsWidgetWrap1 extends StatelessWidget {
  const PathPointsWidgetWrap1({super.key, required this.list, this.onTap});

  final List<TripPoint> list;
  final Function(TripPoint e)? onTap;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const DrawableText(
        text: 'لا يوجد',
        matchParent: true,
        textAlign: TextAlign.center,
      );
    }
    return Wrap(
      direction: Axis.horizontal,
      runAlignment: WrapAlignment.start,
      alignment: WrapAlignment.start,
      children: list.mapIndexed((i, e) {
        return TextButton(
          onPressed: () => onTap?.call(e),
          child: DrawableText(
            drawablePadding: 3.0.w,
            text: e.arName,
            color: Colors.black,
            drawableStart: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(5.0).r,
              decoration: const BoxDecoration(
                color: AppColorManager.mainColor,
                shape: BoxShape.circle,
              ),
              child: ImageMultiType(
                url: Assets.iconsLogoWithoutText,
                color: Colors.white,
                height: 30.0.spMin,
                width: 30.0.spMin,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class EdgesPointWidget extends StatelessWidget {
  const EdgesPointWidget({super.key, required this.item, required this.color});

  final PointsEdgeResult item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: Row(
        children: [
          DrawableText(
            text: 'id: ${item.id}',
            color: Colors.black,
            fontFamily: FontManager.cairoBold,
          ),
          20.0.horizontalSpace,
          Expanded(
            child: DrawableText(
              text: item.endPoint.arName,
              color: Colors.black,
              fontFamily: FontManager.cairoBold,
            ),
          ),
          Expanded(
            child: DrawableText(
              text: 'البعد : ${item.distance} متر',
              color: Colors.black,
              fontFamily: FontManager.cairoBold,
            ),
          ),
          BlocBuilder<DeleteEdgeCubit, DeleteEdgeInitial>(
            buildWhen: (p, c) => c.id == item.endPointId,
            builder: (context, state) {
              if (state.statuses.isLoading) {
                return MyStyle.loadingWidget();
              }
              return IconButton(
                onPressed: () {
                  context.read<DeleteEdgeCubit>().deleteEdge(context,
                      start: item.startPointId, end: item.endPointId);
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
              );
            },
          ),
          5.0.horizontalSpace,
          Container(
            height: 20.0,
            width: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
