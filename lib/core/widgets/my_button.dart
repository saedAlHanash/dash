import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    this.child,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.textColor,
    this.width,
    this.active = true,
    this.margin,
  }) : super(key: key);

  final Widget? child;
  final String text;
  final Color? textColor;
  final Color? color;
  final double? elevation;
  final double? width;
  final bool active;
  final EdgeInsets? margin;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final child = this.child ??
        DrawableText(
          text: text,
          color: textColor ?? AppColorManager.whit,
          fontFamily: FontManager.cairoBold,
          size: 17.0.sp,
        );

    var widget = InkWell(
        onTap: active ? onTap : null,
        borderRadius: BorderRadius.circular(15.0.r),
        child: GradientContainer(
          width: width,
          color: active ? color : AppColorManager.gray.withOpacity(0.6),
          elevation: elevation,
          margin: margin,
          child: child,
        ));

    return widget;
  }
}

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    Key? key,
    this.child,
    this.width,
    this.wrapHeight = false,
    this.color,
    this.elevation,
    this.radios,
    this.margin,
  }) : super(key: key);
  final Widget? child;
  final double? width;
  final Color? color;
  final EdgeInsets? margin;
  final double? elevation;
  final double? radios;
  final bool wrapHeight;

  @override
  Widget build(BuildContext context) {
    final height = !wrapHeight ? 48.0.h : null;

    final LinearGradient? gradient;

    if (color == null) {
      gradient = LinearGradient(
        colors: [
          AppColorManager.mainColorLight,
          AppColorManager.mainColor,
          AppColorManager.mainColorDark.withOpacity(0.8),
        ],
        // radius: 10
      );
    } else {
      gradient = null;
    }

    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(radios ?? 15.0.r),
        gradient: gradient,
        color: color,
        boxShadow: [
          BoxShadow(
            color: elevation == 0
                ? Colors.transparent
                : AppColorManager.gray.withOpacity(0.4),
            offset: Offset(0, 2.0.h),
            blurRadius: elevation ?? 0,
          )
        ]);

    return Wrap(
      children: [
        Container(
          height: height,
          width: width ?? 314.0.w,
          margin: margin,
          decoration: decoration,
          child: Align(
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ],
    );
  }
}
