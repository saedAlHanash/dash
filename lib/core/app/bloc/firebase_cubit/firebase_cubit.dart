// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../firebase/firebase_models.dart';
//
// part 'firebase_state.dart';
//
// class FirebaseCubit extends Cubit<FirebaseInitial> {
//   FirebaseCubit() : super(FirebaseInitial.initial());
//
//   void sendState({
//     required FirebaseState firebaseState,
//     DriverLocation? driverLocation,
//     TrackingModel? trackingModel,
//   }) {
//
//     emit(state.copyWith(
//       statuses: firebaseState,
//       driverLocation: driverLocation,
//       trackingModel: trackingModel,
//     ));
//   }
// }
