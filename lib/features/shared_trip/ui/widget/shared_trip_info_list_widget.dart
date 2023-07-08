import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/shared_trip/data/response/shared_trip.dart';
import 'package:qareeb_dash/features/shared_trip/ui/widget/path_points_widget.dart';

import '../../../../core/widgets/item_info.dart';


class TripInfoListWidget extends StatelessWidget {
  const TripInfoListWidget({Key? key, required this.trip}) : super(key: key);

  final SharedTrip trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemInfoInLine(title: 'السائق', info: trip.driver.name),
        ItemInfoInLine(title: 'عدد المقاعد', info: trip.seatsNumber.toString()),
        ItemInfoInLine(title: 'سعر المقعد', info: trip.seatCost.formatPrice),
        ItemInfoInLine(title: 'المقاعد المحجوزة', info: trip.reservedSeats.toString()),
        ItemInfoInLine(title: 'تاريخ الإنشاء', info: trip.creationDate?.formatDateTime),
        ItemInfoInLine(title: 'تاريخ البداية', info: trip.startDate?.formatDateTime),
        ItemInfoInLine(title: 'تاريخ النهاية', info: trip.endDate?.formatDateTime),
        PathPointsWidgetWrap(list: trip.path.getTripPoints),
      ],
    );
  }
}
