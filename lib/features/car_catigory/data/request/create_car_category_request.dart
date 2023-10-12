import 'package:flutter/material.dart';
import 'package:qareeb_dash/features/car_catigory/data/response/car_categories_response.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/util/note_message.dart';

class CreateCarCatRequest {
  String? name;

  num? driverRatio;

  UploadFile? file;

  num? nightKMOverCost;

  num? nightSharedKMOverCost;

  num? dayKMOverCost;

  num? sharedKMOverCost;

  num? sharedDriverRatio;

  num? minimumDayPrice;

  num? minimumNightPrice;

  int? id;

  num? normalOilRatio;

  num? normalGoldRatio;

  num? normalTiresRatio;

  num? sharedOilRatio;

  num? sharedGoldRatio;

  num? sharedTiresRatio;
  num? priceVariant;

  num? sharedMinimumDistanceInMeters;
  num? seatNumber;

  CreateCarCatRequest({
    this.id,
    this.name,
    this.file,
    this.nightKMOverCost,
    this.nightSharedKMOverCost,
    this.dayKMOverCost,
    this.sharedKMOverCost,
    this.sharedDriverRatio,
    this.minimumDayPrice,
    this.minimumNightPrice,
    this.driverRatio,
    this.normalOilRatio,
    this.normalGoldRatio,
    this.normalTiresRatio,
    this.sharedOilRatio,
    this.sharedGoldRatio,
    this.sharedTiresRatio,
    this.priceVariant,
    this.sharedMinimumDistanceInMeters,
    this.seatNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
      'DriverRatio': driverRatio,
      'NightKMOverCost': nightKMOverCost,
      'NightSharedKMOverCost': nightSharedKMOverCost,
      'DayKMOverCost': dayKMOverCost,
      'SharedKMOverCost': sharedKMOverCost,
      'SharedDriverRatio': sharedDriverRatio,
      'MinimumDayPrice': minimumDayPrice,
      'MinimumNightPrice': minimumNightPrice,
      'NormalOilRatio': normalOilRatio,
      'NormalGoldRatio': normalGoldRatio,
      'NormalTiresRatio': normalTiresRatio,
      'SharedOilRatio': sharedOilRatio,
      'SharedGoldRatio': sharedGoldRatio,
      'SharedTiresRatio': sharedTiresRatio,
      'priceVariant': priceVariant,
      'sharedMinimumDistanceInMeters': sharedMinimumDistanceInMeters,
      'seatNumber': seatNumber,
    };
  }

  CreateCarCatRequest fromCarCategory(CarCategory carCategory) {
    return CreateCarCatRequest(
      id: carCategory.id,
      name: carCategory.name,
      nightSharedKMOverCost: carCategory.nightSharedKmOverCost,
      dayKMOverCost: carCategory.dayKmOverCost,
      sharedKMOverCost: carCategory.sharedKmOverCost,
      sharedDriverRatio: carCategory.sharedDriverRatio,
      minimumDayPrice: carCategory.minimumDayPrice,
      minimumNightPrice: carCategory.minimumNightPrice,
      nightKMOverCost: carCategory.nightKmOverCost,
      driverRatio: carCategory.driverRatio,
      normalOilRatio: carCategory.normalOilRatio,
      normalGoldRatio: carCategory.normalGoldRatio,
      normalTiresRatio: carCategory.normalTiresRatio,
      sharedOilRatio: carCategory.sharedOilRatio,
      sharedGoldRatio: carCategory.sharedGoldRatio,
      sharedTiresRatio: carCategory.sharedTiresRatio,
      priceVariant: carCategory.priceVariant,
      sharedMinimumDistanceInMeters: carCategory.sharedMinimumDistanceInMeters,
      seatNumber: carCategory.seatNumber,
    )..file = UploadFile(fileBytes: null, initialImage: carCategory.imageUrl);
  }

  bool validateRequest(BuildContext context) {
    if (name?.isBlank ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
      return false;
    }
    if (file == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في صورة التصنيف', context: context);
      return false;
    }
    if (dayKMOverCost == 0) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في سعر الكيلو متر للرحلة العادية', context: context);
      return false;
    }
    if (sharedKMOverCost == 0) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في سعر الكيلو متر للرحلة التشاركية', context: context);
      return false;
    }

    if (sharedDriverRatio == 0) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في نسبة السائق للرحلة التشاركية', context: context);
      return false;
    }
    if (minimumDayPrice == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في أقل كلفة للرحلة', context: context);
      return false;
    }

    if (driverRatio == 0) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في نسبة السائق من الرحلة العادية', context: context);
      return false;
    }

    if (normalOilRatio == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نسبة الولاء', context: context);
      return false;
    }

    if (normalGoldRatio == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نسبة الولاء', context: context);
      return false;
    }

    if (normalTiresRatio == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نسبة الولاء', context: context);
      return false;
    }

    if (sharedOilRatio == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نسبة الولاء', context: context);
      return false;
    }

    if (sharedGoldRatio == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نسبة الولاء', context: context);
      return false;
    }

    if (sharedTiresRatio == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نسبة الولاء', context: context);
      return false;
    }

    if (priceVariant == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في متغير السعر', context: context);
      return false;
    }

    if (sharedMinimumDistanceInMeters == 0) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في أقل مسافة للرحلة التشاركية', context: context);
      return false;
    }

    return true;
  }
}

/*

 */
