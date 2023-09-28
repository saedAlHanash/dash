import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/rating/presentation/pages/rating_page.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import '../../../../core/widgets/item_info.dart';

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
        ItemInfoInLine(title: 'المسافة الحقيقية', info: trip.getRealDistance),
        ItemInfoInLine(title: 'المسافة التعويضية', info: trip.getPreAcceptDistance),
        ItemInfoInLine(title: 'الوقت التقديري', info: trip.getDuration),
        ItemInfoInLine(
          title: 'الوقت الفعلي',
          info: (trip.endDate != null && trip.startDate != null)
              ? trip.startDate!.difference(trip.endDate!).inMinutes.abs().toString()
              : '-',
        ),
        ItemInfoInLine(
          title: 'رقم هاتف الزبون',
          info: trip.clientPhoneNumber,
        ),
        ItemInfoInLine(
          title: 'كلفة الرحلة',
          info: trip.getTripsCost,
        ),
        ItemInfoInLine(
          title: 'تاريخ الحجز',
          info: trip.creationTime?.formatDateTime ?? '-',
        ),
        // ItemInfoInLine(title: title)(title: 'تاريخ القبول', info: trip.),
        ItemInfoInLine(
          title: 'تاريخ البداية',
          info: trip.startDate?.formatDateTime ?? '-',
        ),
        ItemInfoInLine(
          title: 'تاريخ النهاية',
          info: trip.endDate?.formatDateTime ?? '-',
        ),
        ItemInfoInLine(
          title: 'تقييم الزبون للسائق',
          widget: RatingBarWidget(initial: trip.driverRate),
        ),
        ItemInfoInLine(
          title: 'تقييم السائق للزبون',
          widget: RatingBarWidget(initial: trip.clientRate),
        ),
      ],
    );
  }
}
