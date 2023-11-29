// import 'package:collection/collection.dart';
// import 'package:drawable_text/drawable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:qareeb_dash/core/extensions/extensions.dart';
// import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
// import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
// import 'package:qareeb_dash/features/plan_trips/ui/widget/trips_history_filter_widget.dart';
//
// import 'package:qareeb_dash/router/go_route_pages.dart';
//
// import '../../../../core/strings/app_color_manager.dart';
// import '../../../../core/util/checker_helper.dart';
// import '../../../../core/util/file_util.dart';
// import '../../../../core/util/my_style.dart';
//
// import '../../bloc/all_plan_trips_cubit/all_plan_trips_cubit.dart';
// import '../../bloc/delete_plan_trip_cubit/delete_plan_trip_cubit.dart';
// import '../../bloc/failed_attendances_cubit/failed_attendances_cubit.dart';
// import '../../bloc/trip_history_cubit/trip_history_cubit.dart';
//
// final _super_userList = [
//   'ID',
//   'اسم الطالب',
//   'اسم الباص',
//   'نوع العملية',
//   'حالة اشتراك الطالب',
//   'تاريخ العملية',
// ];
//
// class FailedAttendancesPage extends StatefulWidget {
//   const FailedAttendancesPage({super.key});
//
//   @override
//   State<FailedAttendancesPage> createState() => _FailedAttendancesPageState();
// }
//
// class _FailedAttendancesPageState extends State<FailedAttendancesPage> {
//   var loading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: StatefulBuilder(
//         builder: (context, mState) {
//           return FloatingActionButton(
//             onPressed: () {
//               mState(() => loading = true);
//               context
//                   .read<FailedAttendancesCubit>()
//                   .getFailedAttendancesAsync(context)
//                   .then(
//                 (value) {
//                   if (value == null) return;
//                   saveXls(
//                     header: value.first,
//                     data: value.second,
//                     fileName: 'تقرير سجلات الصعود والنزول ${DateTime.now().formatDate}',
//                   );
//
//                   mState(
//                     () => loading = false,
//                   );
//                 },
//               );
//             },
//             child: loading
//                 ? const CircularProgressIndicator.adaptive()
//                 : const Icon(Icons.file_download, color: Colors.white),
//           );
//         },
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             TripsHistoryFilterWidget(
//               onApply: (request) {
//                 context.read<FailedAttendancesCubit>().getFailedAttendances(
//                       context,
//                       command:
//                           context.read<FailedAttendancesCubit>().state.command.copyWith(
//                                 historyRequest: request,
//                                 skipCount: 0,
//                                 totalCount: 0,
//                               ),
//                     );
//               },
//             ),
//             BlocBuilder<FailedAttendancesCubit, FailedAttendancesInitial>(
//               builder: (context, state) {
//                 if (state.statuses.loading) {
//                   return MyStyle.loadingWidget();
//                 }
//                 final list = state.result;
//                 if (list.isEmpty) return const NotFoundWidget(text: 'يرجى إضافة رحلات');
//                 return SaedTableWidget(
//                   command: state.command,
//                   title: _super_userList,
//                   data: list
//                       .mapIndexed(
//                         (i, e) => [
//                           e.id.toString(),
//                           e.planMember.fullName,
//                           e.plan.driverName,
//                           e.attendanceType.arabicName,
//                           e.isSubscribed
//                               ? const DrawableText(
//                                   text: 'مشترك',
//                                   matchParent: true,
//                                   color: AppColorManager.mainColor,
//                                   textAlign: TextAlign.center,
//                                 )
//                               : const DrawableText(
//                                   text: 'غير مشترك',
//                                   color: Colors.red,
//                                   matchParent: true,
//                                   textAlign: TextAlign.center,
//                                 ),
//                           e.date?.formatDateTime,
//                         ],
//                       )
//                       .toList(),
//                   onChangePage: (command) {
//                     context
//                         .read<FailedAttendancesCubit>()
//                         .getFailedAttendances(context, command: command);
//                   },
//                 );
//               },
//             ),
//             50.0.verticalSpace,
//           ],
//         ),
//       ),
//     );
//   }
// }
