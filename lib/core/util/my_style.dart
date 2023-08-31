import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';

class MyStyle {
  //region number style

  static final double cardRadios = 10.0.r;

  //endregion

//region margin/padding
  static final cardPadding = EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h);

  static final pagePadding = EdgeInsets.symmetric(horizontal: 31.w, vertical: 8.h);

//endregion

  static const underLineStyle =
      TextStyle(fontStyle: FontStyle.italic, decoration: TextDecoration.underline);

  static var drawerShape = ShapeDecoration(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: AppColorManager.mainColor.withOpacity(0.9));

  static var normalShadow = [
    BoxShadow(
        color: AppColorManager.gray.withOpacity(0.6),
        blurRadius: 15,
        offset: const Offset(0, 5))
  ];

  static var lightShadow = [
    BoxShadow(
        color: AppColorManager.gray.withOpacity(0.3),
        blurRadius: 7,
        offset: const Offset(0, 2))
  ];
  static var topShadow = [
    BoxShadow(
        color: AppColorManager.gray.withOpacity(0.3),
        blurRadius: 15,
        offset: const Offset(0, -2))
  ];

  static paymentBox({required String image}) {
    return BoxDecoration(
      color: AppColorManager.whit,
      boxShadow: MyStyle.lightShadow,
      image: DecorationImage(image: AssetImage(image)),
      borderRadius: BorderRadius.circular(10.0.r),
    );
  }

  static Widget loadingWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  static var outlineBorder = BoxDecoration(
      border: Border.all(color: AppColorManager.gray),
      borderRadius: BorderRadius.circular(12.0.r),
      color: Colors.white);

}
