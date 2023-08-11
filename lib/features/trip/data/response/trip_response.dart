// import '../../../drivers/data/response/drivers_response.dart';
// import '../shared/location_model.dart';
//
// class TripResponse {
//   TripResponse({required this.result});
//
//   final TripResult? result;
//
//   factory TripResponse.fromJson(Map<String, dynamic> json) {
//     return TripResponse(
//       result: json['result'] == null
//           ? TripResult.fromJson({})
//           : TripResult.fromJson(json['result']),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         'result': result?.toJson(),
//       };
// }
//
// class TripsResponse {
//   TripsResponse({
//     required this.totalCount,
//     required this.items,
//   });
//
//   final int totalCount;
//   final List<TripResult> items;
//
//   factory TripsResponse.fromJson(Map<String, dynamic> json) {
//     return TripsResponse(
//       totalCount: json['result']["totalCount"] ?? 0,
//       items: json['result']["items"] == null
//           ? []
//           : List<TripResult>.from(json['result']["items"]!.map((x) => TripResult.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "totalCount": totalCount,
//         "items": items.map((x) => x.toJson()).toList(),
//       };
// }
//
// class TripResult {
//   TripResult({
//     required this.id,
//     required this.clientId,
//     required this.driverId,
//     required this.startDate,
//     required this.endDate,
//     required this.tripType,
//     required this.currentLocationName,
//     required this.destinationName,
//     required this.duration,
//     required this.isStarted,
//     required this.currentLocation,
//     required this.destination,
//     required this.isAccepted,
//     required this.note,
//     required this.distance,
//     required this.tripTimeDate,
//     required this.tripTime,
//     required this.tripFare,
//     required this.paidAmount,
//     required this.clientPhoneNumber,
//     required this.isDelved,
//     required this.isCanceled,
//     required this.cancelReason,
//     required this.driverName,
//     required this.clientName,
//     required this.creationTime,
//     required this.isConfirmed,
//     required this.isActive,
//     required this.isPaid,
//     required this.clientRate,
//     required this.driverRate,
//     required this.isClientRated,
//     required this.isDriverRated,
//     required this.carCategoryId,
//     required this.carType,
//     required this.coupons,
//     required this.couponsId,
//     required this.driver,
//   });
//
//   final int id;
//   final int clientId;
//   int driverId;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final int tripType;
//   final String currentLocationName;
//   final String destinationName;
//   final String duration;
//   bool isStarted;
//   final LocationModel currentLocation;
//   final LocationModel destination;
//   bool isAccepted;
//   final String note;
//   final double distance;
//   final DateTime? tripTimeDate;
//   final String tripTime;
//   final double tripFare;
//   final double paidAmount;
//   final String clientPhoneNumber;
//   bool isDelved;
//   bool isCanceled;
//   final String cancelReason;
//   String driverName;
//   final String clientName;
//   final DateTime? creationTime;
//   bool isConfirmed;
//   bool isActive;
//   bool isPaid;
//   final double clientRate;
//   double driverRate;
//   bool isClientRated;
//   bool isDriverRated;
//   final int carCategoryId;
//
//   final CarType carType;
//   final Coupons coupons;
//   final int couponsId;
//   final Driver driver;
//
//   factory TripResult.fromJson(Map<String, dynamic> json) {
//     return TripResult(
//       id: json['id'] ?? 0,
//       clientId: json['clientId'] ?? 0,
//       driverId: json['driverId'] ?? 0,
//       startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
//       endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate']),
//       tripType: json['tripType'] ?? 0,
//       currentLocationName: json['currentLocation_name'] ?? '',
//       destinationName: json['distnation_name'] ?? '',
//       duration: json['duration'] ?? '',
//       isStarted: json['isStarted'] ?? false,
//       currentLocation: json['currentLocation'] == null
//           ? LocationModel.fromJson({})
//           : LocationModel.fromJson(json['currentLocation']),
//       destination: json['distnation'] == null
//           ? LocationModel.fromJson({})
//           : LocationModel.fromJson(json['distnation']),
//       isAccepted: json['isAccepted'] ?? false,
//       note: json['note'] ?? '',
//       distance: json['distance'] ?? 0,
//       tripTimeDate:
//           json['tripTimeDate'] == null ? null : DateTime.parse(json['tripTimeDate']),
//       tripTime: json['tripTime'] ?? '',
//       tripFare: json['tripFare'] ?? 0,
//       paidAmount: json['paidAmount'] ?? 0,
//       clientPhoneNumber: json['client_PhoneNumber'] ?? '',
//       isDelved: json['isDilverd'] ?? false,
//       isCanceled: json['isCanceled'] ?? false,
//       cancelReason: json['cancelReasone'] ?? '',
//       driverName: json['driverName'] ?? '',
//       clientName: json['clietName'] ?? '',
//       creationTime:
//           json['creationTime'] == null ? null : DateTime.parse(json['creationTime']),
//       isConfirmed: json['isConfirmed'] ?? false,
//       isActive: json['isActive'] ?? false,
//       isPaid: json['isPaid'] ?? false,
//       clientRate: json['clientRate'] ?? 0,
//       driverRate: json['driverRate'] ?? 0,
//       isClientRated: json['isClientRated'] ?? false,
//       isDriverRated: json['isDriverRated'] ?? false,
//       carCategoryId: json['carCategoryId'] ?? 0,
//       carType: json['carType'] == null
//           ? CarType.fromJson({})
//           : CarType.fromJson(json['carType']),
//       coupons: json['coupons'] == null
//           ? Coupons.fromJson({})
//           : Coupons.fromJson(json['coupons']),
//       couponsId: json['couponsId'] ?? 0,
//       driver: Driver.fromJson(json["driver"] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'clientId': clientId,
//         'driverId': driverId,
//         'startDate': startDate?.toIso8601String(),
//         'endDate': endDate?.toIso8601String(),
//         'tripType': tripType,
//         'currentLocation_name': currentLocationName,
//         'distnation_name': destinationName,
//         'duration': duration,
//         'isStarted': isStarted,
//         'currentLocation': currentLocation.toJson(),
//         'distnation': destination.toJson(),
//         'isAccepted': isAccepted,
//         'note': note,
//         'distance': distance,
//         'tripTimeDate': tripTimeDate?.toIso8601String(),
//         'tripTime': tripTime,
//         'tripFare': tripFare,
//         'paidAmount': paidAmount,
//         'client_PhoneNumber': clientPhoneNumber,
//         'isDilverd': isDelved,
//         'isCanceled': isCanceled,
//         'cancelReasone': cancelReason,
//         'driverName': driverName,
//         'clietName': clientName,
//         'creationTime': creationTime?.toIso8601String(),
//         'isConfirmed': isConfirmed,
//         'isActive': isActive,
//         'isPaid': isPaid,
//         'clientRate': clientRate,
//         'driverRate': driverRate,
//         'isClientRated': isClientRated,
//         'isDriverRated': isDriverRated,
//         'carCategoryId': carCategoryId,
//         'carType': carType.toJson(),
//         'coupons': coupons.toJson(),
//         'couponsId': couponsId,
//         "driver": driver.toJson(),
//       };
// }
//
// class Coupons {
//   Coupons({
//     required this.id,
//     required this.couponName,
//     required this.couponCode,
//     required this.discountValue,
//     required this.isActive,
//     required this.expireDate,
//   });
//
//   final num id;
//   final String couponName;
//   final String couponCode;
//   final num discountValue;
//   final bool isActive;
//   final DateTime? expireDate;
//
//   factory Coupons.fromJson(Map<String, dynamic> json) {
//     return Coupons(
//       id: json['id'] ?? 0,
//       couponName: json['couponName'] ?? '',
//       couponCode: json['couponCode'] ?? '',
//       discountValue: json['discountValue'] ?? 0,
//       isActive: json['isActive'] ?? false,
//       expireDate: json['expireDate'] == null ? null : DateTime.parse(json['expireDate']),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'couponName': couponName,
//         'couponCode': couponCode,
//         'discountValue': discountValue,
//         'isActive': isActive,
//         'expireDate': expireDate?.toIso8601String(),
//       };
// }
//
// class Driver {
//   Driver({
//     required this.id,
//     required this.userName,
//     required this.fullName,
//     required this.name,
//     required this.surname,
//     required this.phoneNumber,
//     required this.imei,
//     required this.avatar,
//     required this.carType,
//   });
//
//   final int id;
//   final String userName;
//   final String fullName;
//   final String name;
//   final String surname;
//   final String phoneNumber;
//   final String imei;
//   final String avatar;
//   final CarType carType;
//
//   factory Driver.fromJson(Map<String, dynamic> json) {
//     return Driver(
//       id: json["id"] ?? 0,
//       userName: json["userName"] ?? "",
//       fullName: json["fullName"] ?? "",
//       name: json["name"] ?? "",
//       surname: json["surname"] ?? "",
//       phoneNumber: json["phoneNumber"] ?? "",
//       imei: json["imei"] ?? "",
//       avatar: json["avatar"] ?? "",
//       carType: CarType.fromJson(json["carType"] ?? {}),
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
//         "imei": imei,
//         "avatar": avatar,
//         "carType": carType.toJson(),
//       };
// }
