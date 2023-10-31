// import 'package:drawable_text/drawable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_multi_type/round_image_widget.dart';
// import 'package:qareeb_dash/features/agencies/data/response/agency_response.dart';
//
// import '../../../../core/widgets/my_card_widget.dart';
//
// class ItemAgencyWidget extends StatelessWidget {
//   const ItemAgencyWidget({super.key, required this.item});
//
//   final Agency item;
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
//           Row(
//             children: [
//               Expanded(
//                 child: DrawableText(
//                   matchParent: true,
//                   size: 18.0.sp,
//                   textAlign: TextAlign.center,
//                   text: item.name,
//                   color: Colors.black,
//                   fontFamily: FontManager.cairoBold,
//                 ),
//               ),
//             ],
//           ),
//           IconButton(
//             onPressed: () {
//               context.pushNamed(GoRouteName.createCarCategory, extra: item);
//             },
//             icon: const Icon(
//               Icons.edit,
//               color: Colors.amber,
//             ),
//           ),
//           BlocConsumer<DeleteCarCatCubit, DeleteCarCatInitial>(
//             listener: (context, state) {
//               context.read<AllCarCategoriesCubit>().getCarCategories(context);
//             },
//             listenWhen: (p, c) => c.statuses.done,
//             buildWhen: (p, c) => c.id == item.id,
//             builder: (context, state) {
//               if (state.statuses.isLoading) {
//                 return MyStyle.loadingWidget();
//               }
//               return IconButton(
//                 onPressed: () {
//                   context.read<DeleteCarCatCubit>().deleteCarCat(context, id: item.id);
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
