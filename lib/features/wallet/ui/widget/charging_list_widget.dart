import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../data/response/wallet_response.dart';

class ChargingListWidget extends StatelessWidget {
  const ChargingListWidget({Key? key, required this.wallet}) : super(key: key);
  final WalletResult wallet;

  @override
  Widget build(BuildContext context) {
    final list = wallet.chargings;
        if(list.isEmpty){
              return const NotFoundWidget(text: 'لا يووجد معلومات');
            }
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        final item = list[i];
        return ItemCharging(item: item);
      },
    );
  }
}

class ItemCharging extends StatelessWidget {
  const ItemCharging({Key? key, required this.item}) : super(key: key);
  final Charging item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyStyle.outlineBorder,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0).r,
      margin: const EdgeInsets.symmetric(vertical: 2.0).r,
      child: Row(
        children: [
          Expanded(
            child: DrawableText(
              text: '${item.amount}',
              color: AppColorManager.mainColorDark,
              matchParent: true,
              drawableStart: const Icon(
                Icons.arrow_upward,
                color: AppColorManager.mainColorDark,
              ),
              drawableEnd: DrawableText(
                color: AppColorManager.gray,
                drawableAlin: DrawableAlin.between,
                text: item.date?.formatDateTime ?? '',
                size: 14.0.spMin,
              ),
              drawableAlin: DrawableAlin.between,
            ),
          ),
        ],
      ),
    );
  }
}
