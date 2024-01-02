import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:map_package/map/data/models/my_marker.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/points/data/model/trip_point.dart';
import 'package:qareeb_models/trip_path/data/models/trip_path.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';
import '../../../points/bloc/delete_edge_cubit/delete_edge_cubit.dart';
import '../../../points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../bloc/add_point_cubit/add_point_cubit.dart';

class PathPointsWidget extends StatefulWidget {
  const PathPointsWidget({super.key});

  @override
  State<PathPointsWidget> createState() => _PathPointsWidgetState();
}

class _PathPointsWidgetState extends State<PathPointsWidget> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        scrollController.animateTo(
          1.maxInt as double,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addPointCubit = context.read<AddPointCubit>();
    final pointsCubit = context.read<PointsCubit>();

    return BlocConsumer<AddPointCubit, AddPointInitial>(
      listener: (context, state) {
        scrollController.animateTo(
          1.maxInt as double,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      builder: (_, state) {
        return PathPointsWidget1(
          scrollController: scrollController,
          list: state.addedPoints,
          onTap: (e) {
            var latestPoint = addPointCubit.removePoint(id: e.id);
            addPointCubit.removeEdge();
            pointsCubit.getConnectedPoints(context, point: latestPoint);
          },
        );
      },
    );
  }
}

class PathPointsWidget1 extends StatelessWidget {
  const PathPointsWidget1(
      {super.key, required this.list, this.onTap, required this.scrollController});

  final List<TripPoint> list;
  final Function(TripPoint e)? onTap;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0.h,
      child: ListView.separated(
        controller: scrollController,
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
              selectable: false,
              color: Colors.black,
              drawableStart: ImageMultiType(
                url: i.iconPoint,
                height: 40.0.spMin,
                width: 40.0.spMin,
              ),
              drawableEnd: (i == list.length - 1)
                  ? Icon(
                      Icons.cancel_outlined,
                      size: 25.0.r,
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
      children: list.mapIndexed((i, e) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DrawableText(
              selectable: false,
              drawablePadding: 3.0.w,
              text: e.arName,
              color: Colors.black,
              drawableStart: ImageMultiType(
                url: i.iconPoint,
                height: 40.0.spMin,
                width: 40.0.spMin,
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
      }).toList(),
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
        selectable: false,
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
            selectable: false,
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

  final Edge item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: Row(
        children: [
          DrawableText(
            selectable: false,
            text: 'id: ${item.id}',
            color: Colors.black,
            fontFamily: FontManager.cairoBold.name,
          ),
          20.0.horizontalSpace,
          Expanded(
            child: DrawableText(
              selectable: false,
              text: item.endPoint.arName,
              color: Colors.black,
              fontFamily: FontManager.cairoBold.name,
            ),
          ),
          Expanded(
            child: DrawableText(
              selectable: false,
              text: 'البعد : ${item.distance.toInt()} متر',
              color: Colors.black,
              fontFamily: FontManager.cairoBold.name,
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
