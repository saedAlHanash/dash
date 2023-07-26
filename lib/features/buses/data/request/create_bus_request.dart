import 'package:flutter/src/widgets/framework.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/note_message.dart';
import '../../../super_user/data/request/create_super_user_request.dart';
import '../response/buses_response.dart';

class CreateBusRequest {
  CreateBusRequest({
    this.ime,
    this.id,
    this.driverName,
    this.driverPhone,
    this.busModel,
    this.busColor,
    this.busNumber,
    this.seatsNumber,
    this.institutionId,
  });

  String? ime;
  int? id;
  String? driverName;
  String? driverPhone;
  String? busModel;
  String? busColor;
  String? busNumber;
  num? seatsNumber;
  num? institutionId;

  factory CreateBusRequest.fromJson(Map<String, dynamic> json) {
    return CreateBusRequest(
      ime: json["ime"] ?? "",
      id: json["id"] ?? 0,
      driverName: json["driverName"] ?? "",
      driverPhone: json["driverPhone"] ?? "",
      busModel: json["busModel"] ?? "",
      busColor: json["busColor"] ?? "",
      busNumber: json["busNumber"] ?? "",
      seatsNumber: json["seatsNumber"] ?? 0,
      institutionId: json["institutionId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "ime": ime,
        "id": id,
        "driverName": driverName,
        "driverPhone": driverPhone,
        "busModel": busModel,
        "busColor": busColor,
        "busNumber": busNumber,
        "seatsNumber": seatsNumber,
        "institutionId": AppSharedPreference.getInstitutionId,
      };

  bool validateRequest(BuildContext context) {
    if (ime?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في IME', context: context);
      return false;
    }

    if (driverName?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم السائق', context: context);
      return false;
    }
    if (driverPhone?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في رقم الهاتف', context: context);
      return false;
    }
    var p = checkPhoneNumber(context, driverPhone ?? '');

    if (p == null) {
      return false;
    }
    driverPhone = p;

    if (busModel?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في نوع الباص', context: context);
      return false;
    }
    if (busColor?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في لون الباص', context: context);
      return false;
    }
    if (busNumber?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في رقم لوحة الباص', context: context);
      return false;
    }
    if (seatsNumber == null) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في عدد القاعد', context: context);
      return false;
    }

    return true;
  }

  CreateBusRequest fromBus(BusModel bus) {
    return CreateBusRequest(
      ime: bus.ime,
      id: bus.id,
      driverName: bus.driverName,
      driverPhone: bus.driverPhone,
      busModel: bus.busModel,
      busColor: bus.busColor,
      busNumber: bus.busNumber,
      seatsNumber: bus.seatsNumber,
      institutionId: bus.institutionId,
    );
  }
}
