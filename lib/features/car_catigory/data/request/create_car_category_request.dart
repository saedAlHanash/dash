import 'package:flutter/material.dart';
import 'package:qareeb_dash/features/car_catigory/data/response/car_categories_response.dart';

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

  num? companyLoyaltyRatio;

  int? id;

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
    this.companyLoyaltyRatio,
  });

  CreateCarCatRequest copyWith({
    String? name,
    num? driverRatio,
    UploadFile? file,
    num? nightKMOverCost,
    num? nightSharedKMOverCost,
    num? dayKMOverCost,
    num? sharedKMOverCost,
    num? sharedDriverRatio,
    num? minimumDayPrice,
    num? minimumNightPrice,
    num? companyLoyaltyRatio,
  }) {
    return CreateCarCatRequest(
      name: name ?? this.name,
      driverRatio: driverRatio ?? this.driverRatio,
      file: file ?? this.file,
      nightKMOverCost: nightKMOverCost ?? this.nightKMOverCost,
      nightSharedKMOverCost: nightSharedKMOverCost ?? this.nightSharedKMOverCost,
      dayKMOverCost: dayKMOverCost ?? this.dayKMOverCost,
      sharedKMOverCost: sharedKMOverCost ?? this.sharedKMOverCost,
      sharedDriverRatio: sharedDriverRatio ?? this.sharedDriverRatio,
      minimumDayPrice: minimumDayPrice ?? this.minimumDayPrice,
      minimumNightPrice: minimumNightPrice ?? this.minimumNightPrice,
      companyLoyaltyRatio: companyLoyaltyRatio ?? this.companyLoyaltyRatio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'driverRatio': driverRatio,
      'nightKMOverCost': nightKMOverCost,
      'nightSharedKMOverCost': nightSharedKMOverCost,
      'dayKMOverCost': dayKMOverCost,
      'sharedKMOverCost': sharedKMOverCost,
      'sharedDriverRatio': sharedDriverRatio,
      'minimumDayPrice': minimumDayPrice,
      'minimumNightPrice': minimumNightPrice,
      'companyLoyaltyRatio': companyLoyaltyRatio,
    };
  }

  CreateCarCatRequest fromCarCategory(CarCategory carCategory) {
    return CreateCarCatRequest(
      id: carCategory.id,
      name: carCategory.name,
      nightSharedKMOverCost: carCategory.nightKmOverCost,
      dayKMOverCost: carCategory.nightSharedKmOverCost,
      sharedKMOverCost: carCategory.dayKmOverCost,
      sharedDriverRatio: carCategory.sharedKmOverCost,
      minimumDayPrice: carCategory.sharedDriverRatio,
      minimumNightPrice: carCategory.minimumDayPrice,
      nightKMOverCost: carCategory.nightKmOverCost,
      driverRatio: carCategory.minimumNightPrice,
      companyLoyaltyRatio: carCategory.driverRatio,
    )..file = UploadFile(fileBytes: null, initialImage: carCategory.imageUrl);
  }

  bool validateRequest(BuildContext context) {
    if (name?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
      return false;
    }
    if (file == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في صورة التصنيف', context: context);
      return false;
    }
    if (dayKMOverCost == null) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في سعر الكيلو متر للرحلة العادية', context: context);
      return false;
    }
    if (sharedKMOverCost == null) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في سعر الكيلو متر للرحلة التشاركية', context: context);
      return false;
    }

    if (sharedDriverRatio == null) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في نسبة السائق للرحلة التشاركية', context: context);
      return false;
    }
    if (minimumDayPrice == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في أقل كلفة للرحلة', context: context);
      return false;
    }

    if (driverRatio == null) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في نسبة السائق من الرحلة العادية', context: context);
      return false;
    }
    if (companyLoyaltyRatio == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نسبة الولاء', context: context);
      return false;
    }

    return true;
  }
}
