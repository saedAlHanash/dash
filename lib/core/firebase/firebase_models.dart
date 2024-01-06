// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../../temp.dart';
//
// class FirebaseTitle {
//   static const haveTrip = 'TripOffer'; //قبول الرحلة
//   static const cancelTrip = 'CancelTrip'; // الرحلة الغيت
//   static const deActivate = 'DeActivate'; // تم الغاء تفعيل الحساب
// }
//
// enum FirebaseState { accept, start, end, cancel, driverLocation, tracking }
//
// class DriverLocation {
//   final int userId;
//   final double lat;
//   final double lng;
//   final int isAvailable;
//
// //<editor-fold desc="Data Methods">
//
//   const DriverLocation({
//     required this.userId,
//     required this.lat,
//     required this.lng,
//     required this.isAvailable,
//   });
//
//   DriverLocation copyWith({
//     int? userId,
//     double? lat,
//     double? lng,
//     int? isAvailable,
//   }) {
//     return DriverLocation(
//       userId: userId ?? this.userId,
//       lat: lat ?? this.lat,
//       lng: lng ?? this.lng,
//       isAvailable: isAvailable ?? this.isAvailable,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'UserId': userId,
//       'CurrentLocation_longitud': lat,
//       'CurrentLocation_latitud': lng,
//       'IsAvailable': isAvailable,
//     };
//   }
//
//   factory DriverLocation.fromJson(Map<String, dynamic> map) {
//     return DriverLocation(
//       userId: map['UserId'] ?? 0,
//       lat: map['CurrentLocation_longitud'] ?? 0.0,
//       lng: map['CurrentLocation_latitud'] ?? 0.0,
//       isAvailable: map['IsAvailable'] ?? 0,
//     );
//   }
//
// //</editor-fold>
// }
//
// class TrackingModel {
//   final int clientId;
//   final double lat;
//   final double lng;
//   final String speed;
//   final String active;
//
// //<editor-fold desc="Data Methods">
//   const TrackingModel({
//     required this.clientId,
//     required this.lat,
//     required this.lng,
//     required this.speed,
//     required this.active,
//   });
//
//   LatLng getLatLng() => LatLng(lat, lng);
//
//   @override
//   String toString() {
//     return 'TrackingModel{lat:33.26541,lng: 36.231541}';
//   }
//
//   TrackingModel copyWith({
//     int? clientId,
//     double? lat,
//     double? lng,
//     String? speed,
//     String? active,
//   }) {
//     return TrackingModel(
//       clientId: clientId ?? this.clientId,
//       lat: lat ?? this.lat,
//       lng: lng ?? this.lng,
//       speed: speed ?? this.speed,
//       active: active ?? this.active,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'ClientId': clientId,
//       'lng': lng,
//       'lat': lat,
//       'speed': speed,
//       'active': active,
//     };
//   }
//
//   factory TrackingModel.fromJson(Map<String, dynamic> map) {
//     return TrackingModel(
//       clientId: map['ClientId'] ?? 0,
//       lng: double.parse(map['lng'] ?? '0.0'),
//       lat: double.parse(map['lat'] ?? '0.0'),
//       speed: map['speed'] ?? '',
//       active: map['active'] ?? '',
//     );
//   }
//
// //</editor-fold>
// }
//
// void showNotification(String title, String body) {
//   switch (title) {
//     case FirebaseTitle.haveTrip:
//       Note.showBigTextNotification(title: 'طلب جديد', body: 'لديك طلب جديد');
//       break;
//
//     case FirebaseTitle.cancelTrip:
//       Note.showBigTextNotification(title: 'إلغاء الرحلة', body: 'تم إلغاء الرحلة ');
//       break;
//
//     case FirebaseTitle.deActivate:
//       break;
//
//     default:
//       Note.showBigTextNotification(title: title, body: body);
//       break;
//   }
// }
