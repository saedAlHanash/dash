import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/widgets/app_bar_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/util/my_style.dart';
import '../../bloc/agency_report_cubit/agency_report_cubit.dart';

const transfersHeaderTable = [
  'ID',
  'النوع',
  'المرسل',
  'المستقبل',
  'المبلغ',
  'الحالة',
  'التاريخ',
  'عمليات',
];

class AgencyReportPage extends StatefulWidget {
  const AgencyReportPage({super.key});

  @override
  State<AgencyReportPage> createState() => _AgencyReportPageState();
}

class _AgencyReportPageState extends State<AgencyReportPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 200.0).h,
        child: Column(
          children: [
            BlocBuilder<AgencyReportCubit, AgencyReportInitial>(
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                final list = state.result;
                return SaedTableWidget(
                    fullHeight: 1.5.sh,
                    title: transfersHeaderTable,
                    data: state.result.transactions.mapIndexed((index, e) {
                      return [
                        e.id.toString(),
                        e.type.arabicName,
                        e.sourceName,
                        e.destinationName,
                        e.amount.formatPrice,
                        e.status == TransferStatus.closed ? 'تمت' : 'معلقة',
                        e.transferDate?.formatDateTime ?? '',
                        e.note,
                      ];
                    }).toList());
              },
            ),
          ],
        ),
      ),
    );
  }
}
