import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/features/accounts/data/request/transfer_filter_request.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/agencies/data/response/agencies_financial_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/wallet/data/response/debt_response.dart';
import 'package:qareeb_models/wallet/data/response/driver_financial_response.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../../accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';
import '../../../accounts/bloc/driver_financial_cubit/driver_financial_cubit.dart';
import '../../../accounts/bloc/reverse_charging_cubit/reverse_charging_cubit.dart';
import '../../../accounts/ui/pages/transfers_page.dart';

class DriverFinancialWidget extends StatelessWidget {
  const DriverFinancialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ReverseChargingCubit, ReverseChargingInitial>(
          listenWhen: (p, c) => c.statuses.isDone,
          listener: (context, state) {
            context.read<DriverFinancialCubit>().getDriverFinancial(context);
          },
        ),
        BlocListener<DriverFinancialCubit, DriverFinancialInitial>(
          listenWhen: (p, c) => c.statuses.isDone,
          listener: (context, state) {
            final command = Command.noPagination();
            command.transferFilterRequest = TransferFilterRequest(
              userId: state.request.driverId,
              startTime: state.result.lastTransferFromCompanyToDriver.transferDate?.add(
                const Duration(hours: 1),
              ),
              endTime: getServerDate,
            );
            context.read<AllTransfersCubit>().getAllTransfers(context, command: command);
          },
        ),
      ],
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
                        fontFamily: FontManager.cairoBold.name,
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
                        fontFamily: FontManager.cairoBold.name,
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
                        fontFamily: FontManager.cairoBold.name,
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
                        fontFamily: FontManager.cairoBold.name,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                LatestDebts(debts: state.result.debts),
                const Divider(),
                const LatestTransfers(),
                const Divider(),
                SaedTableWidget(
                  filters: const DrawableText(
                    text: 'شحنات السائق\n',
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
              DrawableText(
                text: 'رصيد السائق لدى الشركة',
                color: Colors.black,
                fontFamily: FontManager.cairoBold.name,
              ),
              const Spacer(),
              DrawableText(
                text: result.requiredAmountFromCompany.formatPrice,
                color: Colors.black,
                fontFamily: FontManager.cairoBold.name,
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
              DrawableText(
                text: 'رصيد الشركة لدى السائق',
                color: Colors.black,
                fontFamily: FontManager.cairoBold.name,
              ),
              const Spacer(),
              DrawableText(
                text: result.requiredAmountFromDriver.formatPrice,
                color: Colors.black,
                fontFamily: FontManager.cairoBold.name,
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
                fontFamily: FontManager.cairoBold.name,
              ),
              const Spacer(),
              DrawableText(
                text: result.price.formatPrice,
                color: Colors.black,
                fontFamily: FontManager.cairoBold.name,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SummaryAgencyWidget extends StatelessWidget {
  const SummaryAgencyWidget({super.key, required this.result});

  final AgencyReport result;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
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
            text: 'رصيد الوكيل لدى الشركة',
            color: Colors.black,
            fontFamily: FontManager.cairoBold.name,
          ),
          const Spacer(),
          DrawableText(
            text: result.requiredAmountFromCompany.formatPrice,
            color: Colors.black,
            fontFamily: FontManager.cairoBold.name,
          ),
        ],
      ),
    );
  }
}

class LatestDebts extends StatelessWidget {
  const LatestDebts({super.key, required this.debts});

  final List<Debt> debts;

  @override
  Widget build(BuildContext context) {
    return SaedTableWidget(
      filters: const DrawableText(text: 'عائدات السائق بعد آخر دفعة\n'),
      title: const [
        'ID',
        'النوع',
        'الاجمالي',
        'للسائق',
        'للزيت',
        'للذهب',
        'للإطارات',
        'بنزين',
        'للوكيل',
        'تاريخ'
      ],
      data: debts.mapIndexed(
        (i, e) {
          return [
            InkWell(
              onTap: () {
                if (e.sharedRequestId != 0) {
                  context.pushNamed(
                    GoRouteName.sharedTripInfo,
                    queryParams: {'requestId': '${e.sharedRequestId}'},
                  );
                } else {
                  context.pushNamed(
                    GoRouteName.tripInfo,
                    queryParams: {'id': '${e.tripId}'},
                  );
                }
              },
              child: DrawableText(
                selectable: false,
                size: 16.0.sp,
                matchParent: true,
                textAlign: TextAlign.center,
                underLine: true,
                text: e.sharedRequestId != 0 ? '${e.sharedRequestId}' : '${e.tripId}',
                color: Colors.blue,
              ),
            ),
            e.sharedRequestId != 0 ? ' مقعد برحلة تشاركية' : ' عادية ',
            e.totalCost.formatPrice,
            e.driverShare.formatPrice,
            e.oilShare.formatPrice,
            e.goldShare.formatPrice,
            e.tiresShare.formatPrice,
            e.gasShare.formatPrice,
            e.agencyShare.formatPrice,
            e.date?.formatDate ?? '-',
          ];
        },
      ).toList(),
    );
  }
}

class LatestTransfers extends StatelessWidget {
  const LatestTransfers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllTransfersCubit, AllTransfersInitial>(
      builder: (context, state) {
        if (state.statuses.isLoading) {
          return MyStyle.loadingWidget();
        }

        if (state.result.isEmpty) return 0.0.verticalSpace;

        return SaedTableWidget(
            filters: const DrawableText(
              text: 'أحدث التحويلات بعد آخر محاسبة\n ',
            ),
            onChangePage: (command) {
              context
                  .read<AllTransfersCubit>()
                  .getAllTransfers(context, command: command);
            },
            title: transfersHeaderTable,
            data: state.result.mapIndexed((index, e) {
              return [
                e.id.toString(),
                e.type?.arabicName,
                e.sourceName,
                e.destinationName,
                e.amount.formatPrice,
                e.status == TransferStatus.closed ? 'تمت' : 'معلقة',
                e.transferDate?.formatDateTime ?? '',
                if (e.type == TransferType.sharedPay || e.type == TransferType.tripPay)
                  TextButton(
                    onPressed: () {
                      if (e.tripId != 0) {
                        context.pushNamed(GoRouteName.tripInfo,
                            queryParams: {'id': e.tripId.toString()});
                      } else {
                        context.pushNamed(
                          GoRouteName.sharedTripInfo,
                          queryParams: {'requestId': e.sharedRequestId.toString()},
                        );
                      }
                    },
                    child: const DrawableText(
                      selectable: false,
                      text: 'عرض الرحلة',
                      color: AppColorManager.mainColor,
                    ),
                  )
                else
                  e.note.isEmpty ? 0.0.verticalSpace : e.note,
              ];
            }).toList());
      },
    );
  }
}
