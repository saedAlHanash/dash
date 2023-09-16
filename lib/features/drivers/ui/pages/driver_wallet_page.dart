import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../router/go_route_pages.dart';
import '../../../accounts/bloc/account_amount_cubit/account_amount_cubit.dart';
import '../../../wallet/bloc/my_wallet_cubit/my_wallet_cubit.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key, required this.id, this.isClient}) : super(key: key);

  final int id;

  final bool? isClient;

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late final bool isClient;

  @override
  void initState() {
    isClient = widget.isClient ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletInitial>(
      listenWhen: (previous, current) => current.statuses == CubitStatuses.error,
      listener: (context, state) {
        NoteMessage.showSnakeBar(message: state.error, context: context);
      },
      child: BlocBuilder<WalletCubit, WalletInitial>(
        builder: (context, state) {
          return Column(
            children: [
              if (isClient)
                ItemInfoInLine(
                  title: 'رصيد محفظة الزبون',
                  info: state.result.totalMoney.toString(),
                ),
              if (!isClient)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BlocBuilder<AccountAmountCubit, AccountAmountInitial>(
                      builder: (context, state) {
                        if (state.statuses == CubitStatuses.init) {
                          return 0.0.verticalSpace;
                        }
                        if (state.statuses.isLoading) {
                          return MyStyle.loadingWidget();
                        }
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ItemInfoInLine(
                                  title: 'رصيد السائق لدى الشركة',
                                  info: state.driverAmount.formatPrice,
                                ),
                                ItemInfoInLine(
                                  title: 'رصيد الشركة لدى السائق',
                                  info: state.companyAmount.formatPrice,
                                ),
                              ],
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
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(
                          GoRouteName.debts,
                          queryParams: {'id': widget.id.toString()},
                        );
                        // Navigator.pushNamed(context, RouteNames.debts);
                      },
                      child: DrawableText(
                        text: 'عائدات الرحلات',
                        underLine: true,
                        selectable: false,
                        color: Colors.grey,
                        drawablePadding: 5.0.w,
                        drawableEnd: const Icon(
                          Icons.info_outline,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              10.0.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SaedTableWidget(
                      filters: DrawableText(
                        text: isClient ? 'مشحونات الزبون' : 'شحنات السائق',
                      ),
                      title: const ['المرسل', 'المستقبل', 'القيمة', 'الحالة', 'التاريخ'],
                      data: state.result.chargings.mapIndexed((i, e) {
                        return [
                          e.chargerName.isEmpty ? e.providerName : e.chargerName,
                          e.userName,
                          e.amount.formatPrice,
                          e.status == 0 ? 'غير مكتمل' : 'تم',
                          e.date?.formatDate,
                        ];
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: SaedTableWidget(
                      filters: DrawableText(
                        text: isClient ? 'دفعات الزبون' : 'مدفوعات السائق',
                      ),
                      title: const ['المرسل', 'المستقبل', 'القيمة', 'التاريخ'],
                      data: state.result.transactions.mapIndexed((i, e) {
                        return [
                          e.sourceName,
                          e.destinationName,
                          e.amount.formatPrice,
                          e.transferDate?.formatDate,
                        ];
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
