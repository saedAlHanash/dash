import 'dart:convert';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';

import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/images/round_image_widget.dart';

final json =
    '{"userName":"963968353685","fullName":"محمد  الهندي","name":"محمد ","fireBaseToken":"cUgXglBMQZy_Tn9mVu6IQI:APA91bFVxBDmFOlUFR9oiDpZIeVhz6NUJUI8nBqrMmuDEHZqfCqpjcRg6SXrgx5aPUtxfS5eRwLQwS4O5RkW0fD3gx6j9bOYBPM6mLLZkx61hFssUsS-JeqckOEBkpd3vAOiB8BkfbCx","carCategoryID":1,"surname":"الهندي","birthdate":"1986-07-08","address":"الروضة ","phoneNumber":"963968353685","carCategories":{"name":"كلاسيك","imageUrl":"1688550884143x.jpg","seatsNumber":0,"price":0.0,"driverRatio":75.0,"nightKMOverCost":2900,"dayKMOverCost":2300,"sharedKMOverCost":2600,"nightSharedKMOverCost":3000,"sharedDriverRatio":75.0,"minimumDayPrice":5000.0,"minimumNightPrice":7500.0,"gold":5.0,"oil":2.0,"tires":2.0,"clientLoyalty":0.0,"driverLoyalty":0.0,"companyRatio":16.0,"sharedGold":5.0,"sharedOil":2.0,"sharedTires":2.0,"sharedClientLoyalty":0.0,"sharedDriverLoyalty":0.0,"sharedCompanyRatio":16.0,"id":1},"currentLocation":{"clientId":0,"longitud":36.2893,"latitud":33.5228,"speed":null,"active":null},"carType":{"userId":12,"carBrand":"كيا ريو","carModel":"كيا ريو","carColor":"ابيض","carNumber":"581957","seatsNumber":4},"userType":1,"roleNames":null,"isActive":true,"emailConfirmationCode":"692585","creationTime":"2023-07-05","emailAddress":"Qareeb963968353685@gmail.com","imei":null,"qarebDeviceimei":"354778341877739","gender":0,"avatar":"1688559176144x.jpg","identity":"1688559176147x.jpg","contract":"1688559176147x.jpg","drivingLicence":"1688559176145x.jpg","carMechanic":"1688559176146x.jpg","password":"AQAAAAEAACcQAAAAEL10+0T58mzRxp6b/hzlBCd/aXhZem8qqlUs4/nky7lCima8+JPAZTbh0EbN+6x+Ew==","id":12}';

class DriverInfoPage extends StatelessWidget {
  const DriverInfoPage({super.key, required this.driver});

  final DriverModel driver;

  @override
  Widget build(BuildContext context) {
    final driver = DriverModel.fromJson(jsonDecode(json));
    return Scaffold(
      appBar: const AppBarWidget(
        text: 'معلومات السائق',
      ),
      body: Column(
        children: [
          10.0.verticalSpace,
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
        ],
      ),
    );
  }
}

class ItemImage extends StatelessWidget {
  const ItemImage({super.key, required this.image, required this.text});

  final String image;

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
