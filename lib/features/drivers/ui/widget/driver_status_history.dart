import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qareeb_dash/core/widgets/table_widget.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/redeems/ui/widget/loyalty_widget.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import 'package:image_multi_type/round_image_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../../accounts/bloc/driver_financial_cubit/driver_financial_cubit.dart';
import '../../../accounts/bloc/reverse_charging_cubit/reverse_charging_cubit.dart';
import '../../../trip/bloc/candidate_drivers_cubit/candidate_drivers_cubit.dart';
import '../../../wallet/ui/pages/debts_page.dart';
import '../../bloc/driver_by_id_cubit/driver_by_id_cubit.dart';
import '../../bloc/driver_status_history_cubit/driver_status_history_cubit.dart';
import '../widget/driver_financial_widget.dart';

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
