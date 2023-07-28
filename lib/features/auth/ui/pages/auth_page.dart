import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_super_user/core/strings/app_color_manager.dart';
import 'package:qareeb_super_user/core/widgets/app_bar_widget.dart';
import 'package:qareeb_super_user/core/widgets/images/image_multi_type.dart';
import 'package:qareeb_super_user/core/widgets/my_button.dart';
import 'package:qareeb_super_user/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: MyStyle.alphaLogo,
        padding: MyStyle.pagePadding,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            0.0.verticalSpace,
            Column(
              children: [
                ImageMultiType(
                  url: Assets.iconsLogoWithText,
                  width: 200.0.w,
                  height: 170.0.h,
                ),
                35.0.verticalSpace,
                MyButton(
                  width: 295.w,
                  text: AppStringManager.login,
                  onTap: () => Navigator.pushNamed(context, RouteNames.loginScreen),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const DrawableText(
                  text: 'بالمتابعة أنت توافق على',
                  color: AppColorManager.mainColorDark,
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    RouteNames.policyScreen,
                  ),
                  child: const DrawableText(
                    text: 'سياسة الخصوصية',
                    underLine: true,
                    color: AppColorManager.mainColorDark,
                    fontFamily: FontManager.cairoBold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
