// import 'package:flutter/material.dart';
// import 'package:qareeb_dash/core/extensions/extensions.dart';
//
// import '../../../../core/api_manager/api_service.dart';
// import '../../../../core/strings/enum_manager.dart';
// import '../../../../core/util/note_message.dart';
// import '../../../../core/util/shared_preferences.dart';
// import '../../../super_user/data/request/create_super_user_request.dart';
//
// class CreateSubscriptionRequest {
//   CreateSubscriptionRequest({
//     this.name,
//     this.supscriptionDate,
//     this.expirationDate,
//   });
//
//   int? id;
//   String? name;
//   DateTime? supscriptionDate;
//   DateTime? expirationDate;
//
//   factory CreateSubscriptionRequest.fromJson(Map<String, dynamic> json) {
//     return CreateSubscriptionRequest(
//       name: json["name"] ?? "",
//       supscriptionDate: DateTime.tryParse(json["supscriptionDate"] ?? ""),
//       expirationDate: DateTime.tryParse(json["expirationDate"] ?? ""),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "supscriptionDate": supscriptionDate?.toIso8601String(),
//         "expirationDate": expirationDate?.toIso8601String(),
//         "institutionId": AppSharedPreference.getInstitutionId,
//       };
//
  //   bool validateRequest(BuildContext context) {
  //     if (supscriptionDate == null) {
  //       NoteMessage.showErrorSnackBar(message: 'يرجى تحديد التاريخ', context: context);
  //       return false;
  //     }
  //     if (expirationDate == null) {
  //       NoteMessage.showErrorSnackBar(message: 'يرجى تحديد التاريخ', context: context);
  //       return false;
  //     }
  //     return true;
  //   }
// }
