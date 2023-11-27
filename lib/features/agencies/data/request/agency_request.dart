import 'package:flutter/src/widgets/framework.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/note_message.dart';
import 'package:qareeb_models/agencies/data/response/agency_response.dart';

class AgencyRequest {
  AgencyRequest({
    this.name,
    this.file,
    this.id,
    this.adminFirstName,
    this.adminSurname,
    this.emailAddress,
    this.address,
    this.birthdate,
    this.phoneNumber,
    this.password,
    this.agencyRatio,
    this.isActive,
  });

  String? name;
  UploadFile? file;
  int? id;
  String? adminFirstName;
  String? adminSurname;
  String? emailAddress;
  String? address;
  DateTime? birthdate;
  String? phoneNumber;
  String? password;
  num? agencyRatio;
  bool? isActive;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'Id': id,
      'adminFirstName': adminFirstName ?? name ?? '-',
      'adminSurname': adminSurname ?? '-',
      'emailAddress': emailAddress,
      'address': address ?? '-',
      'birthdate': DateTime.now().toIso8601String(),
      'phoneNumber': phoneNumber,
      'password': password,
      'agencyRatio': agencyRatio,
      'IsActive': isActive,
    };
  }

  void initFromAgency(Agency? agency) {
    if (agency == null) return;
    id = agency.id;
    name = agency.name;
    file = UploadFile(fileBytes: null, initialImage: agency.imageUrl);
    agencyRatio = agency.agencyRatio;
    isActive = agency.isActive;
  }

  bool validateRequest(BuildContext context) {
    if (name?.isBlank ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
      return false;
    }
    if (file == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في صورة الوكيل', context: context);
      return false;
    }

    if (agencyRatio == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نسبة الوكيل', context: context);
      return false;
    }

    if (id == null || id == 0) {
      if (emailAddress.isBlank) {
        NoteMessage.showErrorSnackBar(
            message: 'خطأ في اسم مستخدم الوكيل', context: context);
        return false;
      }

      if (phoneNumber.isBlank) {
        NoteMessage.showErrorSnackBar(
            message: 'خطأ في رقم هاتف الوكيل', context: context);
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
