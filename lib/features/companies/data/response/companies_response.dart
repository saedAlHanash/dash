// import 'package:qareeb_dash/core/strings/enum_manager.dart';
// import 'package:qareeb_dash/core/strings/fix_url.dart';
//
// class CompanyResponse {
//   CompanyResponse({
//     required this.result,
//   });
//
//   final CompanyModel result;
//
//   factory CompanyResponse.fromJson(Map<String, dynamic> json) {
//     return CompanyResponse(
//       result: CompanyModel.fromJson(json["result"] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "result": result.toJson(),
//       };
// }
//
// class CompaniesResponse {
//   CompaniesResponse({
//     required this.result,
//   });
//
//   final CompaniesResult result;
//
//   factory CompaniesResponse.fromJson(Map<String, dynamic> json) {
//     return CompaniesResponse(
//       result: CompaniesResult.fromJson(json["result"] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "result": result.toJson(),
//       };
// }
//
// class CompaniesResult {
//   CompaniesResult({
//     required this.totalCount,
//     required this.items,
//   });
//
//   final int totalCount;
//   final List<CompanyModel> items;
//
//   factory CompaniesResult.fromJson(Map<String, dynamic> json) {
//     return CompaniesResult(
//       totalCount: json["totalCount"] ?? 0,
//       items: json["items"] == null
//           ? []
//           : List<CompanyModel>.from(json["items"]!.map((x) => CompanyModel.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "totalCount": totalCount,
//         "items": items.map((x) => x.toJson()).toList(),
//       };
// }
//
// class CompanyModel {
//   CompanyModel({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.type,
//     required this.isActive,
//     required this.manager,
//   });
//
//   final int id;
//   final String name;
//   final String imageUrl;
//   final CompanyType type;
//   final bool isActive;
//   final Manager manager;
//
//   factory CompanyModel.fromJson(Map<String, dynamic> json) {
//     return CompanyModel(
//       id: json["id"] ?? 0,
//       name: json["name"] ?? "",
//       imageUrl: fixAvatarImage(json["imageUrl"] ?? ""),
//       type: CompanyType.values[json["type"] ?? 0],
//       isActive: json["isActive"] ?? false,
//       manager: Manager.fromJson(json["manager"] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "imageUrl": imageUrl,
//         "type": type.index,
//         "isActive": isActive,
//         "manager": manager.toJson(),
//       };
// }
//
// class Manager {
//   Manager({
//     required this.id,
//     required this.fullName,
//     required this.phoneNumber,
//     required this.avatar,
//   });
//
//   final int id;
//   final String fullName;
//   final String phoneNumber;
//   final String avatar;
//
//   factory Manager.fromJson(Map<String, dynamic> json) {
//     return Manager(
//       id: json["id"] ?? 0,
//       fullName: json["fullName"] ?? "",
//       phoneNumber: json["phoneNumber"] ?? "",
//       avatar: json["avatar"] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "fullName": fullName,
//         "phoneNumber": phoneNumber,
//         "avatar": avatar,
//       };
// }
