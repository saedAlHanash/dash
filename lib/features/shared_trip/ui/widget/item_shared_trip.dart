import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/launcher_helper.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/images/image_multi_type.dart';
import 'package:qareeb_dash/features/shared_trip/data/response/shared_trip.dart';
import 'package:qareeb_dash/features/shared_trip/ui/widget/path_points_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/item_info.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../router/app_router.dart';
import '../../bloc/get_shared_trips_cubit/get_shared_trips_cubit.dart';

class ItemSharedTrip extends StatelessWidget {
  const ItemSharedTrip({super.key, required this.trip, this.withCard});

  final SharedTrip trip;
  final bool? withCard;

  @override
  Widget build(BuildContext context) {
    final widget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //التاريخ
        DrawableText(
          text: trip.dateTrip,
          color: AppColorManager.gray,
          fontFamily: FontManager.cairoBold,
          matchParent: true,
          textAlign: TextAlign.center,
          drawableEnd: (trip.isStart || trip.isEnd)
              ? Shimmer(
                  color: trip.isEnd ? Colors.amber : Colors.white60,
                  child: Container(
                    height: 20.0.r,
                    width: 20.0.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          trip.isEnd ? AppColorManager.ampere : AppColorManager.mainColor,
                    ),
                  ),
                )
              : null,
        ),

        PathPointsWidgetWrap(list: trip.path.getTripPoints),

        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ItemInfoInLine(
                title: 'المقاعد المحجوزة', info: trip.reservedSeats.toString()),
            TextButton(
              onPressed: () {
                NoteMessage.showCustomBottomSheet(
                  context,
                  child: ListView.builder(
                    itemCount: trip.sharedRequests.length,
                    itemBuilder: (context, index) {
                      final item = trip.sharedRequests[index].client;
                      var tripIconId = 0;
                      trip.path.getTripPoints.forEachIndexed((i, e1) {
                        if (e1.id == trip.sharedRequests[index].pickupPoint.id) {
                          tripIconId = i;
                        }
                      });
                      return MyCardWidget(
                        elevation: 0.0,
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            DrawableText(
                              text:
                                  '${item.fullName}  ( ${trip.sharedRequests[index].seatNumber} مقعد )',
                              color: Colors.black,
                              matchParent: true,
                              fontFamily: FontManager.cairoBold,
                              drawableAlin: DrawableAlin.between,
                              drawableEnd: IconButton(
                                onPressed: () {
                                  LauncherHelper.callPhone('+${item.phoneNumber}');
                                },
                                icon: const Icon(
                                  Icons.phone,
                                  color: AppColorManager.mainColor,
                                ),
                              ),
                            ),
                            const Divider(),
                            DrawableText(
                              text: 'نقطة الركوب: ',
                              color: Colors.black,
                              matchParent: true,
                              fontFamily: FontManager.cairoBold,
                              drawableAlin: DrawableAlin.between,
                              drawableEnd: DrawableText(
                                text: trip.sharedRequests[index].pickupPoint.arName,
                                color: Colors.black,
                                drawablePadding: 5.0.w,
                                drawableEnd: ImageMultiType(
                                  url: tripIconId.iconPoint,
                                  height: 20.0.r,
                                  width: 20.0.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              child: const DrawableText(
                text: 'عرض الزبائن',
                color: AppColorManager.mainColorDark,
                fontFamily: FontManager.cairoBold,
              ),
            ),
          ],
        ),
      ],
    );
    return InkWell(
      onTap: trip.isEnd
          ? null
          : () async {
              var result = await Navigator.pushNamed(context, RouteNames.activeSharedTrip,
                  arguments: trip.id);
              if (context.mounted) {
                context.read<GetSharedTripsCubit>().getSharesTrip(context);

                Future.delayed(const Duration(seconds: 1), () {
                  context.read<GetSharedTripsCubit>().getSharesTrip(context, tripState: [
                    SharedTripStatus.canceled,
                    SharedTripStatus.closed,
                  ]);
                });
              }
            },
      child: (withCard ?? true)
          ? MyCardWidget(
              elevation: 5.0,
              margin: const EdgeInsets.symmetric(vertical: 15.0).r,
              child: widget,
            )
          : widget,
    );
  }
}
