import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/item_info.dart';
import '../../../accounts/bloc/account_amount_cubit/account_amount_cubit.dart';
import '../../data/summary_model.dart';

class SummaryPayToWidget extends StatelessWidget {
  const SummaryPayToWidget({super.key, required this.onGetSummary});

  final Function(SummaryModel summary)? onGetSummary;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountAmountCubit, AccountAmountInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        final model = SummaryModel();
        model.type = state.summaryType;
        switch (state.summaryType) {
          case SummaryPayToEnum.requireDriverPay:
            model.cutAmount = state.driverAmount;
            break;
          case SummaryPayToEnum.requireCompanyPay:
            model.cutAmount = state.companyAmount;
            break;
          case SummaryPayToEnum.equal:
            model.cutAmount = state.companyAmount;
            break;
        }
        model.driverId = state.id;
        onGetSummary?.call(model);
      },
      builder: (context, state) {
        if (state.statuses == CubitStatuses.init) {
          return 0.0.verticalSpace;
        }
        if (state.statuses.isLoading) {
          return MyStyle.loadingWidget();
        }
        return SizedBox(
          width: 1.0.sw,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ItemInfoInLine(
                        title: 'رصيد السائق لدى الشركة',
                        info: state.driverAmount.formatPrice,
                      ),
                    ),
                    Expanded(
                      child: ItemInfoInLine(
                        title: 'رصيد الشركة لدى السائق',
                        info: state.companyAmount.formatPrice,
                      ),
                    ),
                  ],
                ),
              ),
              ItemInfoInLine(
                title: 'الملخص: ',
                widget: DrawableText(
                  text: state.getMessage,
                  drawableEnd: Directionality(
                    textDirection: TextDirection.ltr,
                    child: DrawableText(
                      text: state.price.formatPrice.replaceAll('spy', ''),
                      size: 24.0.sp,
                      fontFamily: FontManager.cairoBold,
                      color: AppColorManager.mainColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
