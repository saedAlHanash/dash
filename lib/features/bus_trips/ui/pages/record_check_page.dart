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
import '../../bloc/record_check_cubit/record_check_cubit.dart';
import '../widget/record_check_filter_widget.dart';

final _super_userList = [
  'ID',
  'اسم الطالب',
  'اسم المفتش',
  'حالة اشتراك الطالب',
  'تاريخ العملية',
];

class RecordCheckPage extends StatefulWidget {
  const RecordCheckPage({super.key});

  @override
  State<RecordCheckPage> createState() => _RecordCheckPageState();
}

class _RecordCheckPageState extends State<RecordCheckPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StatefulBuilder(
        builder: (context, mState) {
          return FloatingActionButton(
            onPressed: () {
              mState(() => loading = true);
              context.read<RecordCheckCubit>().getRecordsAsync(context).then(
                (value) {
                  if (value == null) return;
                  saveXls(
                    header: value.first,
                    data: value.second,
                    fileName: 'تقرير سجل التفتيش${DateTime.now().formatDate}',
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
            RecordCheckFilterWidget(
              onApply: (request) {
                context.read<RecordCheckCubit>().getRecords(
                      context,
                      command: context.read<RecordCheckCubit>().state.command.copyWith(
                            recordCheckRequest: request,
                            skipCount: 0,
                            totalCount: 0,
                          ),
                    );
              },
            ),
            BlocBuilder<RecordCheckCubit, RecordCheckInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                final list = state.result;
                if (list.isEmpty)
                  return const NotFoundWidget(text: 'لم يتم اي عملية تفتيش');
                return SaedTableWidget(
                  command: state.command,
                  title: _super_userList,
                  data: list
                      .mapIndexed(
                        (i, e) => [
                          e.id.toString(),
                          e.busMember.fullName,
                          e.supervisor.fullName,
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
                        .read<RecordCheckCubit>()
                        .getRecords(context, command: command);
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
