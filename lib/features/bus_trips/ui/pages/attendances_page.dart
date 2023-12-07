import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/bus_trips/ui/widget/attendances_filter_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../bloc/attendances_cubit/attendances_cubit.dart';

final _super_userList = [
  'ID',
  'اسم الطالب',
  'اسم الرحلة',
  'اسم الباص',
  'نوع العملية',
  'حالة اشتراك الطالب',
  'تاريخ العملية',
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
      floatingActionButton: StatefulBuilder(
        builder: (context, mState) {
          return FloatingActionButton(
            onPressed: () {
              mState(() => loading = true);
              context.read<AllAttendancesCubit>().getAttendancesAsync(context).then(
                (value) {
                  if (value == null) return;
                  saveXls(
                    header: value.first,
                    data: value.second,
                    fileName: 'تقرير سجلات الصعود والنزول ${DateTime.now().formatDate}',
                  );

                  mState(
                    () => loading = false,
                  );
                },
              );
            },
            child: loading
                ? const CircularProgressIndicator.adaptive()
                : const Icon(Icons.file_download, color: Colors.white),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AttendancesFilterWidget(
              onApply: (request) {
                context.read<AllAttendancesCubit>().getAttendances(
                      context,
                      command: context.read<AllAttendancesCubit>().state.command.copyWith(
                            historyRequest: request,
                            skipCount: 0,
                            totalCount: 0,
                          ),
                    );
              },
            ),
            BlocBuilder<AllAttendancesCubit, AllAttendancesInitial>(
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
                          e.busMember.fullName,
                          e.busTrip.name,
                          e.bus.driverName,
                          e.attendanceType.arabicName,
                          e.isSubscribed
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
                          e.date?.formatDateTime,
                        ],
                      )
                      .toList(),
                  onChangePage: (command) {
                    context
                        .read<AllAttendancesCubit>()
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
