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
import '../../../clients/ui/widget/clients_filter_widget.dart';
import '../widget/financial_filter_widget.dart';
import '../widget/pay_to_driver_widget.dart';

final transfersHeaderTable = [
  'ID',
  'الاسم الكامل',
  'رقم الهاتف',
  'مستحقات الشركة',
  'مستحقات السائق',
  'الملخص',
  if(!isAgency)
  'عمليات',
];

class FinancialPage extends StatefulWidget {
  const FinancialPage({super.key});

  @override
  State<FinancialPage> createState() => _FinancialPageState();
}

class _FinancialPageState extends State<FinancialPage> {
  @override
  void initState() {
    context
        .read<AllDriversCubit>()
        .getAllDrivers(context, command: Command.noPagination());
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
                        fileName: 'التقرير المالي للسائقين${DateTime.now().formatDate}',
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
            BlocBuilder<FinancialReportCubit, FinancialReportInitial>(
              builder: (context, state) {
                return FinancialFilterWidget(
                  command: state.command,
                  onApply: (request) {
                    context.read<FinancialReportCubit>().getReport(
                          context,
                          command:
                              context.read<FinancialReportCubit>().state.command.copyWith(
                                    financialFilterRequest: request,
                                    skipCount: 0,
                                    totalCount: 0,
                                  ),
                        );
                  },
                );
              },
            ),
            BlocBuilder<FinancialReportCubit, FinancialReportInitial>(
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                return Column(
                  children: [
                    SummaryFinancialWidget(result: state.response),
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
                        data: state.result.mapIndexed((index, e) {
                          return [
                            InkWell(
                              onTap: () {
                                context.pushNamed(GoRouteName.driverInfo,
                                    queryParams: {'id': e.driverId.toString()});
                              },
                              child: DrawableText(
                                selectable: false,
                                size: 16.0.sp,
                                matchParent: true,
                                textAlign: TextAlign.center,
                                underLine: true,
                                text: e.driverId.toString(),
                                color: Colors.blue,
                              ),
                            ),
                            e.driverName,
                            e.driverPhoneNo,
                            e.requiredAmountFromDriver.formatPrice,
                            e.requiredAmountFromCompany.formatPrice,
                            getMessage(e),
                            if(!isAgency)
                            TextButton(
                              onPressed: () {
                                NoteMessage.showMyDialog(
                                  context,
                                  child: MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                          value: context.read<PayToCubit>()),
                                    ],
                                    child: PayToDriverWidget(result: e),
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

  final FinancialReportResult result;

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
                text: 'رصيد السائقين لدى الشركة',
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
        MyCardWidget(
          elevation: 0.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
          child: Row(
            children: [
              ImageMultiType(
                url: Assets.iconsQareebPoint,
                width: 55.0.r,
                height: 55.0.r,
              ),
              15.0.horizontalSpace,
              const DrawableText(
                text: 'رصيد الشركة لدى السائقين',
                color: Colors.black,
                fontFamily: FontManager.cairoBold,
              ),
              const Spacer(),
              DrawableText(
                text: result.totalRequiredAmountFromDriver.formatPrice,
                color: Colors.black,
                fontFamily: FontManager.cairoBold,
              ),
            ],
          ),
        ),
        MyCardWidget(
          elevation: 0.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
          child: Row(
            children: [
              ImageMultiType(
                url: Assets.iconsCashSummary,
                width: 55.0.r,
                height: 55.0.r,
              ),
              15.0.horizontalSpace,
              DrawableText(
                text: result.getMessage,
                color: Colors.black,
                fontFamily: FontManager.cairoBold,
              ),
              const Spacer(),
              DrawableText(
                text: result.price.formatPrice,
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
