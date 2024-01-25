// import 'package:drawable_text/drawable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:qareeb_dash/core/extensions/extensions.dart';
// import 'package:image_multi_type/round_image_widget.dart';
// import 'package:qareeb_dash/router/go_route_pages.dart';
//
// import '../../../../core/util/my_style.dart';
// import '../../../../core/widgets/my_card_widget.dart';
// import '../../bloc/all_buses_cubit/all_buses_cubit.dart';

// 
//
// class ItemBus extends StatelessWidget {
//   const ItemBus({super.key, required this.item});
//
//   final BusModel item;
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
//                         fontFamily: FontManager.cairoBold.name,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: item.type,
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold.name,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: item.type,
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold.name,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: item.type,
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold.name,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: '${item.type} %',
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold.name,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: '${item.type} %',
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold.name,
//                       ),
//                     ),
//                     Expanded(
//                       child: DrawableText(
//                         matchParent: true,
//                         size: 18.0.sp,
//                         textAlign: TextAlign.center,
//                         text: '${item.type} %',
//                         color: Colors.black,
//                         fontFamily: FontManager.cairoBold.name,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               context.pushNamed(GoRouteName.createBus, extra: item);
//             },
//             icon: const Icon(
//               Icons.edit,
//               color: Colors.amber,
//             ),
//           ),
//           BlocConsumer<DeleteBusCubit, DeleteBusInitial>(
//             listener: (context, state) {
//               context.read<AllBusesCubit>().getBuses(context);
//             },
//             listenWhen: (p, c) => c.statuses.done,
//             buildWhen: (p, c) => c.id == item.id,
//             builder: (context, state) {
//               if (state.statuses.loading) {
//                 return MyStyle.loadingWidget();
//               }
//               return IconButton(
//                 onPressed: () {
//                   context.read<DeleteBusCubit>().deleteBus(context, id: item.id);
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
