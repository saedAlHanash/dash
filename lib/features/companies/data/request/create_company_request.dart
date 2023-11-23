import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/util/checker_helper.dart';
import 'package:qareeb_models/companies/data/response/companies_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/util/note_message.dart';

class CreateCompanyRequest {
  String? name;
  int? id;
  CompanyType type;
  String? managerPhone;
  UploadFile? file;

  CreateCompanyRequest({
    this.id,
    this.name,
    this.type = CompanyType.plans,
    this.managerPhone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id == 0 ? null : id,
      'Name': name,
      'Type': type.index,
      'ManagerPhone': managerPhone,
    };
  }

  CreateCompanyRequest fromCompany(CompanyModel model) {
    return CreateCompanyRequest(
      id: model.id,
      name: model.name,
      type: model.type,
      managerPhone: model.manager.phoneNumber,
    )..file =
        UploadFile(fileBytes: null, initialImage: model.imageUrl, nameField: 'ImageFile');
  }

  bool validateRequest(BuildContext context) {
    if (name.isBlank) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
      return false;
    }
    if (file == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في صورة الشركة', context: context);
      return false;
    }

    managerPhone = checkPhoneNumber(context, managerPhone ?? '');
    if (managerPhone.isBlank) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في رقم الهاتف', context: context);
      return false;
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
