// import 'package:flutter/cupertino.dart';
//
// import '../../../../core/util/note_message.dart';
// import '../response/roles_response.dart';
//
// class CreateRoleRequest {
//   CreateRoleRequest({
//     this.id,
//     this.name,
//     this.displayName,
//     this.normalizedName,
//     this.description,
//   });
//
//   int? id;
//   String? name;
//   String? displayName;
//   String? normalizedName;
//   String? description;
//   List<String> grantedPermissions = <String>[];
//
//   factory CreateRoleRequest.fromJson(Map<String, dynamic> json) {
//     return CreateRoleRequest(
//       id: json["id"] ?? "",
//       name: json["name"] ?? "",
//       displayName: json["displayName"] ?? "",
//       normalizedName: json["normalizedName"] ?? "",
//       description: json["description"] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "displayName": displayName,
//         "normalizedName": normalizedName,
//         "description": description,
//         "grantedPermissions": grantedPermissions.map((x) => x).toList(),
//       };
//
//   bool validateRequest(BuildContext context) {
//     if (name?.isEmpty ?? true) {
//       NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: context);
//       return false;
//     }
//
//     return true;
//   }
//
//   static CreateRoleRequest fromRole(Role role) {
//     return CreateRoleRequest(
//       id: role.id,
//       name: role.name,
//       displayName: role.displayName,
//       normalizedName: role.normalizedName,
//       description: role.description,
//     )..grantedPermissions.addAll(role.grantedPermissions);
//   }
// }
