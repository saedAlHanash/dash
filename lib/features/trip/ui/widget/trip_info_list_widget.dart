import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_string_manager.dart';
import 'package:qareeb_dash/features/rating/presentation/pages/rating_page.dart';

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
        ItemInfoInLine(title: 'الانطلاق', info: trip.currentLocationName),
        ItemInfoInLine(title: 'الوجهة', info: trip.destinationName),
        ItemInfoInLine(title: 'المسافة التقديرية', info: trip.getDistance),
        ItemInfoInLine(title: 'الوقت التقديري', info: trip.getDuration),
        ItemInfoInLine(
            title: 'الوقت الفعلي',
            info: (trip.endDate != null && trip.startDate != null)
                ? trip.startDate!.difference(trip.endDate!).inMinutes.abs().toString()
                : '-'),
        // ItemInfoInLine(title: title)(title: 'المسافة الفعلية', info: trip.distance),
        ItemInfoInLine(title: 'رقم هاتف الزبون', info: trip.clientPhoneNumber),
        ItemInfoInLine(title: 'كلفة الرحلة', info: trip.getTripsCost),
        ItemInfoInLine(title: 'تاريخ الحجز', info: trip.creationTime?.formatDateTime??'-'),
        // ItemInfoInLine(title: title)(title: 'تاريخ القبول', info: trip.),
        ItemInfoInLine(title: 'تاريخ البداية', info: trip.startDate?.formatDateTime??'-'),
        ItemInfoInLine(title: 'تاريخ النهاية', info: trip.endDate?.formatDateTime??'-'),
        ItemInfoInLine(title: 'تقييم الزبون للسائق',widget: RatingBarWidget(initial: trip.driverRate)),
        ItemInfoInLine(title: 'تقييم السائق للزبون',widget: RatingBarWidget(initial: trip.clientRate)),



        // if (trip.isDriverRated)
        //   RatingBarIndicator(
        //     itemCount: 5,
        //     rating: trip.clientRate,
        //     itemBuilder: (context, _) => const Icon(
        //       Icons.star,
        //       color: Colors.amber,
        //     ),
        //   )
      ],
    );
  }
}
