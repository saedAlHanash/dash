import 'dart:typed_data';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/table_widget.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/drivers/ui/pages/driver_wallet_page.dart';
import 'package:qareeb_dash/features/redeems/ui/widget/loyalty_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/images/round_image_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/driver_by_id_cubit/driver_by_id_cubit.dart';

class DriverInfoPage extends StatelessWidget {
  const DriverInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        text: 'معلومات السائق',
      ),
      body: BlocBuilder<DriverBuIdCubit, DriverBuIdInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final driver = state.result;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 120.0).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                30.0.verticalSpace,
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ItemImage(image: driver.avatar, text: 'الصورة الشخصية'),
                      ItemImage(image: driver.identity, text: 'صورة الهوية'),
                      ItemImage(image: driver.contract, text: 'صورة العقد'),
                      ItemImage(image: driver.drivingLicence, text: 'رخصة القيادة'),
                      ItemImage(image: driver.carMechanic, text: 'ميكانيك السيارة'),
                    ],
                  ),
                ),
                30.0.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: MyTableWidget(
                        children: {
                          'تصنيف ': driver.carCategories.name,
                          'رقم  ': driver.carType.carNumber,
                          'الشركة الصانعة': driver.carType.carBrand,
                          'لون': driver.carType.carColor,
                          'IMEI': driver.qarebDeviceimei,
                        },
                        title: 'معلومات السيارة',
                      ),
                    ),
                    Expanded(
                      child: MyTableWidget(
                        children: {
                          'اسم ': driver.fullName,
                          'العنوان ': driver.address,
                          'رقم هاتف  ': driver.phoneNumber,
                          'تاريخ ميلاد': driver.birthdate?.formatDate ?? '-',
                          'الجنس': driver.gender == 0 ? 'ذكر' : 'أنثى',
                        },
                        title: 'معلومات السائق',
                      ),
                    ),
                  ],
                ),
                const Divider(),
                30.0.verticalSpace,
                const LoyaltyWidget(),
                30.0.verticalSpace,
                const Divider(),
                DrawableText(
                  text: 'الرحلات',
                  matchParent: true,
                  size: 28.0.sp,
                  textAlign: TextAlign.center,
                  padding: const EdgeInsets.symmetric(vertical: 15.0).h,
                ),
                _NormalTripsCardWidget(driver: driver),
                _SharedTripsCardWidget(driver: driver),
                const Divider(),
                30.0.verticalSpace,
                WalletPage(id: driver.id),
                150.0.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}

class ItemImage extends StatelessWidget {
  const ItemImage({super.key, required this.image, required this.text, this.fileBytes});

  final String image;
  final Uint8List? fileBytes;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0).w,
      child: InkWell(
        onTap: () {
          NoteMessage.showImageDialog(context, image: image);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RoundImageWidget(
              url: image,
              fileBytes: fileBytes,
              height: 180.0.r,
              width: 180.0.r,
            ),
            8.0.verticalSpace,
            DrawableText(text: text),
          ],
        ),
      ),
    );
  }
}

class _NormalTripsCardWidget extends StatelessWidget {
  const _NormalTripsCardWidget({required this.driver});

  final DriverModel driver;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: Row(
        children: [
          const Expanded(
            child: DrawableText(
              text: 'الرحلات العادية',
              color: Colors.black,
              fontFamily: FontManager.cairoBold,
              matchParent: true,
            ),
          ),
          Expanded(
            child: DrawableText(
              text: 'المرفوضة : ${driver.receivedTripsCount}',
              color: Colors.black,
              fontFamily: FontManager.cairoBold,
            ),
          ),
          Expanded(
            child: DrawableText(
              text: 'الرحلات المرسلة  : ${driver.receivedTripsCount}',
              color: Colors.black,
              fontFamily: FontManager.cairoBold,
            ),
          ),
          Expanded(
            child: MyButton(
              text: 'تفاصيل',
              onTap: () {
                context.pushNamed(
                  GoRouteName.tripsPae,
                  queryParams: {
                    'driverId': driver.id.toString(),
                    // 'driverName': driver.fullName,
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SharedTripsCardWidget extends StatelessWidget {
  const _SharedTripsCardWidget({required this.driver});

  final DriverModel driver;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: Row(
        children: [
          const Expanded(
            child: DrawableText(
              text: 'الرحلات التشاركية',
              color: Colors.black,
              fontFamily: FontManager.cairoBold,
              matchParent: true,
            ),
          ),
          Spacer(),
          MyButton(
            text: 'تفاصيل',
            onTap: () {
              context.pushNamed(
                GoRouteName.sharedTripsPae,
                queryParams: {
                  'driverId': driver.id.toString(),
                  // 'driverName': driver.fullName,
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
