import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../generated/assets.dart';
import '../strings/app_color_manager.dart';
import '../strings/app_string_manager.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LottieBuilder.asset(Assets.lottiesError),
        DrawableText(
          text: text,
          size: 22.0.sp,
          color: AppColorManager.black,
        )
      ],
    );
  }
}
