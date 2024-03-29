import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:universal_html/html.dart";

import '../strings/app_color_manager.dart';
import 'logo_text.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key, this.actions, this.text}) : super(key: key);

  final List<Widget>? actions;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.green),
        toolbarHeight: 80.0.h,
        title: text == null
            ? const LogoText()
            : DrawableText(
                text: text!,
                fontFamily: FontManager.cairoBold.name,
              ),
        backgroundColor: AppColorManager.f1,
        actions: actions,
        leading: window.history.length != 0
            ? IconButton(
                onPressed: () => window.history.back(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColorManager.mainColorDark,
                ),
              )
            : 0.0.verticalSpace,
      ),
    );
  }

  @override
  Size get preferredSize => Size(1.0.sw, 80.0.h);
}
