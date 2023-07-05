import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'my_button.dart';

class SnakeBarWidget extends StatelessWidget {
  const SnakeBarWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final padding =
        EdgeInsets.symmetric(vertical: 0.01.sh, horizontal: 0.02.sw);

    const icon = Icon(
      Icons.cancel,
      color: Colors.white,
    );

    final textWidget = DrawableText(
      text: text,
      fontFamily: FontManager.cairoBold,
      size: 14.0.sp,
      color: Colors.white,
    );

    return GradientContainer(
      width: 0.9.sw,
      wrapHeight: true,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [textWidget, icon],
        ),
      ),
    );
  }
}
