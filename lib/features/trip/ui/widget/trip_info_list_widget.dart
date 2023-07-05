import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_string_manager.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/item_info.dart';
import '../../data/response/trip_response.dart';

class TripInfoListWidget extends StatelessWidget {
  const TripInfoListWidget({Key? key, required this.trip}) : super(key: key);

  final TripResult trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemInfo(title: 'الانطلاق', info: trip.currentLocationName),
        ItemInfo(title: 'الوجهة', info: trip.destinationName),
        ItemInfo(title: 'المسافة التقديرية', info: trip.getDistance),
        ItemInfo(title: 'الوقت التقديري', info: trip.getDuration),
        ItemInfo(title: 'رقم هاتف الزبون', info: trip.clientPhoneNumber),
        ItemInfo(
          title: 'كلفة الرحلة',
          widget: DrawableText(
            text: trip.getTripsCost,
            fontFamily: FontManager.cairoBold,
            color: AppColorManager.mainColor,
            drawableEnd: trip.isPaid
                ? const DrawableText(
                    text: AppStringManager.payed,
                    fontFamily: FontManager.cairoBold,
                    color: AppColorManager.mainColor,
                  )
                : null,
            padding: const EdgeInsets.only(right: 10.0, bottom: 25.0, top: 7.0).r,
          ),
        ),
        if (trip.isDriverRated)
          RatingBarIndicator(
            itemCount: 5,
            rating: trip.clientRate,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
          )
      ],
    );
  }
}
