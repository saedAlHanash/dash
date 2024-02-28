import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../router/go_route_pages.dart';
import '../../../drivers/data/response/drivers_response.dart';
import '../../../syrian_agency/ui/widget/syrian_filter_widget.dart';
import '../../bloc/debt_cubit/debts_cubit.dart';

class DebtsPage extends StatefulWidget {
  const DebtsPage({super.key, required this.driver});

  final DriverModel driver;

  @override
  State<DebtsPage> createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StatefulBuilder(
        builder: (context, mState) {
          return FloatingActionButton(
            onPressed: () {
              mState(() => loading = true);
              context.read<DebtsCubit>().getDataAsync(context).then(
                (value) {
                  if (value == null) return;
                  saveXls(
                    header: value.first,
                    data: value.second,
                    fileName:
                        'تقرير عائدات الرحلات للسائق ${widget.driver.fullName} ${DateTime.now().formatDate}',
                  );

                  mState(
                    () => loading = false,
                  );
                },
              );
            },
            child: loading
                ? const CircularProgressIndicator.adaptive(backgroundColor: Colors.white)
                : const Icon(Icons.file_download, color: Colors.white),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SyrianFilterWidget(
              onApply: (request) {
                context.read<DebtsCubit>().getDebts(
                      context,
                      command: context.read<DebtsCubit>().state.command.copyWith(
                            syrianFilterRequest: request,
                            skipCount: 0,
                            totalCount: 0,
                          ),
                    );
              },
            ),
            BlocBuilder<DebtsCubit, DebtsInitial>(
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                final list = state.result;
                if (list.isEmpty) {
                  return const NotFoundWidget(text: 'السجل فارغ');
                }

                return SaedTableWidget(
                  fullHeight: 1.8.sh,
                  onChangePage: (command) {
                    context.read<DebtsCubit>().getDebts(context, command: command);
                  },
                  command: state.command,
                  title: const [
                    'ID',
                    'النوع',
                    'الاجمالي',
                    'للسائق',
                    'للزيت',
                    'للذهب',
                    'للإطارات',
                    'بنزين',
                    'للوكيل',
                    'تاريخ'
                  ],
                  data: list.mapIndexed(
                    (i, e) {
                      return [
                        InkWell(
                          onTap: () {
                            if (e.sharedRequestId != 0) {
                              context.pushNamed(
                                GoRouteName.sharedTripInfo,
                                queryParams: {'requestId': '${e.sharedRequestId}'},
                              );
                            } else {
                              context.pushNamed(
                                GoRouteName.tripInfo,
                                queryParams: {'id': '${e.tripId}'},
                              );
                            }
                          },
                          child: DrawableText(
                            selectable: false,
                            size: 16.0.sp,
                            matchParent: true,
                            textAlign: TextAlign.center,
                            underLine: true,
                            text: e.sharedRequestId != 0
                                ? '${e.sharedRequestId}'
                                : '${e.tripId}',
                            color: Colors.blue,
                          ),
                        ),
                        e.sharedRequestId != 0 ? ' مقعد برحلة تشاركية' : ' عادية ',
                        e.totalCost.formatPrice,
                        e.driverShare.formatPrice,
                        e.oilShare.formatPrice,
                        e.goldShare.formatPrice,
                        e.tiresShare.formatPrice,
                        e.gasShare.formatPrice,
                        e.agencyShare.formatPrice,
                        e.date?.formatDate ?? '-',
                      ];
                    },
                  ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
