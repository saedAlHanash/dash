import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_super_user/core/strings/app_color_manager.dart';
import 'package:qareeb_super_user/core/strings/app_string_manager.dart';
import 'package:qareeb_super_user/core/util/checker_helper.dart';
import 'package:qareeb_super_user/core/widgets/my_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../generated/assets.dart';
import '../../router/app_router.dart';
import '../widgets/images/image_multi_type.dart';
import '../widgets/my_text_form_widget.dart';
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
    required BuildContext context,
  }) {
    final snack = SnackBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      content: SnakeBarWidget(text: message ?? ''),
    );

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  static showBottomSheetDrawer(BuildContext context, {required Widget child}) {
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

  static showCustomBottomSheet(BuildContext context, {required Widget child}) async {
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
          color: Colors.white,
          child: child,
        ),
      ),
    );

    var r = (result == null) ? false : result;

    return r;
  }

  static showPayAmountBottomSheet(BuildContext context,
      {required Function(num? amount) onCancel}) async {
    var text = '';
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
          height: 0.5.sh,
          color: Colors.white,
          padding: const EdgeInsets.all(20.0).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyEditTextWidget(
                hint: 'قيمة المبلغ المراد شحنه',
                onChanged: (val) => text = val,
                keyBordType: TextInputType.number,
              ),
              MyButton(
                text: 'متابعة',
                onTap: () {
                  if (text.isEmpty) return;

                  Navigator.pop(context, true);
                },
              )
            ],
          ),
        ),
      ),
    );

    var r = (result == null) ? false : result;

    if (r) {
      onCancel.call(num.parse(text));
    }
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
                  onTap: () => Navigator.pop(context),
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

  static Future<String?> insertPhoneNumber(
    BuildContext context,
  ) async {
    // show the dialog

    String phone = '';
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
          child: Padding(
            padding: const EdgeInsets.all(25.0).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DrawableText.title(text: 'رقم الهاتف'),
                MyTextFormWidget(
                  maxLength: 10,
                  icon: const ImageMultiType(
                    url: Assets.icons963,
                    height: 10.0,
                    width: 10.0,
                  ),
                  // icon: Assets.icons963,
                  keyBordType: TextInputType.phone,
                  label: AppStringManager.enterPhone,
                  textAlign: TextAlign.right,
                  onChanged: (val) => phone = val,
                ),
                MyButton(
                  text: AppStringManager.done,
                  onTap: () => Navigator.pop(context, true),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (context.mounted) {
      return checkPhoneNumber(context, phone);
    } else {
      return null;
    }
  }

  static Future<bool> showConfirm(BuildContext context,
      {required String text, Function(bool val)? onCancel}) async {
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
                  size: 20.0.sp,
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
    onCancel?.call(result ?? false);
    return (result ?? false);
  }

  static Future<bool> showMyDialog(BuildContext context,
      {required Widget child, bool? callable}) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      barrierDismissible: callable ?? true,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0.r),
            ),
          ),
          insetPadding: const EdgeInsets.all(20.0).r,
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: SingleChildScrollView(
            child: child,
          ),
        );
      },
    );
    return (result ?? false);
  }
}
