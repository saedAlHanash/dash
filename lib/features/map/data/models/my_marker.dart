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
          height: 70.0.spMin,
          width: 70.0.spMin,
          builder: (context) {
            return InkWell(
              onTap: () {
                context.pushNamed(
                  GoRouteName.pointInfo,
                  queryParams: {'id': item.id.toString()},
                );
              },
              child: Column(
                children: [
                  Transform.rotate(
                    angle: bearing ?? 0.0,
                    child: Container(
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
                  ),
                  if (item is TripPoint)
                    Container(
                      width: 70.0.spMin,
                      color: Colors.white,
                      padding: const EdgeInsets.all(3.0).r,
                      child: DrawableText(
                        text: (item as TripPoint).arName,
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
      case MyMarkerType.sharedPint:
        return Marker(
          point: point,
          height: 100.0.spMin,
          width: 150.0.spMin,
          builder: (context) {
            return Builder(builder: (context) {
              var nou = item as int;
              return Column(
                children: [
                  ImageMultiType(
                    url: index.iconPoint,
                    height: 50.0.spMin,
                    width: 50.0.spMin,
                  ),
                  Container(
                    height: 100.0.spMin,
                    width: 150.0.spMin,
                    margin: EdgeInsets.only(bottom: 5.0.spMin),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                    alignment: Alignment.center,
                    child: DrawableText(
                      text: '$nou مشترك',
                      color: Colors.black,
                      size: 12.0.sp,
                    ),
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
          height: 200.0.r,
          width: 250.0.r,
          builder: (context) {
            return BlocBuilder<BusByImeiCubit, BusByImeiInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }

                return MyCardWidget(
                  cardColor: Colors.white,
                  child: SizedBox(
                    height: 250.0,
                    width: 250.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                context.read<MapControllerCubit>().addTooltipMarker(
                                      marker: null,
                                    );
                              },
                              child: Icon(
                                size: 15.0.r,
                                Icons.cancel_outlined,
                              ),
                            ),
                          ],
                        ),
                        ItemInfoInLineSmall(
                          title: 'اسم الباص',
                          info: (item as Ime).name,
                          small: true,
                        ),
                        ItemInfoInLineSmall(
                          title: 'السرعة',
                          info: (item as Ime).speed,
                          small: true,
                        ),
                        ItemInfoInLineSmall(
                          title: 'IMEI',
                          info: (item as Ime).ime,
                          small: true,
                        ),
                      ],
                    ),
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
