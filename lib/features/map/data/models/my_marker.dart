import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/images/image_multi_type.dart';
import '../../../../generated/assets.dart';
import '../../../../router/go_route_pages.dart';
import '../../../points/data/response/points_response.dart';

class MyMarker {
  LatLng point;
  int? key;
  MyMarkerType type;
  double? bearing;
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
          height: 90.0.spMin,
          width: 150.0.spMin,
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
                      width: 150.0.spMin,
                      color: Colors.white,
                      padding: const EdgeInsets.all(3.0).r,
                      child: DrawableText(
                        selectable: false,
                        text: (item as TripPoint).arName,
                        size: 15.0.sp,
                        maxLines: 2,
                        fontFamily: FontManager.cairoBold,
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
          height: 150.0.spMin,
          width: 150.0.spMin,
          builder: (context) {
            return Builder(builder: (context) {
              var nou = 0;
              return Column(
                children: [
                  if (nou != 0)
                    Container(
                      height: 35.0.spMin,
                      width: 70.0.spMin,
                      margin: EdgeInsets.only(bottom: 5.0.spMin),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0.r),
                      ),
                      alignment: Alignment.center,
                      child: DrawableText(
                        text: '$nou مقعد',
                        color: Colors.black,
                        size: 12.0.sp,
                      ),
                    ),
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
            return Transform.rotate(
              angle: bearing ?? 0.0,
              child: ImageMultiType(
                url: Assets.iconsLocator,
                height: 40.0.spMin,
                width: 40.0.spMin,
              ),
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
  TripPoint? endPoint;
  num? key;
  String encodedPolyLine;
  Color? color;

  MyPolyLine({this.endPoint, this.key, this.encodedPolyLine = '', this.color});
}
