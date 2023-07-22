import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/shared_trip/data/response/shared_trip.dart';
import 'package:qareeb_dash/features/shared_trip/ui/widget/path_points_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/widgets/images/image_multi_type.dart';
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
        ItemInfoInLine(title: 'السائق', info: widget.trip.driver.name),
        ItemInfoInLine(
            title: 'عدد المقاعد',
            info: widget.trip.driver.carType.seatsNumber.toString()),
        ItemInfoInLine(title: 'سعر المقعد', info: widget.trip.seatCost.formatPrice),
        ItemInfoInLine(
            title: 'المقاعد المحجوزة', info: widget.trip.reservedSeats.toString()),
        ItemInfoInLine(title: 'التكلفة الكلية', info: widget.trip.cost),
        ItemInfoInLine(
            title: 'تاريخ الإنشاء',
            info: widget.trip.creationDate?.formatDateTime ?? '-'),
        ItemInfoInLine(
            title: 'تاريخ البداية', info: widget.trip.startDate?.formatDateTime ?? '-'),
        ItemInfoInLine(
            title: 'تاريخ النهاية', info: widget.trip.endDate?.formatDateTime ?? '-'),
        ItemInfoInLine(
          title: 'الزبائن',
          widget: TextButton(
            onPressed: () => showSharedRequest(widget.trip),
            child: const DrawableText(
              text: 'عرض',
              color: AppColorManager.mainColorDark,
              fontFamily: FontManager.cairoBold,
            ),
          ),
        ),
        PathPointsWidgetWrap(list: widget.trip.path.getTripPoints),
      ],
    );
  }

  void showSharedRequest(SharedTrip e) {
    NoteMessage.showCustomBottomSheet(
      context,
      child: ListView.builder(
        itemCount: e.sharedRequests.length,
        itemBuilder: (context, index) {
          return SaedTableWidget(
            title: const [
              'اسم الزبون',
              'رقم الهاتف',
              'عدد المقاعد',
              'نقطة الركوب',
              'رمز النقطة',
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
                  client.phoneNumber,
                  element.seatNumber.toString(),
                  element.pickupPoint.arName,
                  ImageMultiType(
                    url: tripIconId.iconPoint,
                    height: 40.0.r,
                    width: 40.0.r,
                  ),
                ];
              },
            ).toList(),
          );
        },
      ),
    );
  }
}