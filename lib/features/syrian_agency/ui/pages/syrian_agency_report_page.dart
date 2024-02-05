import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/widgets/app_bar_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../bloc/syrian_agency_report_cubit/syrian_agency_report_cubit.dart';
import '../widget/syrian_filter_widget.dart';

const transfersHeaderTable = [
  'العائد الكلي',
  'حصة السائق',
  'حصة الشركة',
  'حصة الهيئة',
  'النوع',
  'تاريخ',
];

class SyrianAgencyReportPage extends StatefulWidget {
  const SyrianAgencyReportPage({super.key});

  @override
  State<SyrianAgencyReportPage> createState() => _SyrianAgencyReportPageState();
}

class _SyrianAgencyReportPageState extends State<SyrianAgencyReportPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 200.0).h,
        child: BlocBuilder<SyrianAgencyReportCubit, SyrianAgencyReportInitial>(
          builder: (context, state) {
            if (state.statuses.isLoading) {
              return MyStyle.loadingWidget();
            }
            return Column(
              children: [
                SyrianFilterWidget(
                  onApply: (request) {
                    context.read<SyrianAgencyReportCubit>().getSyrianAgencyReport(
                          context,
                          command: context
                              .read<SyrianAgencyReportCubit>()
                              .state
                              .command
                              .copyWith(
                                syrianFilterRequest: request,
                                skipCount: 0,
                                totalCount: 0,
                              ),
                        );
                  },
                ),
                SaedTableWidget(
                    command: state.command,
                    onChangePage: (command) {
                      context
                          .read<SyrianAgencyReportCubit>()
                          .getSyrianAgencyReport(context, command: command);
                    },
                    fullHeight: 1.5.sh,
                    title: transfersHeaderTable,
                    data: state.result.mapIndexed((index, e) {
                      return [
                        e.amount.formatPrice,
                        e.driverShare.formatPrice,
                        e.companyShare.formatPrice,
                        e.syrianAuthorityShare.formatPrice,
                        e.type.arabicName,
                        e.date?.formatDateTime,
                      ];
                    }).toList()),
              ],
            );
          },
        ),
      ),
    );
  }
}
