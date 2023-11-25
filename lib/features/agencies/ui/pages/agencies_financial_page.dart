import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/drivers/bloc/all_drivers/all_drivers_cubit.dart';
import 'package:qareeb_models/agencies/data/response/agencies_financial_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/wallet/data/response/single_driver_financial.dart';

import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../router/go_route_pages.dart';
import '../../../accounts/bloc/financial_report_cubit/financial_report_cubit.dart';
import '../../../accounts/bloc/pay_to_cubit/pay_to_cubit.dart';
import '../../../pay_to_drivers/ui/widget/financial_filter_widget.dart';
import '../../../pay_to_drivers/ui/widget/pay_to_driver_widget.dart';
import '../../bloc/agencies_financial_report_cubit/agencies_financial_report_cubit.dart';

final transfersHeaderTable = [
  'ID',
  'الاسم الكامل',
  'نسبة الوكيل',
  'مستحقات الوكيل',
   'عمليات',
   'السجل',
];

class AgencyFinancialPage extends StatefulWidget {
  const AgencyFinancialPage({super.key});

  @override
  State<AgencyFinancialPage> createState() => _AgencyFinancialPageState();
}

class _AgencyFinancialPageState extends State<AgencyFinancialPage> {
  @override
  void initState() {
    super.initState();
  }

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StatefulBuilder(
            builder: (context, mState) {
              return FloatingActionButton(
                onPressed: () {
                  mState(() => loading = true);
                  context.read<FinancialReportCubit>().getDriversAsync(context).then(
                    (value) {
                      if (value == null) return;
                      saveXls(
                        header: value.first,
                        data: value.second,
                        fileName: 'التقرير المالي للوكلاء${DateTime.now().formatDate}',
                      );
                      mState(() => loading = false);
                    },
                  );
                },
                child: loading
                    ? const CircularProgressIndicator.adaptive()
                    : const Icon(Icons.file_download, color: Colors.white),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 200.0).h,
        child: Column(
          children: [
            BlocBuilder<AgenciesReportCubit, AgenciesReportInitial>(
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                return Column(
                  children: [
                    SummaryFinancialWidget(result: state.result),
                    10.0.verticalSpace,
                    SaedTableWidget(
                        command: state.command,
                        fullHeight: 1.8.sh,
                        onChangePage: (command) {
                          context
                              .read<FinancialReportCubit>()
                              .getReport(context, command: command);
                        },
                        title: transfersHeaderTable,
                        data: state.result.reports.mapIndexed((i, e) {
                          return [
                            e.agencyId.toString(),
                            e.agencyName,
                            '${e.agencyRatio} %',
                            e.requiredAmountFromCompany.formatPrice,
                              TextButton(
                                onPressed: () {
                                  NoteMessage.showMyDialog(
                                    context,
                                    child: MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                            value: context.read<PayToCubit>()),
                                      ],
                                      child: PayToDriverWidget(
                                        result: FinancialResult.fromJson({}),
                                        agency: e,
                                      ),
                                    ),
                                    onCancel: (val) {},
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    AppColorManager.mainColor.withOpacity(0.1),
                                  ),
                                ),
                                child: const DrawableText(
                                  text: 'تفريغ الرصيد',
                                  selectable: false,
                                ),
                              ),

                            IconButton(
                              onPressed: () {
                                context.pushNamed(GoRouteName.agencyReport,
                                    queryParams: {'id': e.agencyId.toString()});
                              },
                              icon: const Icon(Icons.info_outline),
                            ),
                          ];
                        }).toList()),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryFinancialWidget extends StatelessWidget {
  const SummaryFinancialWidget({super.key, required this.result});

  final AgenciesFinancialResult result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyCardWidget(
          elevation: 0.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
          child: Row(
            children: [
              ImageMultiType(
                url: Assets.iconsDriver,
                width: 55.0.r,
                height: 55.0.r,
              ),
              15.0.horizontalSpace,
              const DrawableText(
                text: 'مستحقات الوكلاء لدى الشركة',
                color: Colors.black,
                fontFamily: FontManager.cairoBold,
              ),
              const Spacer(),
              DrawableText(
                text: result.totalRequiredAmountFromCompany.formatPrice,
                color: Colors.black,
                fontFamily: FontManager.cairoBold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
