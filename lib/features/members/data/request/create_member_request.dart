import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/shared_preferences.dart';
import '../response/member_response.dart';

class CreateMemberRequest {
  CreateMemberRequest({
    this.id,
    this.fullName,
    this.file,
    this.address,
    this.latLng,
  });

  int? id;
  String? fullName;
  UploadFile? file;
  String? address;
  LatLng? latLng;

  String? phoneNo;

  String? facility;

  String? idNumber;

  String? collegeIdNumber;

  //------- not in model------
  bool isSubscribe = true;

  Map<String, dynamic> toJson() => {
        "id": id,
        "FullName": fullName,
        "Address": address,
        "Late": latLng?.latitude,
        "Longe": latLng?.longitude,
        "PhoneNo": phoneNo,
        "Facility": facility,
        "IdNumber": idNumber,
        "CollegeIdNumber": collegeIdNumber,
        "InstitutionId": AppSharedPreference.getInstitutionId,
      };

  bool validateRequest(BuildContext context) {
    if (fullName?.isBlank ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في اسم الطالب ', context: context);
      return false;
    }
    if (address?.isBlank ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في عنوان الطالب ', context: context);
      return false;
    }

    var p = checkPhoneNumber(context, phoneNo ?? '');

    if (p == null) {
      return false;
    }
    phoneNo = p;

    return true;
  }

  CreateMemberRequest fromMember(Member model) {
    return CreateMemberRequest(
      id: model.id,
      fullName: model.fullName,
      file: UploadFile(initialImage: model.imageUrl),
      address: model.address,
      latLng: LatLng(model.late, model.longe),
    );
  }
}
/*
String FullName

String Address

num late

num Longe

String PhoneNo

String facility

String IdNumber

String CollegeIdNumber

 */
