import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../bloc/driver_status_history_cubit/driver_status_history_cubit.dart';

class DriverStatusHistory extends StatelessWidget {
  const DriverStatusHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<DriverStatusHistoryCubit, DriverStatusHistoryInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          return SaedTableWidget(
            onChangePage: (command) {
              context
                  .read<DriverStatusHistoryCubit>()
                  .getDriverStatusHistory(context, command: command);
            },
            command: state.command,
            title: const [
              'تاريخ',
              'الحالة',
              'عدد الدقائق',
            ],
            data: state.result
                .mapIndexed(
                  (i, e) => [
                    e.date?.formatDateTime ?? '-',
                    e.status.arabicName,
                    if (i < state.result.length - 1 && state.result[i + 1].date != null)
                      e.date
                          ?.difference(state.result[i + 1].date!)
                          .inMinutes
                          .abs()
                          .toString()
                    else
                      '-'
                  ],
                )
                .toList(),
          );
        },
      ),
    );
  }
}
