// import 'package:collection/collection.dart';
// import 'package:drawable_text/drawable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:qareeb_dash/core/api_manager/api_service.dart';
// import 'package:qareeb_dash/core/api_manager/command.dart';
// import 'package:qareeb_dash/core/extensions/extensions.dart';
// import 'package:qareeb_dash/core/strings/app_color_manager.dart';
// import 'package:qareeb_dash/core/strings/enum_manager.dart';
// import 'package:qareeb_dash/core/widgets/my_button.dart';
// import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
//
// import '../../../../../core/util/my_style.dart';
// import '../../../../core/widgets/auto_complete_widget.dart';
// import '../../../../core/widgets/my_text_form_widget.dart';
// import '../../../members/ui/pages/create_member_page.dart';
// import '../../bloc/all_bus_trips_cubit/all_bus_trips_cubit.dart';
// import '../../data/request/filter_trip_history_request.dart';
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
//   late final TextEditingController busTripTemplateNameC;
//   late final TextEditingController nameC;
//   late final TextEditingController busNameC;
//   late final TextEditingController busNumberC;
//   final key1 = GlobalKey<SpinnerWidgetState>();
//   final key2 = GlobalKey<SpinnerWidgetState>();
//   final key3 = GlobalKey<SpinnerWidgetState>();
//
//   @override
//   void initState() {
//     request = widget.command?.tripsFilterRequest ?? TripsFilterRequest();
//     startDateC = TextEditingController(text: request.startTime?.formatDate);
//     endDateC = TextEditingController(text: request.endTime?.formatDate);
//     busTripTemplateNameC = TextEditingController(text: request.busTripTemplateName);
//     nameC = TextEditingController(text: request.name);
//     busNameC = TextEditingController(text: request.busName);
//     busNumberC = TextEditingController(text: request.busNumber);
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
//                     minDate: DateTime.now(),
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
//                     minDate: DateTime.now(),
//                     onSelect: (selected) {
//                       endDateC.text = selected?.formatDate ?? '';
//                       request.endTime = selected;
//                     },
//                   ),
//                 ),
//               ),
//               15.0.horizontalSpace,
//               Expanded(
//                 child: MyTextFormNoLabelWidget(
//                   label: 'اسم النموذج',
//                   // initialValue: request.phoneNo,
//                   controller: busTripTemplateNameC,
//                   onChanged: (p0) => request.busTripTemplateName = p0,
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
//                   controller: busNameC,
//                   onChanged: (p0) => request.busName = p0,
//                 ),
//               ),
//               15.0.horizontalSpace,
//               Expanded(
//                 child: MyTextFormNoLabelWidget(
//                   label: 'معرف الباص',
//                   // initialValue: request.facility,
//                   controller: busNumberC,
//                   onChanged: (p0) => request.busNumber = p0,
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: SpinnerWidget(
//                   key: key1,
//                   width: 1.0.sw,
//                   items: AttendanceType.values.spinnerItems(
//                     selected: [request.attendanceType],
//                   )..insert(0, SpinnerItem(name: 'نوع العملية', id: -1)),
//                   onChanged: (item) => request.attendanceType = item.item,
//                 ),
//               ),
//               15.0.horizontalSpace,
//               Expanded(
//                 child: Builder(builder: (context) {
//                   loggerObject.w('message');
//                   return SpinnerWidget(
//                     key: key2,
//                     width: 1.0.sw,
//                     items: [
//                       SpinnerItem(
//                         name: 'مشترك',
//                         id: 1,
//                         item: true,
//                         isSelected: request.isSubscribed ?? false,
//                       ),
//                       SpinnerItem(
//                         name: 'غير مشترك',
//                         id: 2,
//                         item: false,
//                         isSelected: !(request.isSubscribed ?? true),
//                       ),
//                     ]..insert(
//                         0,
//                         SpinnerItem(
//                           name: 'حالة الاشتراك في النقل',
//                           id: -1,
//                           isSelected: request.isSubscribed == null,
//                         ),
//                       ),
//                     onChanged: (item) => request.isSubscribed = item.item,
//                   );
//                 }),
//               ),
//               15.0.horizontalSpace,
//               Expanded(
//                 child: SpinnerWidget(
//                   key: key3,
//                   width: 1.0.sw,
//                   items: [
//                     SpinnerItem(
//                       name: 'مشترك',
//                       id: 1,
//                       item: true,
//                       isSelected: request.isParticipated ?? false,
//                     ),
//                     SpinnerItem(
//                       name: 'غير مشترك',
//                       id: 2,
//                       item: false,
//                       isSelected: !(request.isParticipated ?? true),
//                     ),
//                   ]..insert(
//                       0,
//                       SpinnerItem(
//                         name: 'حالة الاشتراك في النقل',
//                         id: -1,
//                         isSelected: request.isParticipated == null,
//                       ),
//                     ),
//                   onChanged: (item) => request.isParticipated = item.item,
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
//                   onTap: () => setState(() {
//                     request.clearFilter();
//                     startDateC.text = '';
//                     endDateC.text = '';
//                     busTripTemplateNameC.text = '';
//                     nameC.text = '';
//                     busNameC.text = '';
//                     busNumberC.text = '';
//                     key1.currentState?.clearSelect();
//                     key2.currentState?.clearSelect();
//                     key3.currentState?.clearSelect();
//                   }),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
