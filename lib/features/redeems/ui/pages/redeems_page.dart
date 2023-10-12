
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../bloc/redeems_history_cubit/redeems_history_cubit.dart';


const _tripsTableHeader = [
  'ID ',
  'نوع العملية',
  'محصلة المجمع',
  'عدد الأمتار',
  'تاريخ العملية',
];

class RedeemsPage extends StatelessWidget {
  const RedeemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100.0).h,
        child: Column(
          children: [

            BlocBuilder<RedeemsHistoryCubit, RedeemsHistoryInitial>(
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }

                final list = state.result;

                if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد عمليات للولاء');

                return SaedTableWidget(
                  fullHeight: 1.8.sh,
                  title: _tripsTableHeader,
                  data: list
                      .mapIndexed(
                        (index, e) => [
                          e.id,
                          e.type.arabicName,
                          e.aggregatedMoney.formatPrice,
                          e.meters,
                          e.redeemDate,
                        ],
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
