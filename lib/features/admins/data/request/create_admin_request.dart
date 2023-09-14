import 'package:flutter/material.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/note_message.dart';

class CreateAdminRequest {
  CreateAdminRequest({
    this.userName,
    this.name,
    this.id,
    this.surname,
    this.address,
    this.birthdate,
    this.isActive = true,
    this.phoneNumber,
    this.emailAddress,
    this.password,
  });

  int? id;
  String? userName;
  String? name;
  String? surname;
  String? emailAddress;
  String? address;
  DateTime? birthdate;
  bool? isActive;
  String? phoneNumber;
  List<String> roleNames = <String>[];
  String? password;

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "name": name,
        "surname": surname,
        "emailAddress": emailAddress,
        "address": address,
        "birthdate": birthdate?.toIso8601String(),
        "isActive": isActive,
        "phoneNumber": phoneNumber,
        "roleNames": roleNames.map((x) => x).toList(),
        "password": password,
      };

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
    if (roleNames.isEmpty) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الصلاحيات', context: context);
      return false;
    }
    if (!checkEmail(context, emailAddress)) {
      NoteMessage.showErrorSnackBar(message: 'حطأ في البريد', context: context);
      return false;
    }
    if (password == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في كلمة السر ', context: context);
      return false;
    }

    return true;
  }

  static CreateAdminRequest fromAdmin(DriverModel adminModel) {
    return CreateAdminRequest(
      userName: adminModel.userName,
      name: adminModel.name,
      id: adminModel.id,
      surname: adminModel.surname,
      address: adminModel.address,
      birthdate: adminModel.birthdate,
      isActive: adminModel.isActive,
      phoneNumber: adminModel.phoneNumber,
      emailAddress: adminModel.emailAddress,
    )..roleNames.addAll(adminModel.roleNames);
  }
}
