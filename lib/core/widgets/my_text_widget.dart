// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../strings/app_color_manager.dart';
// 
//
// class DrawableText extends StatelessWidget {
//   const DrawableText({
//     Key? key,
//     required this.text,
//     this.size,
//     this.fontFamily = FontManager.cairoSemiBold.name,
//     this.color = AppColorManager.mainColor,
//     this.textAlign = TextAlign.start,
//     this.maxLines = 100,
//     this.underLine = false,
//     this.matchParent,
//     this.padding,
//     this.drawableStart,
//     this.drawableEnd,
//     this.drawablePadding,
//     this.maxLength,
//   }) : super(key: key);
//
//   final String text;
//   final double? size;
//   final FontManager fontFamily;
//   final Color color;
//   final TextAlign textAlign;
//   final int maxLines;
//   final int? maxLength;
//   final bool underLine;
//   final bool? matchParent;
//   final EdgeInsets? padding;
//   final Widget? drawableStart;
//   final Widget? drawableEnd;
//   final double? drawablePadding;
//
//   factory DrawableText.header({required String text}) {
//     return DrawableText(
//       text: text,
//       fontFamily: FontManager.cairoBold.name,
//       color: AppColorManager.mainColor,
//       size: 20.sp,
//     );
//   }
//
//   factory DrawableText.title(
//       {required String? text,
//       double? size,
//       Color? color,
//       bool? matchParent,
//       EdgeInsets? padding}) {
//     return DrawableText(
//       text: text ?? '',
//       fontFamily: FontManager.cairoBold.name,
//       color: color ?? AppColorManager.mainColor,
//       size: size ?? 20.0.sp,
//       maxLines: 1,
//       textAlign: TextAlign.center,
//       matchParent: matchParent,
//       padding: padding,
//     );
//   }
//
//   factory DrawableText.titleList({
//     required String text,
//     EdgeInsets? padding,
//     Color? color,
//     Widget? drawableStart,
//     Widget? drawableEnd,
//   }) {
//     return DrawableText(
//       text: text,
//       fontFamily: FontManager.cairoBold.name,
//       color: color ?? AppColorManager.black,
//       size: 20.0.sp,
//       maxLines: 1,
//       matchParent: true,
//       textAlign: TextAlign.start,
//       padding: padding,
//       drawableStart: drawableStart,
//       drawableEnd: drawableEnd,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final text = (maxLength == null || this.text.length <= maxLength!)
//         ? this.text
//         : '${this.text.substring(0, maxLength)}...';
//
//     final textStyle = TextStyle(
//       color: color,
//       fontSize: size ?? 18.0.sp,
//       decoration: underLine ? TextDecoration.underline : null,
//       fontFamily: fontFamily.name,
//       height: 1.5.spMin,
//     );
//
//     late Widget textWidget = Text(
//       text,
//       textAlign: textAlign,
//       maxLines: maxLines,
//       style: textStyle,
//       softWrap: true,
//       overflow: TextOverflow.ellipsis,
//     );
//
//     Widget child = textWidget;
//
//     // if (drawableStart != null && drawableEnd != null) {
//     //   dPadding = EdgeInsets.symmetric(horizontal: drawablePadding ?? 0).w;
//     // } else if (drawableStart != null) {
//     //   dPadding = EdgeInsets.only(right: drawablePadding ?? 0).w;
//     // } else if (drawableEnd != null) {
//     //   dPadding = EdgeInsets.only(left: drawablePadding ?? 0).w;
//     // } else {
//     //   dPadding = EdgeInsets.zero;
//     // }
//
//     if (drawableStart != null || drawableEnd != null) {
//       final childList = <Widget>[];
//
//       if (drawableStart != null) {
//         childList.add(Padding(
//           padding: EdgeInsets.only(right: drawablePadding ?? 0).r,
//           child: drawableStart!,
//         ));
//       }
//
//       if (matchParent ?? false) {
//         textWidget = Expanded(child: textWidget);
//       }
//
//       childList.add(textWidget);
//
//       if (drawableEnd != null) {
//         childList.add(Padding(
//           padding: EdgeInsets.only(left: drawablePadding ?? 0).r,
//           child: drawableEnd!,
//         ));
//       }
//
//       child = Row(
//         mainAxisSize: MainAxisSize.min,
//         children: childList,
//       );
//     }
//
//     return Padding(
//       padding: padding ?? EdgeInsets.zero,
//       child: SizedBox(
//         width: matchParent ?? false ? 1.0.sw : null,
//         child: child,
//       ),
//     );
//   }
// }
