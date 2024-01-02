import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/util/my_style.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/wallet/data/response/wallet_response.dart';

import '../../../../core/widgets/not_found_widget.dart';

class PayedListWidget extends StatelessWidget {
  const PayedListWidget({Key? key, required this.wallet, required this.isClient})
      : super(key: key);
  final WalletResult wallet;
  final bool isClient;

  @override
  Widget build(BuildContext context) {
    final list = wallet.transactions;
    if (list.isEmpty) {
      return const NotFoundWidget(text: 'لا يوجد معلومات');
    }
    return SizedBox(
      height: 300.0.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, i) {
          final item = list[i];
          return ItemPayed(
            item: item,
            isClient: isClient,
          );
        },
      ),
    );
  }
}

class ItemPayed extends StatelessWidget {
  const ItemPayed({Key? key, required this.item, required this.isClient})
      : super(key: key);
  final Transaction item;

  final bool isClient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyStyle.outlineBorder,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0).r,
      margin: const EdgeInsets.symmetric(vertical: 2.0).r,
      child: Row(
        children: [
          if (isClient)
            DrawableText(
              text: (item.sharedRequestId != 0) ? 'رحلة تشاركية:' : 'رحلة عادية:',
              fontFamily: FontManager.cairoBold.name,
              color: AppColorManager.black,
            ),
          5.0.horizontalSpace,
          Expanded(
            child: DrawableText(
              text: '${item.amount}',
              size: 25.0.sp,
              color: AppColorManager.red,
              matchParent: true,
              drawableStart: const Icon(
                Icons.arrow_downward,
                color: AppColorManager.red,
              ),
              drawableEnd: DrawableText(
                color: AppColorManager.gray,
                text: item.transferDate?.formatDateTime ?? '',
              ),
              drawableAlin: DrawableAlin.between,
            ),
          ),
        ],
      ),
    );
  }
}
