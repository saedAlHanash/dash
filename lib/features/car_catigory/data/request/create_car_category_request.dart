import 'package:flutter/material.dart';
import 'package:qareeb_models/car_catigory/data/response/car_categories_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/util/note_message.dart';

class CreateCarCatRequest {
  int? id;
  String? name;
  UploadFile? file;

  //Driver ration
  num? driverRatio;
  num? sharedDriverRatio;
  num? planDriverRation;

  //km cost
  num? dayKMOverCost;
  num? nightKMOverCost;
  num? sharedKMOverCost;
  num? planKmCost;
  num? nightSharedKMOverCost;

  //min price
  num? minimumDayPrice;
  num? minimumNightPrice;
  num? planMinimumCost;

  //loyalty
  num? normalOilRatio;
  num? normalGoldRatio;
  num? normalTiresRatio;
  num? normalGasRatio;
  num? sharedOilRatio;
  num? sharedGoldRatio;
  num? sharedTiresRatio;
  num? sharedGasRatio;
  num? syrianAuthorityRatio;

  num? priceVariant;
  num? sharedMinimumDistanceInMeters;
  num? planMinimumDistanceInMeters;
  num? seatNumber;
  CarCategoryType carCategoryType;

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
    this.normalGasRatio,
    this.sharedOilRatio,
    this.sharedGoldRatio,
    this.sharedTiresRatio,
    this.sharedGasRatio,
    this.syrianAuthorityRatio,
    this.priceVariant,
    this.sharedMinimumDistanceInMeters,
    this.planMinimumDistanceInMeters,
    this.seatNumber,
    this.carCategoryType = CarCategoryType.trips,
    this.planDriverRation,
    this.planKmCost,
    this.planMinimumCost,
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
      'NormalGasRatio': normalGasRatio,
      'SharedOilRatio': sharedOilRatio,
      'SharedGoldRatio': sharedGoldRatio,
      'SharedTiresRatio': sharedTiresRatio,
      'sharedGasRatio': sharedGasRatio,
      'syrianAuthorityRatio': syrianAuthorityRatio,
      'priceVariant': priceVariant,
      'sharedMinimumDistanceInMeters': sharedMinimumDistanceInMeters,
      'PlanMinimumDistanceInMeters': planMinimumDistanceInMeters,
      'seatNumber': seatNumber,
      'PlanDriverRation': planDriverRation,
      'PlanKmCost': planKmCost,
      'PlanMinimumCost': planMinimumCost,
      'carCategoryType': carCategoryType.index,
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
      normalGasRatio: carCategory.normalGasRatio,
      sharedOilRatio: carCategory.sharedOilRatio,
      sharedGoldRatio: carCategory.sharedGoldRatio,
      sharedTiresRatio: carCategory.sharedTiresRatio,
      sharedGasRatio: carCategory.sharedGasRatio,
      syrianAuthorityRatio: carCategory.syrianAuthorityRatio,
      priceVariant: carCategory.priceVariant,
      sharedMinimumDistanceInMeters: carCategory.sharedMinimumDistanceInMeters,
      planMinimumDistanceInMeters: carCategory.planMinimumDistanceInMeters,
      seatNumber: carCategory.seatNumber,
      carCategoryType: carCategory.carCategoryType,
      planDriverRation: carCategory.planDriverRation,
      planKmCost: carCategory.planKmCost,
      planMinimumCost: carCategory.planMinimumCost,
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

    if (normalGasRatio == 0) {
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
    if (sharedGasRatio == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نسبة الولاء', context: context);
      return false;
    }
    if (syrianAuthorityRatio == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نسبة الهيئة الناظمة', context: context);
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
    if (planDriverRation == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في متغير السعر', context: context);
      return false;
    }
    if (planKmCost == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في متغير السعر', context: context);
      return false;
    }
    if (planMinimumCost == 0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في متغير السعر', context: context);
      return false;
    }

    if (sharedMinimumDistanceInMeters == 0) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في أقل مسافة للرحلة التشاركية', context: context);
      return false;
    }
    if (planMinimumDistanceInMeters == 0) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في أقل مسافة لرحلة الاشتراكات', context: context);
      return false;
    }

    return true;
  }
}

/*

 */
