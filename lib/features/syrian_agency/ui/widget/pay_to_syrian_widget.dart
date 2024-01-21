import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/syrian_agency/data/request/syrian_pay_request.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../accounts/bloc/financial_report_cubit/financial_report_cubit.dart';
import '../../bloc/pay_to_syrian_cubit/pay_to_syrian_cubit.dart';
import '../../data/response/syrian_agency_financial_report_response.dart';

class PayToSyrianSyrianWidget extends StatefulWidget {
  const PayToSyrianSyrianWidget({super.key, required this.result});

  final SyrianAgencyFinancialReport result;

  @override
  State<PayToSyrianSyrianWidget> createState() => _PayToSyrianSyrianWidgetState();
}

class _PayToSyrianSyrianWidgetState extends State<PayToSyrianSyrianWidget> {
  final request = SyrianPayRequest();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PayToSyrianCubit, PayToSyrianInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) =>
          context.read<FinancialReportCubit>().getReport(context),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            10.0.verticalSpace,
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
                  DrawableText(
                    text: 'رصيد الهيئة لدى الشركة',
                    color: Colors.black,
                    fontFamily: FontManager.cairoBold.name,
                  ),
                  const Spacer(),
                  DrawableText(
                    text: widget.result.requiredAmountFromCompany.formatPrice,
                    color: Colors.black,
                    fontFamily: FontManager.cairoBold.name,
                  ),
                ],
              ),
            ),
            10.0.verticalSpace,
            MyTextFormNoLabelWidget(
              label: 'ملاحظات',
              maxLines: 5,
              onChanged: (p0) => request.note = p0,
            ),
            10.0.verticalSpace,
            MyTextFormNoLabelWidget(
              label: ' قيمة الدفعة المقدمة من الشركة ',
              onChanged: (p0) {
                request.amount = num.tryParse(p0) ?? 0;
              },
            ),
            BlocConsumer<PayToSyrianCubit, PayToSyrianInitial>(
              listenWhen: (p, c) => c.statuses.done,
              listener: (context, state) => Navigator.pop(context, true),
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                return MyButton(
                  text: 'تسديد',
                  onTap: () {
                    context.read<PayToSyrianCubit>().payTo(
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
