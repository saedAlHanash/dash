import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/item_info.dart';
import '../../../accounts/bloc/account_amount_cubit/account_amount_cubit.dart';
import '../../data/summary_model.dart';

class SummaryPayToWidget extends StatefulWidget {
  const SummaryPayToWidget({super.key, required this.onGetSummary});

  final Function(SummaryModel summary)? onGetSummary;

  @override
  State<SummaryPayToWidget> createState() => _SummaryPayToWidgetState();
}

class _SummaryPayToWidgetState extends State<SummaryPayToWidget> {
  final model = SummaryModel();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountAmountCubit, AccountAmountInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        model.type = state.summaryType;

        switch (state.summaryType) {
          //مطلوب من السائق
          case SummaryPayToEnum.requiredFromDriver:
            model.cutAmount = state.driverAmount;
            break;
          //مطلوب من الشركة
          case SummaryPayToEnum.requiredFromCompany:
            model.cutAmount = state.companyAmount;
            break;
          //متساوي
          case SummaryPayToEnum.equal:
            model.cutAmount = state.companyAmount;
            break;
        }
        //تخزين المعرف
        model.driverId = state.id;
        //استدعاء التابع
        widget.onGetSummary?.call(model);
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
                      text: state.price.formatPrice,
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
