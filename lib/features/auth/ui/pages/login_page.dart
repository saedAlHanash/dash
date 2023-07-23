import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/core/widgets/app_bar_widget.dart';
import 'package:qareeb_dash/router/go_route_pages.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../bloc/login_cubit/login_cubit.dart';
import '../../data/request/login_request.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email = '';
  var password = '';

  var isLoading = true;

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (AppSharedPreference.isLogin) {
          context.pushNamed(GoRouteName.homePage);
        } else {
          setState(() => isLoading = false);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return MyStyle.loadingWidget();
    return BlocListener<LoginCubit, LoginInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (_, state) => context.pushNamed(GoRouteName.homePage),
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: MyStyle.pagePadding,
          margin: EdgeInsets.symmetric(horizontal: 0.2.sw),
          alignment: Alignment.center,
          child: MyCardWidget(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const DrawableText(
                  text: AppStringManager.login,
                  fontFamily: FontManager.cairoBold,
                  color: AppColorManager.mainColor,
                ),
                10.0.verticalSpace,
                MyTextFormWidget(
                  liable: AppStringManager.enterEmail,
                  textAlign: TextAlign.left,
                  initialValue: email,
                  onChanged: (val) => email = val,
                ),
                MyTextFormWidget(
                  liable: AppStringManager.enterPassword,
                  textAlign: TextAlign.left,
                  obscureText: true,
                  initialValue: password,
                  onChanged: (val) => password = val,
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
                        final request = LoginRequest(email: email, password: password);
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
