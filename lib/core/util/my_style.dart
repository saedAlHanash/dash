import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';
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

  static Widget loadingWidget({Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  static get alphaLogo => const BoxDecoration(
      );

  static get alphaMap => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.iconsMapBackgroundAlpha),
          fit: BoxFit.cover,
        ),
      );

  static var lightShadowUp = [
    BoxShadow(
        color: AppColorManager.gray.withOpacity(0.5),
        blurRadius: 5,
        offset: const Offset(0, -2))
  ];

  static var allShadow = [
    BoxShadow(
      color: AppColorManager.gray.withOpacity(0.5),
      blurRadius: 10,
    )
  ];
  static var allShadowDark = [
    BoxShadow(
      color: AppColorManager.gray.withOpacity(0.6),
      blurRadius: 10.spMin,
    )
  ];

  static final formBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColorManager.f1.withOpacity(0.27),
      ),
      borderRadius: BorderRadius.circular(10.0.r));

  static final hintStyle = TextStyle(
    fontFamily: FontManager.cairoBold.name,
    fontSize: 16.0.sp,
    color: AppColorManager.gray.withOpacity(0.6),
  );
  static final textFormTextStyle = TextStyle(
    fontFamily: FontManager.cairoBold.name,
    fontSize: 16.0.sp,
    color: AppColorManager.black,
  );

  static var roundBox = BoxDecoration(
    color: AppColorManager.whit,
    borderRadius: BorderRadius.circular(10.0.r),
    boxShadow: [
      BoxShadow(
        color: AppColorManager.black.withOpacity(0.1),
        offset: Offset(0, 4.h),
        blurRadius: 20,
      )
    ],
  );

  static var roundBoxGray = BoxDecoration(
    color: AppColorManager.f1,
    borderRadius: BorderRadius.circular(6.0.r),
  );

  static var roundBox15 = BoxDecoration(
    color: AppColorManager.whit,
    borderRadius: BorderRadius.circular(15.0.r),
    boxShadow: MyStyle.lightShadow,
  );

  static var outlineBorder = BoxDecoration(
      border: Border.all(color: AppColorManager.f1),
      borderRadius: BorderRadius.circular(12.0.r),
      color: Colors.white);
}
