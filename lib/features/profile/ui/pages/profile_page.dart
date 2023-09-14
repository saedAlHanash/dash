import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/core/widgets/app_bar_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/images/circle_image_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/top_title_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../router/app_router.dart';
import '../../bloc/profile_info_cubit/profile_info_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileInfoCubit>().getProfileInfo(context, newData: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyButton(
            elevation: 2.0,
            onTap: () async {
              await Navigator.pushNamed(context, RouteNames.updateProfilePage);
              if (!mounted) return;
              context.read<ProfileInfoCubit>().getProfileInfo(context, newData: true);
            },
            text: AppStringManager.editProfile,
          ),
          15.0.verticalSpace,
          MyButton(
            color: AppColorManager.lightGray,
            elevation: 2.0,
            onTap: () async {
              final result =
                  await NoteMessage.showConfirm(context, text: 'تأكيد تسجيل الخروج');

              if (result && context.mounted) {
                AppSharedPreference.logout();
                Navigator.popUntil(context, (route) => false);
                Navigator.pushNamed(context, RouteNames.authPage);
              }
            },
            child: const DrawableText(
              text: AppStringManager.logout,
              color: AppColorManager.red,
            ),
          ),
          20.0.verticalSpace,
        ],
      ),
      body: BlocBuilder<ProfileInfoCubit, ProfileInfoInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) return MyStyle.loadingWidget();

          final result = state.result;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
            child: Column(
              children: [
                const TopTitleWidget(
                  text: AppStringManager.profile,
                  icon: Assets.iconsPerson,
                ),
                5.0.verticalSpace,
                CircleImageWidget(url: result.avatar),
                10.0.verticalSpace,
                MyTextFormNoLabelWidget(
                  label: 'الاسم',
                  enable: false,
                  initialValue: result.fullName,
                ),
                MyTextFormNoLabelWidget(
                  label: 'العنوان',
                  enable: false,
                  initialValue: result.address,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormNoLabelWidget(
                        label: 'الجنس',
                        enable: false,
                        initialValue: result.gender == 0 ? 'ذكر' : 'أنثى',
                      ),
                    ),
                    7.0.horizontalSpace,
                    Expanded(
                      child: MyTextFormNoLabelWidget(
                        label: 'الفئة العمرية',
                        enable: false,
                        initialValue: result.ageRange,
                      ),
                    ),
                    7.0.horizontalSpace,
                    Expanded(
                      child: MyTextFormNoLabelWidget(
                        label: 'رقم الهاتف',
                        enable: false,
                        initialValue: result.phoneNumber,
                      ),
                    ),
                  ],
                ),
                10.0.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
