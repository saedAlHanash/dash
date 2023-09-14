import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/debt_cubit/debts_cubit.dart';

class DebtsPage extends StatelessWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        text: 'سجل عائدات السائق من الرحلات',
      ),
      body: Column(
        children: [
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
                      e.sharedRequestId != 0
                          ? ' مقعد برحلة تشاركية'
                          : ' عادية ',
                      e.totalCost.formatPrice,
                      e.driverShare.formatPrice,
                      e.oilShare.formatPrice,
                      e.goldShare.formatPrice,
                      e.tiresShare.formatPrice,
                      e.date?.formatDate ?? '-',
                    ];
                  },
                ).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
