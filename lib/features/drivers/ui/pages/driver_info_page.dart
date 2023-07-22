import 'dart:typed_data';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/table_widget.dart';
import 'package:qareeb_dash/features/redeems/ui/widget/loyalty_widget.dart';
import 'package:qareeb_dash/features/wallet/ui/pages/my_wallet_page.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/images/round_image_widget.dart';
import '../../bloc/driver_by_id_cubit/driver_by_id_cubit.dart';

const json =
    '{"userName":"963968353685","fullName":"محمد  الهندي","name":"محمد ","fireBaseToken":"cUgXglBMQZy_Tn9mVu6IQI:APA91bFVxBDmFOlUFR9oiDpZIeVhz6NUJUI8nBqrMmuDEHZqfCqpjcRg6SXrgx5aPUtxfS5eRwLQwS4O5RkW0fD3gx6j9bOYBPM6mLLZkx61hFssUsS-JeqckOEBkpd3vAOiB8BkfbCx","carCategoryID":1,"surname":"الهندي","birthdate":"1986-07-08","address":"الروضة ","phoneNumber":"963968353685","carCategories":{"name":"كلاسيك","imageUrl":"1688550884143x.jpg","seatsNumber":0,"price":0.0,"driverRatio":75.0,"nightKMOverCost":2900,"dayKMOverCost":2300,"sharedKMOverCost":2600,"nightSharedKMOverCost":3000,"sharedDriverRatio":75.0,"minimumDayPrice":5000.0,"minimumNightPrice":7500.0,"gold":5.0,"oil":2.0,"tires":2.0,"clientLoyalty":0.0,"driverLoyalty":0.0,"companyRatio":16.0,"sharedGold":5.0,"sharedOil":2.0,"sharedTires":2.0,"sharedClientLoyalty":0.0,"sharedDriverLoyalty":0.0,"sharedCompanyRatio":16.0,"id":1},"currentLocation":{"clientId":0,"longitud":36.2893,"latitud":33.5228,"speed":null,"active":null},"carType":{"userId":12,"carBrand":"كيا ريو","carModel":"كيا ريو","carColor":"ابيض","carNumber":"581957","seatsNumber":4},"userType":1,"roleNames":null,"isActive":true,"emailConfirmationCode":"692585","creationTime":"2023-07-05","emailAddress":"Qareeb963968353685@gmail.com","imei":null,"qarebDeviceimei":"354778341877739","gender":0,"avatar":"1688559176144x.jpg","identity":"1688559176147x.jpg","contract":"1688559176147x.jpg","drivingLicence":"1688559176145x.jpg","carMechanic":"1688559176146x.jpg","password":"AQAAAAEAACcQAAAAEL10+0T58mzRxp6b/hzlBCd/aXhZem8qqlUs4/nky7lCima8+JPAZTbh0EbN+6x+Ew==","id":12}';

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
          if (state.statuses.loading) {
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
