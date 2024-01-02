import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:map_package/map/data/models/my_marker.dart';
import 'package:qareeb_dash/core/util/launcher_helper.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/features/shared_trip/ui/widget/path_points_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/shared_trip/data/response/shared_trip.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/item_info.dart';
import '../../../../core/widgets/my_card_widget.dart';
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
          fontFamily: FontManager.cairoBold.name,
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
                NoteMessage.showMyDialog(
                  context,
                  child: SizedBox(
                    height: 0.5.sh,
                    child: ListView.builder(
                      itemCount: trip.sharedRequests.length,
                      shrinkWrap: true,
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
                                fontFamily: FontManager.cairoBold.name,
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
                                fontFamily: FontManager.cairoBold.name,
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
                  ),
                );
              },
              child:  DrawableText(
                text: 'عرض الزبائن',
                selectable: false,
                color: AppColorManager.mainColorDark,
                fontFamily: FontManager.cairoBold.name,
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
              // await Navigator.pushNamed(context, RouteNames.activeSharedTrip,
              //      arguments: trip.id);
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

class ItemSharedTrip1 extends StatelessWidget {
  const ItemSharedTrip1({super.key, required this.item});

  final SharedTrip item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: MyCardWidget(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DrawableText(
                          size: 18.0.sp,
                          matchParent: true,
                          textAlign: TextAlign.center,
                          text: 'السائق',
                          color: Colors.black,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      Expanded(
                        child: DrawableText(
                          size: 18.0.sp,
                          matchParent: true,
                          textAlign: TextAlign.center,
                          text: 'المقاعد المحجوزة',
                          color: Colors.black,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      Expanded(
                        child: DrawableText(
                          size: 18.0.sp,
                          matchParent: true,
                          textAlign: TextAlign.center,
                          text: 'كلفة المقعد',
                          color: Colors.black,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      Expanded(
                        child: DrawableText(
                          size: 18.0.sp,
                          matchParent: true,
                          textAlign: TextAlign.center,
                          text: 'عدد النقاط',
                          color: Colors.black,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      Expanded(
                        child: DrawableText(
                          size: 18.0.sp,
                          matchParent: true,
                          textAlign: TextAlign.center,
                          text: 'تاريخ',
                          color: Colors.black,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      Expanded(
                        child: DrawableText(
                          size: 18.0.sp,
                          matchParent: true,
                          textAlign: TextAlign.center,
                          text: 'الحالة',
                          color: Colors.black,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: DrawableText(
                          matchParent: true,
                          size: 18.0.sp,
                          textAlign: TextAlign.center,
                          text: item.driver.fullName,
                          color: Colors.black,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      Expanded(
                        child: DrawableText(
                          matchParent: true,
                          size: 18.0.sp,
                          textAlign: TextAlign.center,
                          text: (item.driver.carType.seatsNumber - item.availableSeats)
                              .toString(),
                          color: Colors.black,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      Expanded(
                        child: DrawableText(
                          matchParent: true,
                          size: 18.0.sp,
                          textAlign: TextAlign.center,
                          text: (item.seatCost).formatPrice,
                          color: Colors.black,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      Expanded(
                        child: DrawableText(
                          matchParent: true,
                          size: 18.0.sp,
                          textAlign: TextAlign.center,
                          text: item.path.edges.length.toString(),
                          color: Colors.black,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      Expanded(
                        child: DrawableText(
                          matchParent: true,
                          size: 18.0.sp,
                          textAlign: TextAlign.center,
                          text: item.schedulingDate?.formatDateTime ?? '',
                          color: Colors.black,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                      Expanded(
                        child: DrawableText(
                          matchParent: true,
                          size: 18.0.sp,
                          textAlign: TextAlign.center,
                          text: item.tripStatus.sharedTripName(),
                          color: Colors.black,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                NoteMessage.showCustomBottomSheet(
                  context,
                  child: ListView.builder(
                    itemCount: item.sharedRequests.length,
                    itemBuilder: (context, index) {
                      final itemRequest = item.sharedRequests[index].client;
                      var tripIconId = 0;
                      item.path.getTripPoints.forEachIndexed((i, e1) {
                        if (e1.id == item.sharedRequests[index].pickupPoint.id) {
                          tripIconId = i;
                        }
                      });
                      return MyCardWidget(
                        elevation: 0.0,
                        margin: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: DrawableText(
                                text: itemRequest.fullName,
                                color: Colors.black,
                                matchParent: true,
                                drawablePadding: 15.0.w,
                                drawableAlin: DrawableAlin.withText,
                                fontFamily: FontManager.cairoBold.name,
                                drawableEnd: DrawableText(
                                  text:
                                      'عدد المقاعد:  ${item.sharedRequests[index].seatNumber}',
                                  color: Colors.black,
                                  fontFamily: FontManager.cairoBold.name,
                                ),
                              ),
                            ),
                            Expanded(
                              child: DrawableText(
                                text: 'نقطة الركوب: ',
                                color: Colors.black,
                                fontFamily: FontManager.cairoBold.name,
                                drawableEnd: DrawableText(
                                  text: item.sharedRequests[index].pickupPoint.arName,
                                  color: Colors.black,
                                  drawablePadding: 5.0.w,
                                  drawableEnd: ImageMultiType(
                                    url: tripIconId.iconPoint,
                                    height: 40.0.r,
                                    width: 40.0.r,
                                  ),
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
              child:  DrawableText(
                text: 'الزبائن',
                color: AppColorManager.mainColorDark,
                fontFamily: FontManager.cairoBold.name,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
