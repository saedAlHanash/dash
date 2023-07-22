import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/item_info.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../accounts/bloc/account_amount_cubit/account_amount_cubit.dart';
import '../../../drivers/bloc/all_drivers/all_drivers_cubit.dart';
import '../../../wallet/data/summary_model.dart';
import '../../../wallet/ui/widget/summary_pay_to_widget.dart';
import '../../bloc/pay_to_cubit/pay_to_cubit.dart';

class PayToDriverWidget extends StatefulWidget {
  const PayToDriverWidget({super.key});

  @override
  State<PayToDriverWidget> createState() => _PayToDriverWidgetState();
}

class _PayToDriverWidgetState extends State<PayToDriverWidget> {
  var request = SummaryModel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.0.verticalSpace,
          ItemInfoInLine(
            title: 'السائق',
            widget: BlocBuilder<AllDriversCubit, AllDriversInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return SpinnerWidget(
                  items: state.getSpinnerItem
                    ..insert(
                      0,
                      SpinnerItem(
                        id: -1,
                        enable: false,
                        name: 'اختر سائق',
                      ),
                    ),
                  onChanged: (spinnerItem) {
                    request.driverId = spinnerItem.id;
                    context.read<AccountAmountCubit>().getAccountAmount(
                          context,
                          driverId: request.driverId ?? 0,
                        );
                  },
                );
              },
            ),
          ),
          SummaryPayToWidget(
            onGetSummary: (summary) => request = summary,
          ),
          MyTextFormNoLabelWidget(
            label: 'قيمة الدفعة',
            onChanged: (p0) => request.payAmount = num.tryParse(p0) ?? 0,
          ),
          BlocConsumer<PayToCubit, PayToInitial>(
            listenWhen: (p, c) => c.statuses.done,
            listener: (context, state) => Navigator.pop(context, true),
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return MyButton(
                text: 'تسديد',
                onTap: () {
                  if ((request.payAmount ?? 0) == 0) return;
                  if (request.driverId == null) return;
                  context.read<PayToCubit>().payTo(
                        context,
                        request: request,
                      );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
