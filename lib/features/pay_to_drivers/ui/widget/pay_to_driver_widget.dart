import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/auto_complete_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/item_info.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40.0).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.0.verticalSpace,
          ItemInfoInLine(
            title: 'السائق',
            widget: BlocBuilder<AllDriversCubit, AllDriversInitial>(
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                return SizedBox(
                  width: 300.0.w,
                  child: AutoCompleteWidget(
                      onTap: (item) {
                        request.driverId = item.id;
                        context.read<AccountAmountCubit>().getAccountAmount(
                              context,
                              driverId: request.driverId ?? 0,
                            );
                      },
                      listItems: state.getSpinnerItem
                        ..insert(
                          0,
                          SpinnerItem(
                            id: -1,
                            enable: false,
                            name: 'اختر سائق',
                          ),
                        )),
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
              if (state.statuses.isLoading) {
                return MyStyle.loadingWidget();
              }
              return MyButton(
                text: 'تسديد',
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
      ),
    );
  }
}
