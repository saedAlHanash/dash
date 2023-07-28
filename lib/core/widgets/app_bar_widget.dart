import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qareeb_super_user/core/strings/app_color_manager.dart';
import 'package:qareeb_super_user/core/widgets/logo_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key, this.actions}) : super(key: key);

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        elevation: 0.0,
        title: const LogoText(),
        centerTitle: true,
        toolbarHeight: 80.0.h,
        backgroundColor: AppColorManager.f1,
        actions: actions,
        leading: Navigator.canPop(context)
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                  color: AppColorManager.mainColorDark,
                ))
            : 0.0.verticalSpace,
      ),
    );
  }

  @override
  Size get preferredSize => Size(1.0.sw, 80.0.h);
}
