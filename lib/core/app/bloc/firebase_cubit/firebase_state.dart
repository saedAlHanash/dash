// part of 'firebase_cubit.dart';
//
// class FirebaseInitial {
//
//   final FirebaseState? statuses;
//   final DriverLocation driverLocation;
//   final TrackingModel trackingModel;
//
//   const FirebaseInitial({
//     this.statuses,
//     required this.driverLocation,
//     required this.trackingModel,
//   });
//
//   factory FirebaseInitial.initial() {
//     return FirebaseInitial(
//       driverLocation: DriverLocation.fromJson({}),
//       trackingModel: TrackingModel.fromJson({}),
//     );
//   }
//
//   FirebaseInitial copyWith({
//     FirebaseState? statuses,
//     DriverLocation? driverLocation,
//     TrackingModel? trackingModel,
//   }) {
//     return FirebaseInitial(
//       statuses: statuses ?? this.statuses,
//       driverLocation: driverLocation ?? this.driverLocation,
//       trackingModel: trackingModel ?? this.trackingModel,
//     );
//   }
// }
