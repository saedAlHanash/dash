import 'dart:html';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/bloc/home1_cubit/home1_cubit.dart';
import '../strings/app_color_manager.dart';
import 'images/image_multi_type.dart';
import 'logo_text.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key, this.actions, this.text}) : super(key: key);

  final List<Widget>? actions;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Home1Cubit, Home1Initial>(
      builder: (context, state) {
        return SafeArea(
          child: AppBar(
            elevation: 0.0,
            toolbarHeight: 80.0.h,
            centerTitle: true,
            title: text == null
                ? DrawableText(
                    text: state.result.name,
                    fontFamily: FontManager.cairoBold,
                  )
                : DrawableText(
                    text: text!,
                    fontFamily: FontManager.cairoBold,
                  ),
            backgroundColor: AppColorManager.f1,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                child: ImageMultiType(
                  url: state.result.imageUrl,
                ),
              )
            ],
            leading: context.canPop()
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
      },
    );
  }

  @override
  Size get preferredSize => Size(1.0.sw, 80.0.h);
}
