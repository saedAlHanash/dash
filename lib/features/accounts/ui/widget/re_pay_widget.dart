import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/accounts/data/request/re_pay_request.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../accounts/bloc/pay_to_cubit/pay_to_cubit.dart';
import '../../bloc/all_transfers_cubit/all_transfers_cubit.dart';

class RePayWidget extends StatefulWidget {
  const RePayWidget({super.key});

  @override
  State<RePayWidget> createState() => _RePayWidgetState();
}

class _RePayWidgetState extends State<RePayWidget> {
  var request = RePayRequest();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PayToCubit, PayToInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<AllTransfersCubit>().getAllTransfers(context);
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            10.0.verticalSpace,
            MyTextFormNoLabelWidget(
              label: 'ملاحظات',
              maxLines: 5,
              onChanged: (p0) => request.note = p0,
            ),
            10.0.verticalSpace,
            MyTextFormNoLabelWidget(
              label: ' قيمة التعويض ',
              onChanged: (p0) {
                request.amount = num.tryParse(p0) ?? 0;
              },
            ),
            MyTextFormNoLabelWidget(
              label: 'رقم هاتف المستخدم',
              onChanged: (p0) => request.phone = p0,
              maxLength: 10,
              maxLines: 1,
            ),
            BlocConsumer<PayToCubit, PayToInitial>(
              listenWhen: (p, c) => c.statuses.done,
              listener: (context, state) => Navigator.pop(context, true),
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                return MyButton(
                  text: 'شحن',
                  onTap: () {
                    context.read<PayToCubit>().rePayToClient(
                          context,
                          request: request,
                        );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
