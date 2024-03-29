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
            fontFamily: FontManager.cairoBold.name,
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
    this.info = '',
    this.widget,
  }) : super(key: key);

  final String title;
  final String info;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: '$title \t',
      color: Colors.black,
      size: 22.0.sp,
      selectable: false,
      padding: const EdgeInsets.only(right: 10.0, bottom: 15.0, top: 3.0).r,
      drawablePadding: 5.0.w,
      fontFamily: FontManager.cairoBold.name,
      drawableEnd: widget == null
          ? Directionality(
              textDirection: TextDirection.ltr,
              child: DrawableText(
                text: info.isEmpty ? '-' : info,
                size: 24.0.sp,
                selectable: false,
                fontFamily: FontManager.cairoBold.name,
                color: AppColorManager.mainColor,
              ),
            )
          : widget!,
    );
  }
}
