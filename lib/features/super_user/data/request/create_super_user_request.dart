import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/shared_preferences.dart';
import '../response/super_users_response.dart';



class CreateSuperUserRequest {
  CreateSuperUserRequest({
     this.id,
     this.fullName,
     this.phone,
     this.userName,
     this.password,
     this.busId,
     this.institutionId,
  });

   int? id;
   String? fullName;
   String? phone;
   String? userName;
   String? password;
   num? busId;
   num? institutionId;

  factory CreateSuperUserRequest.fromJson(Map<String, dynamic> json){
    return CreateSuperUserRequest(
      id: json["id"] ?? 0,
      fullName: json["fullName"] ?? "",
      phone: json["phone"] ?? "",
      userName: json["userName"] ?? "",
      password: json["password"] ?? "",
      busId: json["busId"] ?? 0,
      institutionId: json["institutionId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "phone": phone,
    "userName": userName,
    "password": password,
    "busId": busId,
    "institutionId": AppSharedPreference.getInstitutionId,
  };


  bool validateRequest(BuildContext context) {
    if (fullName?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في اسم المشرف', context: context);
      return false;
    }
    var p = checkPhoneNumber(context, phone ?? '');

    if (p == null) {
      return false;
    }
    phone = p;

    if (userName?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: ' خطأ في حساب المشرف', context: context);
      return false;
    }
    if (password?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في كلمة المرور', context: context);
      return false;
    }
    if (busId==null|| busId!<=0) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الباص', context: context);
      return false;
    }


    return true;
  }

  CreateSuperUserRequest fromSuperUsers(SuperUserModel model) {
    return CreateSuperUserRequest(
      id: model.id,
      fullName: model.fullName,
      phone: model.phone,
      userName: model.userName,
      password: model.password,
      busId: model.busId,
      institutionId: model.institutionId,
    );
  }

}
