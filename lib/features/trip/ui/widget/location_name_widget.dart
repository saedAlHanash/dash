import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_color_manager.dart';
import 'package:image_multi_type/image_multi_type.dart';
import '../../../../generated/assets.dart';

class LocationNameWidget extends StatelessWidget {
  const LocationNameWidget({
    Key? key,
    required this.isStart,
    required this.name,
  }) : super(key: key);
  final bool isStart;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0).r,
      margin:
      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0).r,
      decoration: BoxDecoration(
        color: AppColorManager.whit,
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: DrawableText(
        text: name,
        matchParent: true,
        color: AppColorManager.black,
        size: 18.0.sp,
        fontFamily: FontManager.cairoBold,
        drawablePadding: 15.0.w,
        drawableStart:  ImageMultiType(url:
          isStart ? Assets.iconsMarkerStart : Assets.iconsMarkerEnd,
          width: 40.0.w,
          height: 40.0.h,
        ),
      ),
    );
  }
}
