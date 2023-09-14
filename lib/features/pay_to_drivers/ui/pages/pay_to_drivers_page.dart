import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/drivers/bloc/all_drivers/all_drivers_cubit.dart';
import 'package:qareeb_dash/features/pay_to_drivers/ui/widget/pay_to_driver_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../../accounts/bloc/account_amount_cubit/account_amount_cubit.dart';
import '../../../accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';
import '../../../clients/ui/widget/clients_filter_widget.dart';
import '../../bloc/financial_report_cubit/financial_report_cubit.dart';
import '../../bloc/pay_to_cubit/pay_to_cubit.dart';

const transfersHeaderTable = [
  'ID',
  'الاسم الكامل',
  'رقم الهاتف',
  'مستحقات الشركة',
  'مستحقات السائق',
  'الملخص',
];

class PayToDriversPage extends StatefulWidget {
  const PayToDriversPage({super.key});

  @override
  State<PayToDriversPage> createState() => _PayToDriversPageState();
}

class _PayToDriversPageState extends State<PayToDriversPage> {
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
          if (isAllowed(AppPermissions.CREATION))
            FloatingActionButton(
              onPressed: () {
                NoteMessage.showCustomBottomSheet(
                  context,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: context.read<AllDriversCubit>()),
                      BlocProvider.value(value: context.read<PayToCubit>()),
                      BlocProvider.value(value: context.read<AccountAmountCubit>()),
                    ],
                    child: const PayToDriverWidget(),
                  ),
                  onCancel: (val) {
                    context.read<AllTransfersCubit>().getAllTransfers(context);
                  },
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          10.0.verticalSpace,
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
                return ClientsFilterWidget(
                  command: state.command,
                  onApply: (request) {
                    context.read<FinancialReportCubit>().getReport(
                          context,
                          command:
                              context.read<FinancialReportCubit>().state.command.copyWith(
                                    memberFilterRequest: request,
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
                return SaedTableWidget(
                    command: state.command,
                    fullHeight: 1.8.sh,
                    onChangePage: (command) {
                      context
                          .read<AllTransfersCubit>()
                          .getAllTransfers(context, command: command);
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
