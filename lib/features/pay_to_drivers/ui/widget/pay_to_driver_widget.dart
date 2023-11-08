import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/auto_complete_widget.dart';
import 'package:qareeb_dash/features/accounts/data/request/driver_financial_filter_request.dart';
import 'package:qareeb_dash/features/drivers/ui/widget/driver_financial_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/wallet/data/response/driver_financial_response.dart';
import 'package:qareeb_models/wallet/data/response/single_driver_financial.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/item_info.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../accounts/bloc/driver_financial_cubit/driver_financial_cubit.dart';
import '../../../accounts/bloc/financial_report_cubit/financial_report_cubit.dart';
import '../../../accounts/bloc/pay_to_cubit/pay_to_cubit.dart';
import '../../../drivers/bloc/all_drivers/all_drivers_cubit.dart';
import '../../../wallet/data/summary_model.dart';

class PayToDriverWidget extends StatefulWidget {
  const PayToDriverWidget({super.key, required this.result});

  final FinancialResult result;

  @override
  State<PayToDriverWidget> createState() => _PayToDriverWidgetState();
}

class _PayToDriverWidgetState extends State<PayToDriverWidget> {
  var request = SummaryModel();

  @override
  void initState() {
    loggerObject.w(widget.result.toJson());
    request.type = widget.result.summaryType;
    request.driverId = widget.result.driverId;
    switch (widget.result.summaryType) {
      //السائق يجب أن يدفع للشركة
      case SummaryPayToEnum.requiredFromDriver:
        request.cutAmount = widget.result.requiredAmountFromCompany;
        break;

      //الشركة يجب انت تدفع للسائق
      case SummaryPayToEnum.requiredFromCompany:
        request.cutAmount = widget.result.requiredAmountFromDriver;
        break;

      //الرصيد متكافئ
      case SummaryPayToEnum.equal:
        request.cutAmount = widget.result.requiredAmountFromCompany;
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PayToCubit, PayToInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) =>
          context.read<FinancialReportCubit>().getReport(context),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            10.0.verticalSpace,
            SummaryFinancialWidget(
                result: DriverFinancialResult.fromFinancialResult(widget.result)),
            10.0.verticalSpace,
            MyTextFormNoLabelWidget(
              label: 'ملاحظات',
              maxLines: 5,
              onChanged: (p0) => request.note = p0,
            ),
            10.0.verticalSpace,
            if (!widget.result.summaryType.eq) ...[
              MyTextFormNoLabelWidget(
                label:
                    ' قيمة الدفعة ${widget.result.summaryType.c2d ? 'المقدمة من الشركة' : 'المستلمة من السائق'}',
                onChanged: (p0) {
                  request.payAmount = num.tryParse(p0) ?? 0;
                  loggerObject.w(request.payAmount);
                },
              ),
              BlocConsumer<PayToCubit, PayToInitial>(
                listenWhen: (p, c) => c.statuses.done,
                listener: (context, state) => Navigator.pop(context, true),
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: widget.result.summaryType.c2d ? 'تسديد' : 'استلام',
                    onTap: () {
                      context.read<PayToCubit>().payTo(
                            context,
                            request: request,
                          );
                    },
                  );
                },
              )
            ],
          ],
        ),
      ),
    );
  }
}
