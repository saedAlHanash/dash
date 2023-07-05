import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({
    Key? key,
    required this.title,
    this.info,
    this.widget,
  }) : super(key: key);

  final String title;
  final String? info;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawableText(
          text: title,
          color: Colors.black,
        ),
        if (widget == null)
          DrawableText(
            text: info ?? '',
            fontFamily: FontManager.cairoBold,
            color: AppColorManager.mainColor,
            padding: const EdgeInsets.only(right: 10.0, bottom: 25.0, top: 7.0).r,
          ),
        if (widget != null) widget!
      ],
    );
  }
}

class ItemInfoInLine extends StatelessWidget {
  const ItemInfoInLine({
    Key? key,
    required this.title,
    this.info,
    this.widget,
  }) : super(key: key);

  final String title;
  final String? info;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: '$title:  ',
      color: Colors.black,
      size: 20.0.sp,
      drawablePadding: 5.0.w,
      drawableEnd: widget == null
          ? DrawableText(
              text: info ?? '',
              size: 20.0.sp,
              fontFamily: FontManager.cairoBold,
              color: AppColorManager.mainColor,
            )
          : widget!,
    );
  }
}
