import 'package:flutter/material.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/util/note_message.dart';
import '../response/institutions_response.dart';

class CreateInstitutionRequest {
  String? name;
  Governorate government;
  InstitutionType type;
  String? atharKey;
  String? adminFirstName;
  String? adminSurname;
  String? emailAddress;
  String? address;
  String? phoneNumber;
  String? password;
  int? id;
  UploadFile? file;
  UploadFile? signature;

  CreateInstitutionRequest({
    this.id,
    this.name,
    this.file,
    this.government = Governorate.damascus,
    this.type = InstitutionType.college,
    this.atharKey,
    this.adminFirstName,
    this.adminSurname,
    this.emailAddress,
    this.address,
    this.phoneNumber,
    this.password,
    this.signature,
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Government': government.index,
      'Type': type.index,
      'AtharKey': atharKey,
      'AdminFirstName': adminFirstName,
      'AdminSurname': adminSurname,
      'EmailAddress': emailAddress,
      'Address': address,
      'PhoneNumber': phoneNumber,
      'Password': password,
      'Id': id,
    };
  }

  CreateInstitutionRequest fromInstitution(InstitutionModel model) {
    return CreateInstitutionRequest(
      id: model.id,
      name: model.name,
      government: Governorate.values[model.government],
      type: InstitutionType.values[model.type],
      atharKey: model.atharKey,
    )
      ..file = UploadFile(fileBytes: null, initialImage: model.imageUrl)
      ..signature = UploadFile(fileBytes: null, initialImage: model.signature);
  }

  bool validateRequest(BuildContext context) {
    if (name?.isBlank ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
      return false;
    }
    if (file == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في صورة المؤسسة', context: context);
      return false;
    }

    if (atharKey.isBlank) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في مفتاح أثر ', context: context);
      return false;
    }

    if (id == null || id == 0) {
      if (adminFirstName.isBlank || adminSurname.isBlank) {
        NoteMessage.showErrorSnackBar(message: 'خطأ في اسم المدير', context: context);
        return false;
      }
      if (emailAddress.isBlank) {
        NoteMessage.showErrorSnackBar(message: 'خطأ في بريد المدير', context: context);
        return false;
      }
      if (address.isBlank) {
        NoteMessage.showErrorSnackBar(message: 'خطأ في عنوان المدير ', context: context);
        return false;
      }
      if (phoneNumber.isBlank) {
        NoteMessage.showErrorSnackBar(
            message: 'خطأ في رقم هاتف المدير', context: context);
        return false;
      }
      if (password.isBlank) {
        NoteMessage.showErrorSnackBar(message: 'خطأ في كلمة المرور ', context: context);
        return false;
      }
    }

    return true;
  }
}

/*







File
string($binary)










Birthdate
string($date-time)




 */
