import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../bloc/plan_attendances_cubit/plan_attendances_cubit.dart';
import '../widget/attendances_filter_widget.dart';

final _super_userList = [
  'ID',
  'معرف الرحلة',
  'اسم السائق',
  'اسم الزبون',
  'اسم الشركة',
  'اسم الخطة',
  'حالة اشتراك الزبون',
  'تاريخ العملية',
  'consumed Meters',
];

class AttendancesPage extends StatefulWidget {
  const AttendancesPage({super.key});

  @override
  State<AttendancesPage> createState() => _AttendancesPageState();
}

class _AttendancesPageState extends State<AttendancesPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: StatefulBuilder(
      //   builder: (context, mState) {
      //     return FloatingActionButton(
      //       onPressed: () {
      //         mState(() => loading = true);
      //         context.read<PlanAttendancesCubit>().getAttendancesAsync(context).then(
      //           (value) {
      //             if (value == null) return;
      //             saveXls(
      //               header: value.first,
      //               data: value.second,
      //               fileName: 'تقرير سجلات الصعود والنزول ${DateTime.now().formatDate}',
      //             );
      //
      //             mState(
      //               () => loading = false,
      //             );
      //           },
      //         );
      //       },
      //       child: loading
      //           ? const CircularProgressIndicator.adaptive()
      //           : const Icon(Icons.file_download, color: Colors.white),
      //     );
      //   },
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AttendancesFilterWidget(
              onApply: (request) {
                context.read<PlanAttendancesCubit>().getAttendances(
                      context,
                      command:
                          context.read<PlanAttendancesCubit>().state.command.copyWith(
                                planAttendanceFilter: request,
                                skipCount: 0,
                                totalCount: 0,
                              ),
                    );
              },
            ),
            BlocBuilder<PlanAttendancesCubit, PlanAttendancesInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                final list = state.result;
                if (list.isEmpty) return const NotFoundWidget(text: 'يرجى إضافة رحلات');
                return SaedTableWidget(
                  command: state.command,
                  title: _super_userList,
                  data: list
                      .mapIndexed(
                        (i, e) => [
                          e.id.toString(),
                          e.driver.fullName,
                          e.user.fullName,
                          e.enrollment.company.name,
                          e.enrollment.plan.name,
                          !e.enrollment.isExpired
                              ? const DrawableText(
                                  text: 'مشترك',
                                  matchParent: true,
                                  color: AppColorManager.mainColor,
                                  textAlign: TextAlign.center,
                                )
                              : const DrawableText(
                                  text: 'غير مشترك',
                                  color: Colors.red,
                                  matchParent: true,
                                  textAlign: TextAlign.center,
                                ),
                          e.date?.formatDate ?? '-',
                          e.consumedMeters.toString()
                        ],
                      )
                      .toList(),
                  onChangePage: (command) {
                    context
                        .read<PlanAttendancesCubit>()
                        .getAttendances(context, command: command);
                  },
                );
              },
            ),
            50.0.verticalSpace,
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: list.length,
            //     itemBuilder: (context, i) {
            //       final item = list[i];
            //       return ItemBusTrip(item: item);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
