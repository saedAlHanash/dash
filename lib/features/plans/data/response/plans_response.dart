// import 'package:qareeb_dash/core/strings/fix_url.dart';
// import 'package:qareeb_models/companies/data/response/companies_response.dart';
// import 'package:qareeb_models/global.dart';
//
// class PlanResponse {
//   PlanResponse({
//     required this.result,
//   });
//
//   final PlanModel result;
//
//   factory PlanResponse.fromJson(Map<String, dynamic> json) {
//     return PlanResponse(
//       result: PlanModel.fromJson(json["result"] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "result": result.toJson(),
//       };
// }
//
// class PlansResponse {
//   PlansResponse({
//     required this.result,
//   });
//
//   final PlansResult result;
//
//   factory PlansResponse.fromJson(Map<String, dynamic> json) {
//     return PlansResponse(
//       result: PlansResult.fromJson(json["result"] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "result": result.toJson(),
//       };
// }
//
// class PlansResult {
//   PlansResult({
//     required this.totalCount,
//     required this.items,
//   });
//
//   final int totalCount;
//   final List<PlanModel> items;
//
//   factory PlansResult.fromJson(Map<String, dynamic> json) {
//     return PlansResult(
//       totalCount: json["totalCount"] ?? 0,
//       items: json["items"] == null
//           ? []
//           : List<PlanModel>.from(json["items"]!.map((x) => PlanModel.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "totalCount": totalCount,
//         "items": items.map((x) => x.toJson()).toList(),
//       };
// }
//
// class PlanModel {
//   PlanModel({
//     required this.id,
//     required this.price,
//     required this.name,
//     required this.description,
//     required this.imageUrl,
//     required this.maxPathMeters,
//     required this.maxDailyUsage,
//     required this.maxMonthlyUsage,
//     required this.isActive,
//     required this.type,
//     required this.enrollments,
//   });
//
//   final int id;
//   final num price;
//   final String name;
//   final String description;
//   final String imageUrl;
//   final num maxPathMeters;
//   final num maxDailyUsage;
//   final num maxMonthlyUsage;
//   final bool isActive;
//   final PlanType type;
//   final List<Enrollment> enrollments;
//
//   factory PlanModel.fromJson(Map<String, dynamic> json) {
//     return PlanModel(
//       id: json["id"] ?? 0,
//       price: json["price"] ?? 0,
//       name: json["name"] ?? "",
//       description: json["description"] ?? "",
//       imageUrl:fixAvatarImage( json["imageUrl"] ?? ""),
//       maxPathMeters: json["maxPathMeters"] ?? 0,
//       maxDailyUsage: json["maxDailyUsage"] ?? 0,
//       maxMonthlyUsage: json["maxMonthlyUsage"] ?? 0,
//       isActive: json["isActive"] ?? false,
//       type: PlanType.values[json["type"] ?? 0],
//       enrollments: json["enrollments"] == null
//           ? []
//           : List<Enrollment>.from(
//               json["enrollments"]!.map((x) => Enrollment.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "price": price,
//         "name": name,
//         "description": description,
//         "imageUrl": imageUrl,
//         "maxPathMeters": maxPathMeters,
//         "maxDailyUsage": maxDailyUsage,
//         "maxMonthlyUsage": maxMonthlyUsage,
//         "isActive": isActive,
//         "type": type.index,
//         "enrollments": enrollments.map((x) => x.toJson()).toList(),
//       };
// }
//
// class Enrollment {
//   Enrollment({
//     required this.id,
//     required this.companyId,
//     required this.company,
//     required this.planId,
//     required this.plan,
//     required this.userId,
//     required this.user,
//     required this.startDate,
//     required this.expiryDate,
//   });
//
//   final int id;
//   final num companyId;
//   final CompanyModel company;
//   final num planId;
//   final String plan;
//   final num userId;
//   final User user;
//   final DateTime? startDate;
//   final DateTime? expiryDate;
//
//   factory Enrollment.fromJson(Map<String, dynamic> json) {
//     return Enrollment(
//       id: json["id"] ?? 0,
//       companyId: json["companyId"] ?? 0,
//       company: CompanyModel.fromJson(json["company"] ?? {}),
//       planId: json["planId"] ?? 0,
//       plan: json["plan"] ?? "",
//       userId: json["userId"] ?? 0,
//       user: User.fromJson(json["user"] ?? {}),
//       startDate: DateTime.tryParse(json["startDate"] ?? ""),
//       expiryDate: DateTime.tryParse(json["expiryDate"] ?? ""),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "companyId": companyId,
//         "company": company.toJson(),
//         "planId": planId,
//         "plan": plan,
//         "userId": userId,
//         "user": user.toJson(),
//         "startDate": startDate?.toIso8601String(),
//         "expiryDate": expiryDate?.toIso8601String(),
//       };
// }
//
// class User {
//   User({
//     required this.id,
//     required this.userName,
//     required this.fullName,
//     required this.name,
//     required this.surname,
//     required this.phoneNumber,
//     required this.avatar,
//     required this.emergencyPhone,
//     required this.userType,
//     required this.accountBalance,
//   });
//
//   final int id;
//   final String userName;
//   final String fullName;
//   final String name;
//   final String surname;
//   final String phoneNumber;
//   final String avatar;
//   final String emergencyPhone;
//   final String userType;
//   final num accountBalance;
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json["id"] ?? 0,
//       userName: json["userName"] ?? "",
//       fullName: json["fullName"] ?? "",
//       name: json["name"] ?? "",
//       surname: json["surname"] ?? "",
//       phoneNumber: json["phoneNumber"] ?? "",
//       avatar: json["avatar"] ?? "",
//       emergencyPhone: json["emergencyPhone"] ?? "",
//       userType: json["userType"] ?? "",
//       accountBalance: json["accountBalance"] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userName": userName,
//         "fullName": fullName,
//         "name": name,
//         "surname": surname,
//         "phoneNumber": phoneNumber,
//         "avatar": avatar,
//         "emergencyPhone": emergencyPhone,
//         "userType": userType,
//         "accountBalance": accountBalance,
//       };
// }
