import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/item_info.dart';

class TripInfoListWidget extends StatelessWidget {
  const TripInfoListWidget({Key? key, required this.trip}) : super(key: key);

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemInfoInLine(title: 'الانطلاق', info: trip.sourceName),
        ItemInfoInLine(title: 'الوجهة', info: trip.destinationName),
        ItemInfoInLine(title: 'السائق', info: trip.driver.fullName),
        ItemInfoInLine(title: 'تاريخ الحجز', info: trip.reqestDate?.formatDateTime),
        ItemInfoInLine(title: 'تاريخ البداية', info: trip.startDate?.formatDateTime),
        ItemInfoInLine(title: 'تاريخ النهاية', info: trip.endDate?.formatDateTime),
        ItemInfoInLine(title: 'رقم السيارة', info: trip.driver.carType.carNumber),
        ItemInfoInLine(title: 'نوع السيارة', info: trip.driver.carType.carBrand),
        ItemInfoInLine(title: 'رقم الهاتف', info: trip.driver.phoneNumber),
        ItemInfoInLine(
          title: 'كلفة الرحلة',
          widget: DrawableText(
            text: trip.estimatedCost.formatPrice,
            fontFamily: FontManager.cairoBold,
            color: AppColorManager.mainColor,
            padding: const EdgeInsets.only(right: 10.0, bottom: 25.0, top: 7.0).r,
          ),
        ),

      ],
    );
  }
}
