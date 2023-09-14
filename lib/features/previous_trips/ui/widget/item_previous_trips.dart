import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/images/image_multi_type.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';

class ItemPreviousTrip extends StatelessWidget {
  const ItemPreviousTrip({Key? key, required this.trip}) : super(key: key);

  final TripResult trip;

  @override
  Widget build(BuildContext context) {
    final iconSize = 30.0.spMin;

    final margin = EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.0.h);

    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        // context.pushNamed(GoRouteName.tripInfoPage);
      },
      child: MyCardWidget(
        elevation: 5.0,
        margin: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawableText(
              text: trip.isCanceled
                  ? 'ملغية'
                  : trip.isActive
                      ? 'رحلة جارية'
                      : 'منتهية',
              fontFamily: FontManager.cairoBold,
              color: trip.isCanceled ? AppColorManager.red : AppColorManager.mainColor,
              drawableAlin: DrawableAlin.between,
              matchParent: true,
              drawableEnd: DrawableText(
                text: trip.getCost,
                fontFamily: FontManager.cairoBold,
                color: AppColorManager.gray,
              ),
            ),

            5.0.verticalSpace,
            //التاريخ
            DrawableText(
              text: trip.dateTrip,
              color: AppColorManager.gray,
            ),
            10.0.verticalSpace,
            DrawableText(
              text: trip.currentLocationName,
              color: AppColorManager.black,
              matchParent: true,
              drawablePadding: 10.0.w,
              drawableStart: ImageMultiType(
                  url: Assets.iconsMarkerStart, height: iconSize, width: iconSize),
              fontFamily: FontManager.cairoBold,
            ),
            5.0.verticalSpace,
            DrawableText(
              text: trip.destinationName,
              color: AppColorManager.black,
              padding: const EdgeInsets.symmetric(vertical: 5.0).h,
              matchParent: true,
              drawablePadding: 10.0.w,
              drawableStart: ImageMultiType(
                  url: Assets.iconsMarkerEnd, height: iconSize, width: iconSize),
              fontFamily: FontManager.cairoBold,
            ),
            // 10.0.verticalSpace,
            // MyTableWidget(
            //   children: mapTable,
            //   title: AppStringManager.driverInfo,
            // ),
            // 10.0.verticalSpace,
            // rating,
            10.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}
