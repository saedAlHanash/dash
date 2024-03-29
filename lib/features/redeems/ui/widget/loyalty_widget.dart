import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import "package:universal_html/html.dart";

import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../home/ui/widget/statistics_widget.dart';
import '../../bloc/create_redeem_cubit/create_redeem_cubit.dart';
import '../../bloc/redeems_cubit/redeems_cubit.dart';
import '../../bloc/redeems_history_cubit/redeems_history_cubit.dart';
import '../../data/request/redeem_request.dart';

class LoyaltyWidget extends StatelessWidget {
  const LoyaltyWidget({super.key, this.driverId});

  final int? driverId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<RedeemsCubit, RedeemsInitial>(
          builder: (context, state) {
            if (state.statuses.isLoading) {
              return MyStyle.loadingWidget();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (driverId == null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MyGridWidget(
                      columnCount: 5,
                      children: [
                        StatisticsCard(
                          icon: Assets.iconsPath,
                          label: 'الكيلو مترات',
                          value: (state.result.totalMeters / 1000).round(),
                        ),
                        StatisticsCard(
                          icon: Assets.iconsCoins,
                          label: 'المليون',
                          value: state.result.goldCount,
                        ),
                        StatisticsCard(
                          icon: Assets.iconsOil,
                          label: 'زيت',
                          value: state.result.oilCount,
                        ),
                        StatisticsCard(
                          icon: Assets.iconsTires,
                          label: 'إطارات',
                          value: state.result.tiresCount,
                        ),
                        StatisticsCard(
                          icon: Assets.iconsGas,
                          label: 'بنزين',
                          value: state.result.gasCount,
                        ),
                      ],
                    ),
                  )
                else ...[
                  _TotalWidget(text: state.result.totalMeters, driverId: state.driverId),
                  ItemLoyal(
                    driverId: state.driverId,
                    text: 'المليون',
                    count: state.result.goldCount,
                    type: RedeemType.gold,
                    oldCount: state.result.goldOldCount,
                    p: state.result.goldPCount,
                  ),
                  ItemLoyal(
                    driverId: state.driverId,
                    text: 'زيت',
                    count: state.result.oilCount,
                    type: RedeemType.oil,
                    oldCount: state.result.oilOldCount,
                    p: state.result.oilPCount,
                  ),
                  ItemLoyal(
                    driverId: state.driverId,
                    text: 'إطارات',
                    count: state.result.tiresCount,
                    type: RedeemType.tire,
                    oldCount: state.result.tiresOldCount,
                    p: state.result.tiresPCount,
                  ),
                  ItemLoyal(
                    driverId: state.driverId,
                    text: 'بنزين',
                    count: state.result.gasCount,
                    type: RedeemType.gas,
                    oldCount: state.result.gasOldCount,
                    p: state.result.gasPCount,
                  ),
                ],
              ],
            );
          },
        ),
        if (driverId != null) 30.0.verticalSpace,
        if (driverId != null)
          BlocBuilder<RedeemsHistoryCubit, RedeemsHistoryInitial>(
            builder: (context, state) {
              if (state.statuses.isLoading) {
                return MyStyle.loadingWidget();
              }

              final list = state.result;

              return SaedTableWidget(
                fullHeight: 1.8.sh,
                title: const [
                  'ID ',
                  'نوع العملية',
                  'محصلة المجمع',
                  'عدد الأمتار',
                  'تاريخ العملية',
                ],
                data: list
                    .mapIndexed(
                      (index, e) => [
                        e.id,
                        e.type.arabicName,
                        e.aggregatedMoney.formatPrice,
                        e.meters,
                        e.redeemDate,
                      ],
                    )
                    .toList(),
              );
            },
          ),
      ],
    );
  }
}

class ItemLoyal extends StatelessWidget {
  const ItemLoyal(
      {super.key,
      required this.text,
      required this.count,
      required this.type,
      required this.driverId,
      required this.oldCount,
      required this.p});

  final String text;
  final int count;
  final int oldCount;
  final int driverId;
  final double p;
  final RedeemType type;

  @override
  Widget build(BuildContext context) {
    var url = '';
    switch (type) {
      case RedeemType.gold:
        url = Assets.iconsCoins;
        break;
      case RedeemType.oil:
        url = Assets.iconsOil;
        break;
      case RedeemType.tire:
        url = Assets.iconsTires;
        break;
      case RedeemType.gas:
        url = Assets.iconsGas;
        break;
    }
    return MyCardWidget(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: Row(
        children: [
          Expanded(
            child: DrawableText(
              text: text,
              color: Colors.black,
              fontFamily: FontManager.cairoBold.name,
              drawablePadding: 10.0.w,
              drawableAlin: DrawableAlin.withText,
              matchParent: true,
              textAlign: TextAlign.start,
              drawableStart: ImageMultiType(
                url: url,
                width: 35.0.r,
                height: 35.0.r,
              ),
            ),
          ),
          Expanded(
            child: DrawableText(
              text: 'تم استبدال : $oldCount',
              color: Colors.black,
              fontFamily: FontManager.cairoBold.name,
            ),
          ),
          if (driverId != 0)
            Expanded(
              child: DrawableText(
                text: 'يمكن استبدال : $count',
                color: Colors.black,
                fontFamily: FontManager.cairoBold.name,
              ),
            ),
          if (driverId != 0)
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: DrawableText(
                  text: '$p %',
                  textAlign: TextAlign.center,
                  matchParent: true,
                  color: Colors.black,
                  fontFamily: FontManager.cairoBold.name,
                ),
              ),
            ),
          if (driverId != 0)
            if (isQareebAdmin)
              Expanded(
                child: BlocConsumer<CreateRedeemCubit, CreateRedeemInitial>(
                  listenWhen: (p, c) => c.statuses.done,
                  listener: (context, state) {
                    NoteMessage.showDoneDialog(
                      context,
                      text: 'تم بنجاح',
                      onCancel: () => window.history.back(),
                    );
                  },
                  buildWhen: (p, c) => c.request.type == type,
                  builder: (context, state) {
                    if (state.statuses.isLoading) {
                      return MyStyle.loadingWidget();
                    }
                    if (state.statuses.isDone) {
                      return CircleButton(
                        color: Colors.green,
                        size: 30.0.spMin,
                        icon: Icons.check_circle_outline,
                      );
                    }
                    return MyButton(
                      text: 'استبدال',
                      active: count > 0,
                      onTap: () {
                        final request = RedeemRequest(driverId: driverId, type: type);
                        context.read<CreateRedeemCubit>().createRedeem(
                              context,
                              request: request,
                            );
                      },
                    );
                  },
                ),
              ),
        ],
      ),
    );
  }
}

class _TotalWidget extends StatelessWidget {
  const _TotalWidget({
    required this.text,
    required this.driverId,
  });

  final num text;
  final int driverId;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: Row(
        children: [
          Expanded(
            child: DrawableText(
              text: 'الكيلو مترات',
              color: Colors.black,
              fontFamily: FontManager.cairoBold.name,
              drawablePadding: 10.0.w,
              drawableStart: ImageMultiType(
                url: Assets.iconsPath,
                width: 35.0.r,
                height: 35.0.r,
              ),
            ),
          ),
          Expanded(
            child: DrawableText(
              text: '${(text / 1000).round()} (كيلو متر)',
              color: Colors.black,
              fontFamily: FontManager.cairoBold.name,
            ),
          ),
        ],
      ),
    );
  }
}
