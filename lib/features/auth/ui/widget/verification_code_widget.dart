import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/strings/app_color_manager.dart';

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({Key? key, this.onCompleted, this.onChange}) : super(key: key);
  final Function(String)? onCompleted;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: AppColorManager.black,
      fontFamily: FontManager.cairoBold.name,
      fontSize: 20.0.sp,
    );

    final defaultPinTheme = PinTheme(
      width: 70.0.spMin,
      height: 70.0.spMin,
      textStyle: textStyle,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0.r),
        color: AppColorManager.whit,
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 6,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        defaultPinTheme: defaultPinTheme,
        onCompleted: onCompleted,
        onChanged: onChange,
      ),
    );
  }
}
