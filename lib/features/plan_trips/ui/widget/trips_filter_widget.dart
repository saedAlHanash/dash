// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:qareeb_dash/core/api_manager/command.dart';
// import 'package:qareeb_dash/core/extensions/extensions.dart';
// import 'package:qareeb_dash/core/strings/app_color_manager.dart';
// import 'package:qareeb_dash/core/widgets/my_button.dart';
//
// import '../../../../../core/util/my_style.dart';
// import '../../../../core/widgets/my_text_form_widget.dart';
// import '../../../members/ui/pages/create_member_page.dart';
// import '../../data/request/trips_filter_request.dart';
//
// class TripsFilterWidget extends StatefulWidget {
//   const TripsFilterWidget({super.key, this.onApply, this.command});
//
//   final Function(TripsFilterRequest request)? onApply;
//
//   final Command? command;
//
//   @override
//   State<TripsFilterWidget> createState() => _TripsFilterWidgetState();
// }
//
// class _TripsFilterWidgetState extends State<TripsFilterWidget> {
//   late TripsFilterRequest request;
//
//   late final TextEditingController startDateC;
//   late final TextEditingController endDateC;
//   late final TextEditingController nameC;
//   late final TextEditingController planNameC;
//   late final TextEditingController planNumberC;
//
//   @override
//   void initState() {
//     request = widget.command?.tripsFilterRequest ?? TripsFilterRequest();
//     startDateC = TextEditingController(text: request.startTime?.formatDate);
//     endDateC = TextEditingController(text: request.endTime?.formatDate);
//     nameC = TextEditingController(text: request.name);
//     planNameC = TextEditingController(text: request.planName);
//     planNumberC = TextEditingController(text: request.planNumber);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(30.0).r,
//       margin: const EdgeInsets.all(30.0).r,
//       decoration: MyStyle.outlineBorder,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: MyTextFormNoLabelWidget(
//                   label: 'تاريخ بداية الرحلة',
//                   controller: startDateC,
//                   disableAndKeepIcon: true,
//                   textDirection: TextDirection.ltr,
//                   iconWidget: SelectSingeDateWidget(
//                     initial: request.startTime,
//                     onSelect: (selected) {
//                       startDateC.text = selected?.formatDate ?? '';
//                       request.startTime = selected;
//                     },
//                   ),
//                 ),
//               ),
//               15.0.horizontalSpace,
//               Expanded(
//                 child: MyTextFormNoLabelWidget(
//                   label: 'تاريخ نهاية الرحلة',
//                   controller: endDateC,
//                   disableAndKeepIcon: true,
//                   textDirection: TextDirection.ltr,
//                   iconWidget: SelectSingeDateWidget(
//                     initial: request.endTime,
//                     onSelect: (selected) {
//                       endDateC.text = selected?.formatDate ?? '';
//                       request.endTime = selected;
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: MyTextFormNoLabelWidget(
//                   label: 'اسم الرحلة',
//                   // initialValue: request.collegeIdNumber,
//                   controller: nameC,
//                   onChanged: (p0) => request.name = p0,
//                 ),
//               ),
//               15.0.horizontalSpace,
//               Expanded(
//                 child: MyTextFormNoLabelWidget(
//                   label: 'اسم الباص',
//                   // initialValue: request.address,
//                   controller: planNameC,
//                   onChanged: (p0) => request.planName = p0,
//                 ),
//               ),
//               15.0.horizontalSpace,
//               Expanded(
//                 child: MyTextFormNoLabelWidget(
//                   label: 'رقم لوحة الباص',
//                   // initialValue: request.facility,
//                   controller: planNumberC,
//                   onChanged: (p0) => request.planNumber = p0,
//                 ),
//               ),
//             ],
//           ),
//           20.0.verticalSpace,
//           Row(
//             children: [
//               Expanded(
//                 child: MyButton(
//                   width: 1.0.sw,
//                   color: AppColorManager.mainColorDark,
//                   text: 'فلترة',
//                   onTap: () => widget.onApply?.call(request),
//                 ),
//               ),
//               15.0.horizontalSpace,
//               Expanded(
//                 child: MyButton(
//                   width: 1.0.sw,
//                   color: AppColorManager.black,
//                   text: 'مسح الفلاتر',
//                   onTap: () {
//                     setState(() {
//                       request.clearFilter();
//                       startDateC.text = '';
//                       endDateC.text = '';
//                       nameC.text = '';
//                       planNameC.text = '';
//                       planNumberC.text = '';
//                     });
//                     widget.onApply?.call(request);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
