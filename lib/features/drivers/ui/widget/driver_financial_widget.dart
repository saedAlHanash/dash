import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/wallet/data/response/driver_financial_response.dart';
import 'package:qareeb_models/wallet/data/response/single_driver_financial.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../accounts/bloc/driver_financial_cubit/driver_financial_cubit.dart';
import '../../../accounts/bloc/reverse_charging_cubit/reverse_charging_cubit.dart';

class DriverFinancialWidget extends StatelessWidget {
  const DriverFinancialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReverseChargingCubit, ReverseChargingInitial>(
      listenWhen: (p, c) => c.statuses.isDone,
      listener: (context, state) {
        context.read<DriverFinancialCubit>().getDriverFinancial(context);
      },
      child: BlocBuilder<DriverFinancialCubit, DriverFinancialInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SummaryFinancialWidget(result: state.result),
                MyCardWidget(
                  elevation: 0.0,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                  child: Row(
                    children: [
                      DrawableText(
                        text: 'آخر شحنة من السائق للشركة',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                        drawablePadding: 30.0.h,
                        drawableEnd: DrawableText(
                          text: state.result.lastTransferFromDriver.transferDate
                                  ?.formatDuration(serverDate: getServerDate) ??
                              '',
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      DrawableText(
                        text: state.result.lastTransferFromDriver.amount.formatPrice,
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
                      DrawableText(
                        text: 'آخر شحنة من الشركة للسائق',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                        drawablePadding: 30.0.h,
                        drawableEnd: DrawableText(
                          text: state.result.lastTransferFromDriver.transferDate
                                  ?.formatDuration(serverDate: getServerDate) ??
                              '',
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      DrawableText(
                        text: state
                            .result.lastTransferFromCompanyToDriver.amount.formatPrice,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SaedTableWidget(
                  filters: const DrawableText(
                    text: 'شحنات السائق',
                  ),
                  title: const [
                    'المرسل',
                    'المستقبل',
                    'القيمة',
                    'الحالة',
                    'التاريخ',
                    'عمليات',
                  ],
                  data: state.result.charging.mapIndexed((i, e) {
                    return [
                      e.chargerName.isEmpty ? e.providerName : e.chargerName,
                      e.userName,
                      e.amount == 0 ? 'عملية استرجاع' : e.amount.formatPrice,
                      e.status.arabicName,
                      e.date?.formatDate,
                      (e.amount == 0 || isAgency)
                          ? 0.0.verticalSpace
                          : BlocBuilder<ReverseChargingCubit, ReverseChargingInitial>(
                              builder: (context, state) {
                                if (state.statuses.isLoading) {
                                  return MyStyle.loadingWidget();
                                }
                                return IconButton(
                                  onPressed: () {
                                    context
                                        .read<ReverseChargingCubit>()
                                        .payTo(context, processId: e.processId);
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: AppColorManager.red,
                                  ),
                                );
                              },
                              buildWhen: (p, c) => c.processId == e.processId,
                            ),
                    ];
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SummaryFinancialWidget extends StatelessWidget {
  const SummaryFinancialWidget({super.key, required this.result});

  final DriverFinancialResult result;

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
                text: 'رصيد السائق لدى الشركة',
                color: Colors.black,
                fontFamily: FontManager.cairoBold,
              ),
              const Spacer(),
              DrawableText(
                text: result.requiredAmountFromCompany.formatPrice,
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
                text: 'رصيد الشركة لدى السائق',
                color: Colors.black,
                fontFamily: FontManager.cairoBold,
              ),
              const Spacer(),
              DrawableText(
                text: result.requiredAmountFromDriver.formatPrice,
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
