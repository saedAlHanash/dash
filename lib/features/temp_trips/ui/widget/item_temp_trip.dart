// import 'package:drawable_text/drawable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:qareeb_dash/core/extensions/extensions.dart';
// import 'package:image_multi_type/image_multi_type.dart';
// import 'package:qareeb_dash/router/go_route_pages.dart';
//
// import '../../../../core/util/my_style.dart';
// import '../../../../core/widgets/my_card_widget.dart';
// import '../../bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
// import '../../bloc/delete_temp_trip_cubit/delete_temp_trip_cubit.dart';
// import '../../data/response/TempTrips_response.dart';
//
// class ItemTempTrip extends StatelessWidget {
//   const ItemTempTrip({super.key, required this.item});
//
//   final TempTripModel item;
//
//   @override
//   Widget build(BuildContext context) {
//     return MyCardWidget(
//       margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
//       child: Row(
//         children: [
//           RoundImageWidget(
//             url: item.imageUrl,
//             height: 70.0.r,
//             width: 70.0.r,
//           ),
//           10.0.horizontalSpace,
//           Expanded(
//             child: Column(
//               children: [
//
//                 Row(
//                   children: [
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: item.name,
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: item.type,
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: item.type,
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: item.type,
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: '${item.type} %',
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: '${item.type} %',
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: '${item.type} %',
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               context.pushNamed(GoRouteName.createTempTrip, extra: item);
//             },
//             icon: const Icon(
//               Icons.edit,
//               color: Colors.amber,
//             ),
//           ),
//           BlocConsumer<DeleteTempTripCubit, DeleteTempTripInitial>(
//             listener: (context, state) {
//               context.read<AllTempTripsCubit>().getTempTrips(context);
//             },
//             listenWhen: (p, c) => c.statuses.done,
//             buildWhen: (p, c) => c.id == item.id,
//             builder: (context, state) {
//               if (state.statuses.loading) {
//                 return MyStyle.loadingWidget();
//               }
//               return IconButton(
//                 onPressed: () {
//                   context.read<DeleteTempTripCubit>().deleteTempTrip(context, id: item.id);
//                 },
//                 icon: const Icon(
//                   Icons.delete_forever,
//                   color: Colors.red,
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
