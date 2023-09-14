import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/features/accounts/data/response/transfers_response.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/widgets/my_card_widget.dart';

class ItemTransfer extends StatelessWidget {
  const ItemTransfer({super.key, required this.item});

  final Transfer item;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DrawableText(
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: 'ID',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: 'النوع',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: 'المرسل',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: 'المستقبل',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: 'المبلغ',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: 'الحالة',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: 'التاريخ',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: DrawableText(
                        matchParent: true,
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.id.toString(),
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        matchParent: true,
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.sharedRequestId != 0 ? 'تشاركي' : 'عادي',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        matchParent: true,
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.sourceName,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        matchParent: true,
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.destinationName,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        matchParent: true,
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.amount.formatPrice,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        matchParent: true,
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.status == 1 ? 'تمت' : 'معلقة',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        matchParent: true,
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.transferDate?.formatDateTime ?? '',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
