import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_super_user/core/widgets/app_bar_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../router/app_router.dart';
import '../../bloc/login_cubit/login_cubit.dart';
import '../../data/request/login_request.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final request = LoginRequest();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (_, state) => Navigator.pushNamed(context, RouteNames.scanPage),
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: MyStyle.alphaLogo,
          padding: MyStyle.pagePadding,
          alignment: Alignment.center,
          child: MyCardWidget(
            margin: const EdgeInsets.only(bottom: 86.0).h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DrawableText(
                  text: AppStringManager.login,
                  size: 20.0.sp,
                  fontFamily: FontManager.cairoBold,
                  color: AppColorManager.mainColor,
                ),
                10.0.verticalSpace,
                MyTextFormWidget(
                  // icon: Assets.icons963,
                  label: AppStringManager.userName,
                  textAlign: TextAlign.right,
                  initialValue: request.userNameOrEmailAddress,
                  onChanged: (val) => request.userNameOrEmailAddress = val,
                ),
                10.0.verticalSpace,
                MyTextFormWidget(
                  // icon: Assets.icons963,
                  label: AppStringManager.password,
                  textAlign: TextAlign.right,
                  initialValue: request.password,
                  onChanged: (val) => request.password = val,
                ),
                10.0.verticalSpace,
                BlocBuilder<LoginCubit, LoginInitial>(
                  builder: (_, state) {
                    if (state.statuses == CubitStatuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      text: AppStringManager.login,
                      onTap: () {
                        context.read<LoginCubit>().login(context, request: request);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
