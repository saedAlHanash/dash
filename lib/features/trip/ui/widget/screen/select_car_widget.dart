// import 'package:drawable_text/drawable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../core/strings/app_color_manager.dart';
// import '../../../../../core/util/note_message.dart';
// import '../../../../../core/widgets/my_button.dart';
// import '../../../../booking/bloc/trip_mediator_cubit/trip_mediator_cubit.dart';
// import '../../../bloc/check_trip_info_cubit/check_trip_info_cubit.dart';
// import '../../../bloc/create_trip_cubit/create_trip_cubit.dart';
// import '../../../data/request/check_trip_info_request.dart';
// import '../../../data/request/create_trip_request.dart';
// import '../../../data/shared/location_model.dart';
// import '../item_car_type_widget.dart';
// import '../location_name_widget.dart';
//
// class SelectCarWidget extends StatelessWidget {
//   const SelectCarWidget({Key? key}) : super(key: key);
//
//   void createTripListener(BuildContext context, CreateTripInitial state) {
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     late int carId = 0;
//
//     return BlocListener<CreateTripCubit, CreateTripInitial>(
//       listener: createTripListener,
//       child: Padding(
//         padding: const EdgeInsets.all(10).r,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: 1.0.sw,
//               child: DrawableText.title(text: 'تحديد نوع المركبة'),
//             ),
//             10.0.verticalSpace,
//             LocationNameWidget(
//                 isStart: true, name: tripMediator.startLocationName),
//             LocationNameWidget(
//                 isStart: false, name: tripMediator.endLocationName),
//             20.0.verticalSpace,
//             DrawableText(
//               text: 'يرجى اختيار فئة من المركبات الحالية',
//               color: AppColorManager.black,
//               size: 17.0.sp,
//               fontFamily: FontManager.cairoBold,
//             ),
//             Builder(builder: (context) {
//               final list =
//                   context.watch<CheckTripInfoCubit>().state.result.carsTypes;
//
//               return SizedBox(
//                 height: 120.0.h,
//                 width: 1.0.sw,
//                 child: StatefulBuilder(builder: (context, state) {
//                   return ListView.builder(
//                     itemCount: list.length,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (_, i) => ItemCarType(
//                       item: list[i],
//                       onTap: () {
//                         for (var e in list) {
//                           if (e.id == list[i].id) {
//                             carId = e.id;
//                             if (e.isSelected) return;
//                             e.isSelected = true;
//                             continue;
//                           }
//                           e.isSelected = false;
//                         }
//
//                         state(() {});
//                       },
//                     ),
//                   );
//                 }),
//               );
//             }),
//             20.0.verticalSpace,
//             MyButton(
//               text: 'اختر نوع الخدمة',
//               width: 1.0.sw,
//               onTap: () {
//                 if (carId == 0) {
//                   NoteMessage.showSnakeBar(
//                       message: 'يرجى اختيار نوع مركبة', context: context);
//                   return;
//                 }
//
//                 final tripMediator = context.read<BookingCubit>().state;
//
//                 final request = CreateTripRequest(
//                   currentLocationName: tripMediator.startLocationName,
//                   destinationName: tripMediator.endLocationName,
//                   currentLocation:
//                       LocationModel.fromLatLng(tripMediator.startLocation),
//                   destination:
//                       LocationModel.fromLatLng(tripMediator.endLocation),
//                   carCategoryId: carId,
//                   tripTime: CheckTripInfoRequest.getTripDuration(
//                       tripMediator.duration.toInt()),
//                   distance: tripMediator.distance.toInt(),
//                   duration: tripMediator.duration.toInt().toString(),
//                 );
//
//                 context
//                     .read<CreateTripCubit>()
//                     .createTrip(context, request: request);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
