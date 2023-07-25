import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/widgets/images/image_multi_type.dart';

import '../../../points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../../points/data/response/points_response.dart';
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
          .mapIndexed((i, e) => Row(
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
              ))
          .toList(),
    );
  }
}
