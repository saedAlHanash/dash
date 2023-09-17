import 'dart:html';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/strings/app_string_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';

import '../../generated/assets.dart';
import '../widgets/images/image_multi_type.dart';
import '../widgets/snake_bar_widget.dart';

class NoteMessage {
  static void showSuccessSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showErrorSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  static void showSnakeBar({
    required String? message,
    required BuildContext? context,
  }) {
    if (context == null) return;
    final snack = SnackBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      content: SnakeBarWidget(text: message ?? ''),
    );

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  static showBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      elevation: null,
      constraints: BoxConstraints(maxWidth: 370.0.w, maxHeight: 550.0.h),
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (builder) => child,
    );
  }

  static Future<bool> showCustomBottomSheet(BuildContext context,
      {required Widget child, Function(bool val)? onCancel}) async {
    final result = await showModalBottomSheet(
      context: context,
      elevation: null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0.r),
          topRight: Radius.circular(16.0.r),
        ),
      ),
      isScrollControlled: true,
      builder: (builder) => ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0.r),
          topRight: Radius.circular(16.0.r),
        ),
        child: Container(
          width: 1.0.sw,
          height: .45.sh,
          color: Colors.white,
          child: child,
        ),
      ),
    );

    var r = (result == null) ? false : result;

    onCancel?.call(r);
    return r;
  }

  static showDoneDialog(BuildContext context,
      {required String text, Function()? onCancel}) async {
    // show the dialog
    await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0.r),
            ),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 150.0.h,
                child: LottieBuilder.asset(Assets.lottiesMochup03Done),
              ),
              10.0.verticalSpace,
              DrawableText(
                text: text,
                size: 16.0.sp,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15).r,
                child: MyButton(
                  text: AppStringManager.done,
                  onTap: () => window.history.back(),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (onCancel != null) {
      onCancel();
    }
  }

  static Future<bool> showConfirm(BuildContext context, {required String text}) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0.r),
            ),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.all(15.0).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DrawableText(
                  text: text,
                  fontFamily: FontManager.cairoBold,
                  color: AppColorManager.mainColorDark,
                ),
                40.0.verticalSpace,
                MyButton(
                  text: AppStringManager.confirm,
                  onTap: () => Navigator.pop(context, true),
                ),
                10.0.verticalSpace,
                MyButton(
                  text: AppStringManager.cancel,
                  onTap: () => Navigator.pop(context, false),
                  color: AppColorManager.black,
                ),
                20.0.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
    return (result ?? false);
  }

  static Future<bool> showMyDialog(BuildContext context,
      {required Widget child, Function(dynamic val)? onCancel}) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          clipBehavior: Clip.hardEdge,
          child: Container(
            width: 0.6.sw,
            padding: const EdgeInsets.all(20.0).r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0.r),
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: child,
          ),
        );
      },
    );
    return (result ?? false);
  }

  static Future<bool> showImageDialog(
    BuildContext context, {
    required String image,
  }) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0.r),
            ),
          ),
          elevation: 0.0,
          clipBehavior: Clip.hardEdge,
          child: ImageMultiType(
            width: 800.0.w,
            height: 1.0.sh,
            url: image,
            fit: BoxFit.fill,
          ),
        );
      },
    );
    return (result ?? false);
  }
}
