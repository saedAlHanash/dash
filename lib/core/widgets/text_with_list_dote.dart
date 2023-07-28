import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';

class TextWithListDote extends StatelessWidget {
  const TextWithListDote(
      {Key? key, required this.testWidget, this.matchParent, this.color, this.alignment})
      : super(key: key);

  final Widget testWidget;
  final bool? matchParent;
  final CrossAxisAlignment? alignment;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (matchParent ?? false) ? 1.0.sw : null,
      child: Row(
        crossAxisAlignment: alignment ?? CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          DrawableText(
            text: '.',
            size: 40.0.sp,
            padding: const EdgeInsets.only(left: 10.0).w,
            color: color ?? AppColorManager.mainColor,
          ),
          5.0.horizontalSpace,
          Expanded(child: testWidget),
        ],
      ),
    );
  }
}
