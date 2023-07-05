import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../data/response/trip_response.dart';
import '../widget/trip_info_list_widget.dart';

class TripInfoPage extends StatelessWidget {
  const TripInfoPage({Key? key, this.trip}) : super(key: key);
  final TripResult? trip;

  @override
  Widget build(BuildContext context) {
    final trip = this.trip ?? AppSharedPreference.getCashedTrip();
    return Scaffold(
      appBar: const AppBarWidget(),
      body: GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails details) {
          if (details.delta.dy > 0) {
            Navigator.pop(context);
          } else if (details.delta.dy < 0) {
            // Handle slide up event
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DrawableText(
                text: 'تفاصيل الطلب',
                matchParent: true,
                underLine: true,
                color: Colors.black,
              ),
              20.0.verticalSpace,
              TripInfoListWidget(trip: trip),
            ],
          ),
        ),
      ),
    );
  }
}
// DrawableText(
//   text: 'رحلة جارية',
//
//   color: Colors.black,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// const DrawableText(
//   text: 'الانطلاق: ',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.currentLocationName,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.gray,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// const DrawableText(
//   text: 'الوجهة: ',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.destinationName,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.gray,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// 40.0.verticalSpace,
// const DrawableText(
//   text: 'السائق',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.driverName,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.gray,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// const DrawableText(
//   text: 'نوع السيارة',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.carType.carBrand,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.gray,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// const DrawableText(
//   text: 'رقم السيارة',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.carType.carNumber,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.gray,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// const DrawableText(
//   text: 'رقم الهاتف',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.clientPhoneNumber,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.mainColor,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// const DrawableText(
//   text: 'التكلفة',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.getCost,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.mainColor,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
