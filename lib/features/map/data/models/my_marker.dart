import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/features/map/bloc/map_controller_cubit/map_controller_cubit.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/images/image_multi_type.dart';
import '../../../../generated/assets.dart';
import '../../../../router/go_route_pages.dart';
import '../../../buses/bloc/bus_by_imei_cubti/bus_by_imei_cubit.dart';
import '../../../home/data/response/home_response.dart';
import '../../../points/data/response/points_response.dart';
import '../response/ather_response.dart';

class MyMarker {
  LatLng point;
  String? key;
  double? bearing;
  MyMarkerType type;
  dynamic item;

  ///Number of users pickup
  int nou;

  MyMarker({
    required this.point,
    this.key,
    this.bearing,
    this.item,
    this.nou = 0,
    this.type = MyMarkerType.location,
  });

  Marker getWidget(int index) {
    switch (type) {
      case MyMarkerType.location:
        return Marker(
          point: point,
          height: 40.0.spMin,
          width: 40.0.spMin,
          builder: (context) {
            return Transform.rotate(
              angle: bearing ?? 0.0,
              child: ImageMultiType(
                url: Assets.iconsMainColorMarker,
                height: 40.0.spMin,
                width: 40.0.spMin,
              ),
            );
          },
        );
      case MyMarkerType.driver:
        return Marker(
          point: point,
          builder: (context) => 0.0.verticalSpace,
        );
      case MyMarkerType.point:
        return Marker(
          point: point,
          height: 150.0.spMin,
          width: 150.0.spMin,
          builder: (context) {
            return Builder(builder: (context) {
              NotificationPoint? e;
              if (item is NotificationPoint) {
                e = item as NotificationPoint;
              }
              return Column(
                children: [
                  ImageMultiType(
                    url: Assets.iconsBlackMarker,
                    height: 50.0.spMin,
                    width: 50.0.spMin,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0.spMin),
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DrawableText(
                          text: '$nou مشترك',
                          color: Colors.black,
                          size: 18.0.sp,
                        ),
                        if (e != null)
                          DrawableText(
                            text: e.pointArName,
                            color: Colors.black,
                            size: 18.0.sp,
                          ),
                      ],
                    ),
                  ),
                ],
              );
            });
          },
        );
      case MyMarkerType.sharedPint:
        return Marker(
          point: point,
          height: 100.0.spMin,
          width: 150.0.spMin,
          builder: (context) {
            return Builder(builder: (context) {
              return Column(
                children: [
                  ImageMultiType(
                    url: index.iconPoint,
                    height: 50.0.spMin,
                    width: 50.0.spMin,
                  ),
                ],
              );
            });
          },
        );
      case MyMarkerType.bus:
        return Marker(
          point: point,
          height: 40.0.spMin,
          width: 40.0.spMin,
          builder: (context) {
            final imei = item as Ime;
            return InkWell(
              onTap: () {
                context.read<MapControllerCubit>().addTooltipMarker(
                      marker: MyMarker(
                        point: point,
                        type: MyMarkerType.tooltip,
                        item: item,
                      ),
                    );
                // context.read<BusByImeiCubit>().getBusByIme(
                //       context,
                //       ime: (item as Ime).ime,
                //     );
              },
              child: Transform.rotate(
                angle: bearing ?? 0.0,
                child: ImageMultiType(
                  url: Assets.iconsLocator,
                  height: 40.0.spMin,
                  width: 40.0.spMin,
                  color: imei.speed == '0' ? Colors.red : AppColorManager.mainColor,
                ),
              ),
            );
          },
        );

      case MyMarkerType.tooltip:
        return Marker(
          point: point,
          height: 150.0.r,
          width: 250.0.r,
          builder: (context) {
            return BlocBuilder<BusByImeiCubit, BusByImeiInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }

                return Container(
                  constraints: BoxConstraints(maxHeight: 100.0.r, maxWidth: 250.0.r),
                  padding: const EdgeInsets.all(10.0).r,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<MapControllerCubit>().addTooltipMarker(
                                marker: null,
                              );
                        },
                        child: Icon(
                          size: 25.r,
                          Icons.cancel_outlined,
                        ),
                      ),
                      DrawableText(
                        text: 'اسم: ${(item as Ime).name}',
                        color: Colors.black,
                        matchParent: true,
                        size: 16.0.sp,
                      ),
                      DrawableText(
                        text: 'السرعة: ${(item as Ime).speed}',
                        color: Colors.black,
                        matchParent: true,
                        size: 16.0.sp,
                      ),
                      DrawableText(
                        text: 'معرف الباص: ${(item as Ime).ime}',
                        color: Colors.black,
                        matchParent: true,
                        size: 16.0.sp,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
    }
  }

  @override
  String toString() {
    return 'MyMarker{point: $point, key: $key, type: $type, nou: $nou}';
  }
}

class MyPolyLine {
  LatLng? endPoint;
  num? key;
  String encodedPolyLine;
  Color? color;

  MyPolyLine({this.endPoint, this.key, this.encodedPolyLine = '', this.color});
}

class ItemInfoInLineSmall extends StatelessWidget {
  const ItemInfoInLineSmall({
    Key? key,
    required this.title,
    this.info,
    this.widget,
    this.small = false,
  }) : super(key: key);

  final String title;
  final String? info;
  final Widget? widget;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: '$title:  ',
      color: Colors.black,
      size: 16.0.sp,
      padding: const EdgeInsets.only(right: 10.0, bottom: 15.0, top: 3.0).r,
      drawablePadding: 5.0.w,
      fontFamily: FontManager.cairoBold,
      drawableEnd: widget == null
          ? Expanded(
              child: DrawableText(
                text: info ?? '',
                size: 16.0.sp,
                selectable: true,
                fontFamily: FontManager.cairoBold,
                color: AppColorManager.mainColor,
              ),
            )
          : widget!,
    );
  }
}
