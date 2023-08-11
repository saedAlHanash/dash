import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/util/checker_helper.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';

import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';

class CreateDriverRequest {
  String? name;
  String? surname;
  String? phoneNumber;
  Gender gender = Gender.mail;
  String? address;
  DateTime? birthdate;
  String? carBrand;
  String? carModel;
  String? carColor;
  num? seatsNumber;
  String? carNumber;
  num? carCategoryID;
  String? imei;
  int?id;

//------------------------
  bool isLoyaltySubscriber = false;

  UploadFile? imageFile;
  UploadFile? identityFile;
  UploadFile? contractFile;
  UploadFile? drivingLicenceFile;
  UploadFile? carMechanicFile;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'gender': gender.index,
      'address': address,
      'birthdate': birthdate?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'carBrand': carBrand,
      'carModel': carModel,
      'carColor': carColor,
      'seatsNumber': seatsNumber,
      'carNumber': carNumber,
      'carCategoryID': carCategoryID,
      'imei': imei,
      'id': id,
    };
  }

  bool validateRequest(BuildContext context) {
    if (name?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
      return false;
    }
    if (surname?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الكنية', context: context);
      return false;
    }
    if (phoneNumber?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في رقم الهاتف', context: context);
      return false;
    }
    var p = checkPhoneNumber(context, phoneNumber ?? '');

    if (p == null) {
      return false;
    }
    phoneNumber = p;

    if (address?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في العنوان', context: context);
      return false;
    }
    if (birthdate == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في تاريخ الميلاد', context: context);
      return false;
    }
    if (carBrand?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نوع السيارة', context: context);
      return false;
    }
    if (carColor?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في لون السيارة', context: context);
      return false;
    }
    if (seatsNumber == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في عدد مقاعد الجلوس', context: context);
      return false;
    }
    if (carNumber?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في رقم السيارة', context: context);
      return false;
    }
    if (carCategoryID == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في تصنيف السيارة', context: context);
      return false;
    }
    if (imei?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في معرف جهاز ال GPS', context: context);
      return false;
    }
    if (imageFile == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الصورة الشخصية', context: context);
      return false;
    }
    if (identityFile == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في صورة الهوية', context: context);
      return false;
    }
    if (contractFile == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في صورة العقد', context: context);
      return false;
    }
    if (drivingLicenceFile == null) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في صورة شهادة القيادة ', context: context);
      return false;
    }
    if (carMechanicFile == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في ميكانيك السيارة ', context: context);
      return false;
    }

    return true;
  }

  static CreateDriverRequest fromDriver(DriverModel driver) {
    final r = CreateDriverRequest();
    r.name = driver.fullName;
    r.id = driver.id;
    r.surname = driver.surname;
    r.phoneNumber = driver.phoneNumber;
    r.gender = Gender.values[driver.gender];
    r.address = driver.address;
    r.birthdate = driver.birthdate;
    r.carBrand = driver.carType.carBrand;
    r.carModel = driver.carType.carModel;
    r.carColor = driver.carType.carColor;
    r.seatsNumber = driver.carType.seatsNumber;
    r.carNumber = driver.carType.carNumber;
    r.carCategoryID = driver.carCategoryId;
    r.imei = driver.qarebDeviceimei;
    r.isLoyaltySubscriber = driver.loyalty;
    r.imageFile = UploadFile(fileBytes: null, initialImage: driver.avatar);
    r.identityFile = UploadFile(fileBytes: null, initialImage: driver.identity);
    r.contractFile = UploadFile(fileBytes: null, initialImage: driver.contract);
    r.drivingLicenceFile =
        UploadFile(fileBytes: null, initialImage: driver.drivingLicence);
    r.carMechanicFile = UploadFile(fileBytes: null, initialImage: driver.carMechanic);

    return r;
  }
}
