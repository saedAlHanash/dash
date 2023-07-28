import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_super_user/core/util/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../router/app_router.dart';
import '../../bloc/policy_cubit/policy_cubit.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: MyStyle.alphaLogo,
          padding: MyStyle.pagePadding,
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<PolicyCubit, PolicyInitial>(
                    builder: (context, state) {
                      if (state.statuses == CubitStatuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return DrawableText(
                        text: state.result.policy,
                        size: 14.0.sp,
                      );
                    },
                  ),
                ),
              ),
              if (!AppSharedPreference.isAcceptPolicy)
                MyButton(
                  text: AppStringManager.acceptPolicy,
                  onTap: () {
                    AppSharedPreference.cashAcceptPolicy();

                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteNames.scanPage, (route) => false);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
