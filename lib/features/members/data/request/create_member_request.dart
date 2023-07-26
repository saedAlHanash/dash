
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';


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

  //------- not in model------
  bool isSubscribe = true;


  Map<String, dynamic> toJson() => {
        "id": id,
        "FullName": fullName,
        "Address": address,
        "Late": latLng?.latitude,
        "Longe": latLng?.longitude,
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
    if (latLng == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في موقع الخريطة', context: context);
      return false;
    }
    if (file == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الصورة', context: context);
      return false;
    }

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

 */
