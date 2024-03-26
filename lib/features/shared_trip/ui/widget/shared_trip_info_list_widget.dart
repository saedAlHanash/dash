import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:map_package/map/data/models/my_marker.dart';
import 'package:qareeb_dash/features/shared_trip/ui/widget/path_points_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/shared_trip/data/response/shared_trip.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/item_info.dart';
import '../../../../core/widgets/saed_taple_widget.dart';

class TripInfoListWidget extends StatefulWidget {
  const TripInfoListWidget({Key? key, required this.trip}) : super(key: key);

  final SharedTrip trip;

  @override
  State<TripInfoListWidget> createState() => _TripInfoListWidgetState();
}

class _TripInfoListWidgetState extends State<TripInfoListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemInfoInLine(title: 'السائق', info: widget.trip.driver.fullName),
        ItemInfoInLine(
            title: 'عدد المقاعد المتاحة', info: widget.trip.seatNumber.toString()),
        ItemInfoInLine(
          title: 'فيعدد مقاعد السيارة',
          info: widget.trip.driver.carType.seatsNumber.toString(),
        ),
        ItemInfoInLine(title: 'سعر المقعد', info: widget.trip.seatCost.formatPrice),
        ItemInfoInLine(
          title: 'المقاعد المحجوزة',
          info: widget.trip.reservedSeats.toString(),
        ),
        ItemInfoInLine(
          title: 'التكلفة الكلية',
          info: (widget.trip.seatNumber * widget.trip.seatCost).toString(),
        ),
        Builder(builder: (context) {
          var x = 0.0;
          for (var e in widget.trip.path.edges) {
            x += e.distance;
          }
          return ItemInfoInLine(
            title: 'المسافة المقدرة',
            info: '${(x / 1000).toString()} km',
          );
        }),
        ItemInfoInLine(
            title: 'تاريخ الإنشاء',
            info: widget.trip.creationDate?.formatDateTime ?? '-'),
        ItemInfoInLine(
            title: 'تاريخ الجدولة',
            info: widget.trip.schedulingDate?.formatDateTime ?? '-'),
        ItemInfoInLine(
            title: 'تاريخ البداية', info: widget.trip.startDate?.formatDateTime ?? '-'),
        ItemInfoInLine(
            title: 'تاريخ النهاية', info: widget.trip.endDate?.formatDateTime ?? '-'),
        if (!isAgency)
          ItemInfoInLine(
            title: 'الزبائن',
            widget: TextButton(
              onPressed: () => showSharedRequest(widget.trip),
              child:  DrawableText(
                text: 'عرض',
                selectable: false,
                color: AppColorManager.mainColorDark,
                fontFamily: FontManager.cairoBold.name,
              ),
            ),
          ),
        PathPointsWidgetWrap(list: widget.trip.path.getTripPoints),
      ],
    );
  }

  void showSharedRequest(SharedTrip e) {
    NoteMessage.showMyDialog(
      context,
      child: SingleChildScrollView(
        child: SaedTableWidget(
          title: [
            'اسم الزبون',
            if (!isTrans) ...[
              'رقم الهاتف',
              'عدد المقاعد',
              'نقطة الركوب',
              'رمز النقطة',
              'حالة الدفع',
            ]
          ],
          data: e.sharedRequests.mapIndexed(
            (index, element) {
              final client = element.client;
              var tripIconId = 0;
              e.path.getTripPoints.forEachIndexed((i, e1) {
                if (e1.id == element.pickupPoint.id) {
                  tripIconId = i;
                }
              });
              return [
                client.fullName,
                if (!isTrans) ...[
                  client.phoneNumber,
                  element.seatNumber.toString(),
                  element.pickupPoint.arName,
                  ImageMultiType(
                    url: tripIconId.iconPoint,
                    height: 40.0.r,
                    width: 40.0.r,
                    fit: BoxFit.contain,
                  ),
                  element.status.arabicName,
                ],
              ];
            },
          ).toList(),
        ),
      ),
    );
  }
}
