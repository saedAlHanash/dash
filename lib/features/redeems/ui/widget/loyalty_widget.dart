import 'dart:html';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/images/image_multi_type.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../bloc/create_redeem_cubit/create_redeem_cubit.dart';
import '../../bloc/redeems_cubit/redeems_cubit.dart';
import '../../data/request/redeem_request.dart';
class LoyaltyWidget extends StatelessWidget {
  const LoyaltyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RedeemsCubit, RedeemsInitial>(
      builder: (context, state) {
        if (state.statuses.isLoading) {
          return MyStyle.loadingWidget();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawableText(
              text: 'برنامج الولاء',
              matchParent: true,
              size: 28.0.sp,
              textAlign: TextAlign.center,
              padding: const EdgeInsets.symmetric(vertical: 15.0).h,
            ),
            _TotalWidget(text: state.result.totalMeters),
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
          ],
        );
      },
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
        url = Assets.iconsGold;
        break;
      case RedeemType.oil:
        url = Assets.iconsOil;
        break;
      case RedeemType.tire:
        url = Assets.iconsTires;
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
              fontFamily: FontManager.cairoBold,
              drawablePadding: 10.0.w,
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
              fontFamily: FontManager.cairoBold,
            ),
          ),
          if (driverId != 0)
            Expanded(
              child: DrawableText(
                text: 'يمكن استبدال : $count',
                color: Colors.black,
                fontFamily: FontManager.cairoBold,
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
                  fontFamily: FontManager.cairoBold,
                ),
              ),
            ),
          if (driverId != 0)
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
  });

  final num text;

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
              fontFamily: FontManager.cairoBold,
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
              fontFamily: FontManager.cairoBold,
            ),
          ),
        ],
      ),
    );
  }
}
