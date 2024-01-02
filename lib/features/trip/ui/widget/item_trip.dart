// import 'package:drawable_text/drawable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
// import 'package:qareeb_models/trip_process/data/response/trip_response.dart';
//
// import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';
// import '../../../../core/widgets/my_card_widget.dart';
// import '../../../../router/go_route_pages.dart';
//
// class ItemTrip extends StatelessWidget {
//   const ItemTrip({super.key, required this.item});
//
//   final Trip item;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         context.pushNamed(GoRouteName.tripInfo, queryParams: {'id': item.id.toString()});
//       },
//       child: MyCardWidget(
//         margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: DrawableText(
//                           size: 18.0.sp,
//                           matchParent: true,
//                           textAlign: TextAlign.center,
//                           text: 'انطلاق',
//                           color: Colors.black,
//                           fontFamily: FontManager.cairoBold.name,
//                         ),
//                       ),
//                       Expanded(
//                         child: DrawableText(
//                           size: 18.0.sp,
//                           matchParent: true,
//                           textAlign: TextAlign.center,
//                           text: 'وجهة',
//                           color: Colors.black,
//                           fontFamily: FontManager.cairoBold.name,
//                         ),
//                       ),
//                       Expanded(
//                         child: DrawableText(
//                           size: 18.0.sp,
//                           matchParent: true,
//                           textAlign: TextAlign.center,
//                           text: 'الزبون',
//                           color: Colors.black,
//                           fontFamily: FontManager.cairoBold.name,
//                         ),
//                       ),
//                       Expanded(
//                         child: DrawableText(
//                           size: 18.0.sp,
//                           matchParent: true,
//                           textAlign: TextAlign.center,
//                           text: 'السائق',
//                           color: Colors.black,
//                           fontFamily: FontManager.cairoBold.name,
//                         ),
//                       ),
//                       Expanded(
//                         child: DrawableText(
//                           size: 18.0.sp,
//                           matchParent: true,
//                           textAlign: TextAlign.center,
//                           text: 'الكلفة',
//                           color: Colors.black,
//                           fontFamily: FontManager.cairoBold.name,
//                         ),
//                       ),
//                       Expanded(
//                         child: DrawableText(
//                           size: 18.0.sp,
//                           matchParent: true,
//                           textAlign: TextAlign.center,
//                           text: 'الحالة',
//                           color: Colors.black,
//                           fontFamily: FontManager.cairoBold.name,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: DrawableText(
//                           matchParent: true,
//                           size: 18.0.sp,
//                           textAlign: TextAlign.center,
//                           text: item.currentLocationName,
//                           color: Colors.black,
//                           fontFamily: FontManager.cairoBold.name,
//                         ),
//                       ),
//                       Expanded(
//                         child: DrawableText(
//                           matchParent: true,
//                           size: 18.0.sp,
//                           textAlign: TextAlign.center,
//                           text: item.destinationName,
//                           color: Colors.black,
//                           fontFamily: FontManager.cairoBold.name,
//                         ),
//                       ),
//                       Expanded(
//                         child: DrawableText(
//                           matchParent: true,
//                           size: 18.0.sp,
//                           textAlign: TextAlign.center,
//                           text: item.clientName,
//                           color: Colors.black,
//                           fontFamily: FontManager.cairoBold.name,
//                         ),
//                       ),
//                       Expanded(
//                         child: DrawableText(
//                           matchParent: true,
//                           size: 18.0.sp,
//                           textAlign: TextAlign.center,
//                           text: item.driver.fullName.isEmpty
//                               ? 'لم يتم قبولها'
//                               : item.driver.fullName,
//                           color: Colors.black,
//                           fontFamily: FontManager.cairoBold.name,
//                         ),
//                       ),
//                       Expanded(
//                         child: DrawableText(
//                           matchParent: true,
//                           size: 18.0.sp,
//                           textAlign: TextAlign.center,
//                           text: item.getTripsCost,
//                           color: Colors.black,
//                           fontFamily: FontManager.cairoBold.name,
//                         ),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: DrawableText(
//                             size: 18.0.sp,
//                             textAlign: TextAlign.center,
//                             text: item.tripStateName,
//                             color: Colors.black,
//                             drawablePadding: 2.0.w,
//                             drawableAlin: DrawableAlin.withText,
//                             drawableEnd: Container(
//                               height: 15.0,
//                               width: 15.0,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: item.tripStateEnum == null
//                                     ? Colors.red
//                                     : (item.tripStateEnum == NavTrip.start)
//                                         ? Colors.green
//                                         : Colors.amber,
//                               ),
//                             ),
//                             fontFamily: FontManager.cairoBold.name,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
